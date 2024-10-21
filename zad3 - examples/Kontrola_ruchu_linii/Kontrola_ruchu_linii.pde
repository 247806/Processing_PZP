float y;
float speed = 0; 
 
  void setup() {
    size(500, 500);
    stroke(255);
    strokeWeight(5);
    y = height * 0.5;
  }
 
  void draw() {
    background(0);
    line(0, y, width, y);
    
    y += speed;
    
     if (y < 0 || y > height) {
      y = height / 2;  // Resetuj linię do środka
      //speed = 0; 
     }// Zatrzymaj ruch
  }

  
  void keyPressed() {
    if (keyCode ==UP) {
      speed = -1; 
    }
    else if (keyCode == DOWN) {
      speed = 1;
    }
    if (y < 0 || y > height) y = height / 2;
  }
  
  void keyReleased() {
     if (keyCode == UP || keyCode == DOWN) {
    speed = 0;
  }
}
