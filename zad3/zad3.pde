PFont font1, font2, currentFont;;
ArrayList<TextElement> textElements;
float currentSize;
int topMargin = 20, bottomMargin = 10, sideMargin = 20;  // Marginesy
float scrollOffset = 0;  // Przewijanie tekstu
ArrayList<FontButton> fontButtons; 
ArrayList<SizeButton> sizeButtons;
PShape activeFontButton, activeSizeButton;  // Aktywnie wybrane przyciski
float currentX, currentY;  // Pozycje do umieszczania kolejnego znaku

void setup() {
  size(600, 600);
  font1 = createFont("QwitcherGrypen-Regular.ttf", 32); 
  font2 = createFont("ProtestStrike-Regular.ttf", 32); 
  textElements = new ArrayList<TextElement>(); 
  fontButtons = new ArrayList<FontButton>(); 
  sizeButtons = new ArrayList<SizeButton>();
  
  currentFont = font2; 
  currentSize = 30; 
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
  drawText(); 
  drawSettings(0, height * 3/4, width, height / 4); 
}

void drawSettings(float x, float y, float w, float h) {
  
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
      fill(0,255,0); 
    } else {
      fill(255); 
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
      fill(0,255,0);  
    } else {
      fill(255); 
    }
  this.button = createShape(RECT, x, y, w, h);
  shape(this.button);
  fill(0);
  textSize(size);
  textAlign(CENTER, CENTER);
  text(label, x + w / 2, y + h /2);
  }
}


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

  for (TextElement el : textElements) {
    textFont(el.font, el.size);  
    fill(0);
    text(el.c, el.x, el.y);  // Rysowanie tekstu w odpowiednich współrzędnych
  }
  popMatrix();
}


void keyPressed() {
  if (key == BACKSPACE && textElements.size() > 0) {
    TextElement lastElement = textElements.remove(textElements.size() - 1);  // Usuwanie ostatniego znaku
    currentX = lastElement.x;  // Ustawienie aktualnej pozycji na wcześniejszą
    currentY = lastElement.y;
  } else if (Character.isLetterOrDigit(key) || key == ' ' || key == '.' || key == ',' || key == '!' || key == '?' || key == ';' || key == ':') {
    textFont(currentFont, currentSize);
    float charWidth = textWidth(key);
    
    // Sprawdzanie, czy nowy znak zmieści się w bieżącej linii
    if (currentY + textAscent() + textDescent() > height * 3 / 4 - bottomMargin && currentX + charWidth > width - sideMargin) {
      scrollOffset -= textAscent() + textDescent() + 5;  // Przesuwamy widok w górę
      currentX = sideMargin;
      currentY += textAscent() + textDescent() + 5;
    } else if (currentX + charWidth > width - sideMargin) {
      currentX = sideMargin;
      currentY += textAscent() + textDescent() + 5;
    } 
    
    // Dodajemy nowy element do listy
    textElements.add(new TextElement(key, currentX, currentY, currentFont, currentSize));
   
    currentX += charWidth;
  }
}

void mousePressed() {
  for (FontButton b : fontButtons) {
    if (mouseX > b.x && mouseX < b.x + b.w && mouseY > b.y && mouseY < b.y + b.h) {
      currentFont = b.font;  
      for (FontButton fb : fontButtons) {
        fb.isActive = false;  
      }
      b.isActive = true;  
    }
  }

  for (SizeButton b : sizeButtons) {
    if (mouseX > b.x && mouseX < b.x + b.w && mouseY > b.y && mouseY < b.y + b.h) {
      currentSize = b.size; 
      for (SizeButton sb : sizeButtons) {
        sb.isActive = false; 
      }
      b.isActive = true; 
    }
  }
}

void mouseWheel(MouseEvent event) {
  if (mouseY > 0 && mouseY < 200) {
  scrollOffset += event.getCount() * 10; 
  }
 
}
