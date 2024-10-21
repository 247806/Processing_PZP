class CharacterPosition {
  char c;  // Znak, na podstawie którego wybieramy kształt
  float x, y;  // Pozycja kształtu
  float hue;  // Odcień koloru

  CharacterPosition(char c, float x, float y, float hue) {
    this.c = c;
    this.x = x;
    this.y = y;
    this.hue = hue;
  }

  // Metoda rysowania kształtu
  void drawShape() {
    fill(hue, 255, 255);  // Ustaw kolor w trybie HSB

    if (Character.isDigit(c)) {  // Jeżeli znak to cyfra, rysuj koło
      ellipse(x, y, 50, 50);
    } else if (Character.isLetter(c)) {  // Jeżeli znak to litera, rysuj kwadrat
      rect(x - 25, y - 25, 50, 50);  // Kwadrat o boku 50, centrowany na (x, y)
    }
  }
}

ArrayList<CharacterPosition> shapes;
float x;
float y;
boolean possibility = false;
 
  void setup() {
    size(400, 400, P2D);
    x = width / 2;
    y = height / 2;
    shapes = new ArrayList<CharacterPosition>();
    noLoop();
  }
 
  void draw() {
    background(0);
    for (CharacterPosition cp : shapes) {
      cp.drawShape();
  }
  }
 
  void keyPressed() {
    if (Character.isDigit(key) || Character.isLetter(key)) {
    // Oblicz odcień na podstawie wartości ASCII znaku
    float hue = map(key, '0', 'z', 0, 255);  // Mapowanie od 0 do 255

    // Dodaj nowy kształt do listy
    shapes.add(new CharacterPosition(key, x, y, hue));
    
    redraw();  // Odśwież ekran
  }
  }  
  
  void mousePressed() {
    possibility = true;
    x = mouseX;
    y = mouseY;
  }
