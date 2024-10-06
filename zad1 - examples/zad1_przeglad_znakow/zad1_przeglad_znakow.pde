PFont font;  

  void setup() {
    size(600, 300);
    background(0);
    noLoop();
    font = createFont("Courier New", 50);
    textFont(font);
    textAlign(CENTER, CENTER);
  }  

  void draw() {
    char letter = 'a';   
    int rows = 4;
    int columns = 7;
    int gapX = width / (columns+1);
    int gapY = height / (rows+1);
    for(int x=1; x<=columns; x++) {
      for(int y=1; y<=rows; y++) {
        pushMatrix();
        translate(gapX * x , gapY * y);
        if(isVowel(letter)) {
          fill(255, 0, 0);
          text(Character.toUpperCase(letter), 0, 0);  
      } else {fill(255);
        text(letter, 0, 0);
      }
        letter++;
        if(letter == '{') break; 
        
        popMatrix(); 
      }
    }
  }
 
boolean isVowel(char letter) {
  char lowerLetter = Character.toLowerCase(letter);
  return lowerLetter == 'a' || lowerLetter == 'e' || lowerLetter == 'i' || lowerLetter == 'o' || lowerLetter == 'u' || lowerLetter == 'y';
}
