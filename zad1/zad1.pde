color[] colors = {#808080, #FF0000, #0000FF, #008000, #FFFF00, #800080};
color backgroundColor;
color[] shapeColors = new color[5];
PFont font1;
PFont font2;


void setup() {
  size(800, 600);
  
  int rand = int(random(6));
  backgroundColor = colors[rand];
  int i = 0;
  for (color c : colors) {
    if (c != backgroundColor) {
      shapeColors[i++] = c;
    }
  }
  background(backgroundColor);
  
  drawRectangles(width/4, 3 * width/4, height/3, 2*height/3);
  drawCircles(width/10, width/3, 3 * height/4, 9*height/10);
  drawTriangles(width/2, width, 0, height/3);
  drawFigure(0, width/2, 0, height/3); 
  drawArc(width/2, 4*width/5, 2*height/3, 9 * height/ 10);
  drawLogo(100,200);
}

void drawRectangles(float xStart, float xEnd, float yStart, float yEnd) {
  int rows = int(random(2, 5));
  int cols = int(random(2, 5));
  float rectWidth = (xEnd - xStart) / cols;
  float rectHeight = (yEnd - yStart) / rows;
  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int rand = int(random(5));
      fill(shapeColors[rand]);
      stroke(shapeColors[rand]);
      rect(xStart + j * rectWidth, yStart + i * rectHeight, rectWidth, rectHeight);
    }
  }
}

void drawCircles(float xStart, float xEnd, float yStart, float yEnd) {
  int numCircles = int(random(1, 6));
  for (int i = 0; i < numCircles; i++) {
    float radius = random(5, 20);
    float x = random(xStart - radius, xEnd - radius);
    float y = random(yStart - radius, yEnd - radius);
    int rand = int(random(5));
    fill(shapeColors[rand]);
    stroke(shapeColors[rand]);
    ellipse(x, y, radius*2, radius*2);
  }
}

void drawTriangles(float xStart, float xEnd, float yStart, float yEnd) {
  int numTriangles = int(random(1, 4));
  for (int i = 0; i < numTriangles; i++) {
    float x1 = random(xStart, xEnd);
    float y1 = random(yStart, yEnd);
    float x2 = random(xStart, xEnd);
    float y2 = random(yStart, yEnd);
    float x3 = random(xStart, xEnd);
    float y3 = random(yStart, yEnd);
    int rand = int(random(5));
    fill(shapeColors[rand]);
    stroke(shapeColors[rand]);
    triangle(x1, y1, x2, y2, x3, y3);
  }
}

void drawFigure(float xStart, float xEnd, float yStart, float yEnd) {
  int n = int(random(5,10));
  float centerX = (xEnd - xStart) / 2;
  float centerY = (yEnd - yStart) / 2;
  float radius = min((xEnd - xStart), (yEnd - yStart)) / 3;
  float angleStep = TWO_PI / n;
  
  int rand = int(random(5));
  fill(shapeColors[rand]);
  stroke(shapeColors[rand]);
  beginShape();
  for (int i = 0; i < n; i++) {
    float x = centerX + cos(angleStep * i) * radius;
    float y = centerY + sin(angleStep * i) * radius;
    vertex(x, y);
  }
  endShape(CLOSE);
}

void drawArc(float xStart, float yStart, float xEnd, float yEnd) {
  float x = random(xStart, xEnd);
  float y = random(yStart, yEnd);
  float w = random(100, xEnd - xStart);
  float h = random(100, yEnd - yStart);
  
  int rand = int(random(5));
  fill(shapeColors[rand]);
  stroke(shapeColors[rand]);
  arc(x, y, w, h, 0, PI+QUARTER_PI, PIE); 
}

void drawLogo(float x, float y) {
  float centerX = width / 2;
  float centerY = height / 2;
  
  String letter1 = "J";
  String name = "Śladowski";
  float fontSize1 = x * 0.75;  
  float fontSize2 = x * 0.6;  
  
  font1 = createFont("ProtestStrike-Regular.ttf", fontSize1);
  font2 = createFont("QwitcherGrypen-Regular.ttf", fontSize2);
  textAlign(CENTER, CENTER);
  
  fill(0); 
  textFont(font1);
  text(letter1, centerX, centerY - y * 0.25);
  
  textFont(font2);
  text(name, centerX, centerY);
}
