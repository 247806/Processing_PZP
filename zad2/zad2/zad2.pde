float clockRadius;
float cx, cy;
float pendulumAngle = 0;
float pendulumSpeed = 0.05;
float r, o1, o2;
float maxAngle = PI / 4; 
float angle = 0;
float speed = 0.05; 
float lengthW = 0;

void setup() {
  size(500, 500);
  cx = width / 2;
  cy = height / 3;
  clockRadius = min(width, height) * 0.35;
  o1 = width / 2;
  o2 = height / 2;
  r = min(width, height) /3;
  lengthW = clockRadius * 1.2;
}

void draw() {
  background(255);

  drawClock();

  int s = second();
  int m = minute();
  int h = hour() % 12;

  drawTime(h, m, s);

  drawWahadlo();
}

void drawClock() {
  stroke(0);
  fill(255);
  float r = min(width, height) / 4;
  ellipse(o1, o2, r * 2, r * 2);
  float ang = TWO_PI / 12;
  for (int i = 0; i < 12; i++) {
    float x = o1 + cos(ang * i - HALF_PI) * r * 0.9;
    float y = o2 + sin(ang * i - HALF_PI) * r * 0.9;

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    if (i == 0) {
      text(12, x, y);
    } else {
      text(i, x, y);
    }
    
  }
}

void drawTime(int h, int m, int s) {
  strokeWeight(8);
  stroke(0);
  
  strokeWeight(7);
  float hAngle = map(h + m / 60.0, 0, 12, 0, TWO_PI) - HALF_PI;
  line(o1, o2, o1 + cos(hAngle) * r * 0.5, o2 + sin(hAngle) * r * 0.5);
  
  strokeWeight(5);
  float mAngle = map(m, 0, 60, 0, TWO_PI) - HALF_PI;
  line(o1, o2, o1 + cos(mAngle) * r * 0.6, o2 + sin(mAngle) * r * 0.6);
  
  strokeWeight(2);
  stroke(255, 0, 0);
  float sAngle = map(s, 0, 60, 0, TWO_PI) - HALF_PI;
  line(o1, o2, o1 + cos(sAngle) * r * 0.7, o2 + sin(sAngle) * r * 0.7);
}

void drawWahadlo() {
  
  angle = sin(frameCount * speed) * maxAngle;

  float brightness = map(abs(angle), 0, maxAngle, 255, 100);
  stroke(0);
  fill(brightness);
  
  pushMatrix();
  
  translate(o1, o2);
  rotate(angle);
  line(0, 0, 0,lengthW);
  circle(0, lengthW, 40); 
  popMatrix();
}
