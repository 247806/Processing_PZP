PFont font1, font2; // Dwa zewnętrzne fonty
ArrayList<TextElement> textElements;  // Lista przechowująca tekst i jego właściwości
float currentSize;  // Domyślny rozmiar tekstu
PFont currentFont;  // Aktualnie wybrany font
int topMargin = 20, bottomMargin = 10, sideMargin = 20;  // Marginesy
float scrollOffset = 0;  // Przewijanie tekstu
ArrayList<FontButton> fontButtons;  // Przycisk wyboru fontów
ArrayList<SizeButton> sizeButtons;  // Przycisk wyboru rozmiarów tekstu
PShape activeFontButton, activeSizeButton;  // Aktywnie wybrane przyciski
float currentX, currentY;  // Pozycje do umieszczania kolejnego znaku

void setup() {
  size(600, 600);  // Rozmiar okna
  font1 = createFont("QwitcherGrypen-Regular.ttf", 32);  // Ładowanie zewnętrznych fontów
  font2 = createFont("ProtestStrike-Regular.ttf", 32); 
  textElements = new ArrayList<TextElement>();  // Lista przechowująca wprowadzony tekst
  fontButtons = new ArrayList<FontButton>();  // Lista przycisków fontów
  sizeButtons = new ArrayList<SizeButton>();  // Lista przycisków rozmiarów tekstu
  
  currentFont = font2;  // Domyślnie ustawiony font
  currentSize = 30;  // Domyślnie ustawiony rozmiar
  currentX = sideMargin;  // Inicjalizacja pozycji tekstu (z marginesem)
  currentY = topMargin;
  
  fontButtons.add(new FontButton(5, height * 3/4 + 20, 190, 50, "QwitcherGrypen", font1));
  fontButtons.add(new FontButton(5, height * 3/4 + 95, 190, 50, "ProtestStrike", font2));
  fontButtons.get(1).isActive = true;
  
  sizeButtons.add(new SizeButton(205, height * 3/4 + 20, 190, 50, "30", 30));
  sizeButtons.add(new SizeButton(205, height * 3/4 + 95, 190, 50, "40", 40));
  sizeButtons.add(new SizeButton(405, height * 3/4 + 20, 190, 50, "50", 50));
  sizeButtons.get(0).isActive = true;
}

void draw() {
  background(255);
  drawText();  // Rysowanie pisanego tekstu
  drawSettings(0, height * 3/4, width, height / 4);  // Rysowanie przycisków w dolnej części
}

void drawSettings(float x, float y, float w, float h) {
  // Rysowanie dolnej części ekranu z przyciskami wyboru fontu i rozmiaru
  fill(240);
  noStroke();
  rect(x, y, w, h);
  
  for (FontButton b : fontButtons) {
    b.drawFontButton();
  }
  
  for (SizeButton b : sizeButtons) {
    b.drawSizeButton();
  }
}

class FontButton {
  float x, y, w, h;
  PShape button;
  String label;
  PFont font;
  boolean isActive = false;
  
  FontButton(float x, float y, float w, float h, String label, PFont font) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.font = font;
  }
  
  void drawFontButton() {
  if (isActive) {
      fill(0,255,0);  // Inny kolor dla aktywnego przycisku
    } else {
      fill(255);  // Domyślny kolor
    }
  this.button = createShape(RECT, x, y, w, h);
  shape(this.button);
  fill(0);
  textFont(font, 32);
  textAlign(CENTER, CENTER);
  text(label, x + w / 2, y + h /2);
  }
}

class SizeButton {
  float x, y, w, h;
  PShape button;
  String label;
  int size;
  boolean isActive = false;
  
  SizeButton(float x, float y, float w, float h, String label, int size) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.size = size;
  }
  
  void drawSizeButton() {
  if (isActive) {
      fill(0,255,0);  // Inny kolor dla aktywnego przycisku
    } else {
      fill(255);  // Domyślny kolor
    }
  this.button = createShape(RECT, x, y, w, h);
  shape(this.button);
  fill(0);
  textSize(size);
  textAlign(CENTER, CENTER);
  text(label, x + w / 2, y + h /2);
  }
}

// Klasa przechowująca informacje o tekście
class TextElement {
  char c;
  float x, y;
  PFont font;
  float size;

  TextElement(char c, float x, float y, PFont font, float size) {
    this.c = c;
    this.x = x;
    this.y = y;
    this.font = font;
    this.size = size;
  }
}

void drawText() {
  pushMatrix();
  translate(0, scrollOffset);  // Przewijanie tekstu
  float x = sideMargin;
  float y = topMargin;

  for (TextElement el : textElements) {
    textFont(el.font, el.size);  // Ustawienie odpowiedniego fontu i rozmiaru dla elementu
    fill(0);
    textAlign(CENTER,CENTER);
    text(el.c, el.x, el.y);  // Rysowanie tekstu w odpowiednich współrzędnych
  }
  popMatrix();
}


void keyPressed() {
  if (key == BACKSPACE && textElements.size() > 0) {
    TextElement lastElement = textElements.remove(textElements.size() - 1);  // Usuwanie ostatniego znaku
    currentX = lastElement.x;  // Ustawienie aktualnej pozycji na wcześniejszą
    currentY = lastElement.y;
  } else if (key != BACKSPACE) {
    textFont(currentFont, currentSize);
    float charWidth = textWidth(key);
    
    // Sprawdzanie, czy nowy znak zmieści się w bieżącej linii
    if (currentX + charWidth > width - sideMargin) {
      currentX = sideMargin;  // Przenieś do nowej linii
      currentY += textAscent() + textDescent();
    }
    
    // Dodajemy nowy element do listy
    textElements.add(new TextElement(key, currentX, currentY, currentFont, currentSize));
    
    // Przesuwamy pozycję dla kolejnego znaku
    currentX += charWidth;
  }
}

void mousePressed() {
  for (FontButton b : fontButtons) {
    if (mouseX > b.x && mouseX < b.x + b.w && mouseY > b.y && mouseY < b.y + b.h) {
      currentFont = b.font;  // Ustaw aktualny font
      for (FontButton fb : fontButtons) {
        fb.isActive = false;  // Resetuj wszystkie przyciski
      }
      b.isActive = true;  // Ustaw bieżący przycisk jako aktywny
    }
  }

  for (SizeButton b : sizeButtons) {
    if (mouseX > b.x && mouseX < b.x + b.w && mouseY > b.y && mouseY < b.y + b.h) {
      currentSize = b.size;  // Ustaw aktualny rozmiar
      for (SizeButton sb : sizeButtons) {
        sb.isActive = false;  // Resetuj wszystkie przyciski
      }
      b.isActive = true;  // Ustaw bieżący przycisk jako aktywny
    }
  }
}

void mouseWheel(MouseEvent event) {
  scrollOffset += event.getCount() * 10;  // Przewijanie tekstu
}

boolean mouseOverShape(PShape shape) {
  // Sprawdzenie, czy mysz znajduje się nad kształtem przycisku
  return mouseX > shape.getVertex(0).x && mouseX < shape.getVertex(2).x &&
         mouseY > shape.getVertex(0).y && mouseY < shape.getVertex(2).y;
}
