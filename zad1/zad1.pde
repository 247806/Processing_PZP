// Zdefiniowane kolory
color[] colors = {#808080, #FF0000, #0000FF, #008000, #FFFF00, #800080};
color backgroundColor;
color[] shapeColors = new color[5];

void setup() {
  size(800, 600);
  // Losowy wybór kolorów dla tła i kształtów
  int rand = int(random(6));
  backgroundColor = colors[rand];
  int i = 0;
  for (color c : colors) {
    if (c != backgroundColor) {
      shapeColors[i++] = c;
    }
  }
  background(backgroundColor);
  
  // Rysowanie prostokątów w obszarze od 0 do 1/2 szerokości oraz 1/3 do 2/3 wysokości
  drawRectangles(0, width/2, height/3, 2*height/3);

  // Rysowanie kół w obszarze od 1/4 do 1/3 szerokości oraz 8/10 do 9/10 wysokości
  drawCircles(0, width/2, 2 * height/3, 9*height/10);

  // Rysowanie trójkątów w obszarze od 2/3 do pełnej szerokości oraz od 1/10 do 3/10 wysokości
  drawTriangles(width/2, width, 0, height/2);
  
  // Rysowanie wielokąta w obszarze od 0 do 1/4 szerokości oraz od 0 do 1/5 wysokości
  drawPolygon(0, width/2, 0, height/3); 
  
  // Rysowanie nieregularnego kształtu w obszarze od 1/2 do 2/3 szerokości oraz od 3/4 do pełnej wysokości
  drawArc(width/2, 2*width/3, 3*height/4, height);
  //drawIrregularShape(width/2, 2*width/3, 3*height/4, height);
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
      rect(xStart + j * rectWidth, yStart + i * rectHeight, rectWidth, rectHeight);
    }
  }
}

void drawCircles(float xStart, float xEnd, float yStart, float yEnd) {
  int numCircles = int(random(2, 6));
  for (int i = 0; i < numCircles; i++) {
    float radius = random(5, 20);
    float x = random(xStart, xEnd);
    float y = random(yStart, yEnd);
    int rand = int(random(5));
    fill(shapeColors[rand]);
    ellipse(x, y, radius*2, radius*2);
  }
}

void drawTriangles(float xStart, float xEnd, float yStart, float yEnd) {
  int numTriangles = int(random(2, 5));
  for (int i = 0; i < numTriangles; i++) {
    float x1 = random(xStart, xEnd);
    float y1 = random(yStart, yEnd);
    float x2 = random(xStart, xEnd);
    float y2 = random(yStart, yEnd);
    float x3 = random(xStart, xEnd);
    float y3 = random(yStart, yEnd);
    int rand = int(random(5));
    fill(shapeColors[rand]);
    triangle(x1, y1, x2, y2, x3, y3);
  }
}

void drawPolygon(float xStart, float xEnd, float yStart, float yEnd) {
  int n = int(random(5,10));
  float centerX = (xEnd - xStart) / 2;
  float centerY = (yEnd - yStart) / 2;
  float radius = min((xEnd - xStart), (yEnd - yStart)) / 3;
  float angleStep = TWO_PI / n;
  
  int rand = int(random(5));
  fill(shapeColors[rand]);
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
  arc(x, y, w, h, 0, PI+QUARTER_PI, PIE); 
}

//void drawStar(float xStart, float yStart,float xEnd, float yEnd, float radius1, float radius2, int npoints) {
//    float angle = TWO_PI / npoints;
//    float halfAngle = angle / 2.0;
//    float x = random(xEnd - xStart);
//    beginShape();
//      for (float a = 0; a < TWO_PI; a += angle) {
//        float sx = x + cos(a) * radius2;
//        float sy = y + sin(a) * radius2;
//        vertex(sx, sy);
//        sx = x + cos(a+halfAngle) * radius1;
//        sy = y + sin(a+halfAngle) * radius1;
//        vertex(sx, sy);
//      }
//    endShape(CLOSE);
//  }

//void drawIrregularShape(float xStart, float xEnd, float yStart, float yEnd) {
// int rand = int(random(5));
// fill(shapeColors[rand]);
//  beginShape();
//  for (int i = 0; i < 6; i++) {
//    float x = random(xStart, xEnd);
//    float y = random(yStart, yEnd);
//    vertex(x, y);
//  }
//  endShape(CLOSE);
//}
