
void setup(){
  size(400, 200);
}

float time = 0.0;

void draw(){
  
  //postac 1
  rectMode(CENTER);
  fill(120);
  stroke(120);
  rect(100, 100, 20, 100);
  fill(200);
  stroke(0,0,255);
  ellipse(100, 70, 60, 60);
  fill(255);
  stroke(0);
  ellipse(81, 70, 16, 32);
  fill(255);
  stroke(0);
  ellipse(119, 70, 16, 32);
  line(90, 150, 80, 160);
  line(110, 150, 120, 160);
  
  //postac 2
  rectMode(CENTER);
  fill(120);
  stroke(120);
  rect(200, 100, 20, 100);
  fill(200);
  stroke(0,0,255);
  ellipse(200, 70, 60, 60);
  fill(255);
  stroke(0);
  ellipse(181, 70, 16, 32);
  fill(255);
  stroke(0);
  ellipse(219, 70, 16, 32);
  line(190, 150, 180, 160);
  line(210, 150, 220, 160);
  
  // slonce
  fill(252,198,3);
  stroke(252,198,3);
  ellipse(25, 25, 30, 30);
  
  //chmura
  noStroke();
  fill(179,177,173);
  float x = 320;
  float y = 50;
  float w = 100;
  float h = 60;
  ellipse(x, y, w, h);            // Główna elipsa (środkowa)
  ellipse(x - w * 0.4, y, w * 0.6, h * 0.6);  // Lewa elipsa
  ellipse(x + w * 0.4, y, w * 0.6, h * 0.6);  // Prawa elipsa
  ellipse(x - w * 0.2, y - h * 0.4, w * 0.6, h * 0.6);  // Górna lewa elipsa
  ellipse(x + w * 0.2, y - h * 0.4, w * 0.6, h * 0.6);  // Górna prawa elipsa
  time += 0.01;
}
  
