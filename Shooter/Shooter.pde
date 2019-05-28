/*
screen 0: menu
 screen 1: how to play
 screen 2: game
 */
Game run = new Game();
int screen = 0;
void setup() {
  fullScreen();
}

void draw() {
  if (screen==0) {
    background(50);
    run.showMenu();
  }
  if (screen==1) {
    background(50);
    run.howPlay();
  }
  if (screen==2) {
    background (50);
    run.showMap();
    run.showChar();
    if (keyPressed) {
      run.keyPressed();
    }
    run.moveChar();
  }
  if (mousePressed) {
    run.mousePressed();
  }
  run.hud();
  run.debug();
  //run.showGrid();
}
class Game {
  int originX = 1920/2;
  int originY = 1080/2;
  PVector pLoc = new PVector(originX, originY);
  int charSpeed = 2;
  boolean up = false;
  boolean right = false;
  boolean down = false;
  boolean left = false;
  void hud() {
    textSize (50);
    fill(255);
    text("<", 100, 100);
  }
  void showMenu() {
    textSize(50);
    text ("Quick Shot!", 825, 200);
    text("Play", 900, 400);
    text("How To Play", 825, 500);
  }
  void mousePressed() {
    if (screen==0) {
      if (mouseX>825 && mouseX<1075 && mouseY<500 && mouseY>460) {
        screen = 1;
      } else if (mouseX>900 && mouseX<1000 && mouseY>350 && mouseY<400) {
        screen = 2;
        run.newGame();
      }
    }

    if (mouseX>100 && mouseX<130 && mouseY>70 && mouseY<100) {
      screen = 0;
    }
  }
  void howPlay() {
    textSize(50);
    text("Quick Shot!", 825, 100);
    text("How To Play", 825, 200);
    text("W: up\nA: left\nS: down\nD: right", 800, 400);
  }
  void newGame() {
    originX = 1920/2;
    originY = 1080/2;
    pLoc = new PVector(originX, originY);
    charSpeed = 2;
    up = false;
    right = false;
    down = false;
    left = false;
  }
  void showChar() {
    fill(0, 102, 255);
    ellipse(pLoc.x, pLoc.y, 20, 20);
  }
  void showMap(){
    fill(200);
    noStroke();
    rect(0, 150, width, 200); //top ho
    rect(0, 440, width, 200); //middle ho
    rect(0, height-350, width, 200); //bottom ho
    rect(width/4, 150, 200, 780); //left vert
    
  }
  void keyPressed() {
    if (key == 'w') {
      up = true;
      ;
    }
    if (key== 'a') {
      left = true;
    }
    if (key== 's') {
      down = true;
    }
    if (key== 'd') {
      right = true;
    }
  }
  void moveChar() {
    if (up&&pLoc.y>0+charSpeed) {
      pLoc.y-=charSpeed;
    }
    if (right&&pLoc.x<width+charSpeed) {
      pLoc.x+=charSpeed;
    }
    if (down&&pLoc.y<height-charSpeed) {
      pLoc.y+=charSpeed;
    }
    if (left&&pLoc.x>0-charSpeed) {
      pLoc.x-=charSpeed;
    }
    if (keyPressed==false) {
      up = false;
      right = false;
      down = false;
      left = false;
    }
  }
  void debug() {
    fill(255);
    textSize(18);
    text("Origin points: (" + originX + ", " + originY + ")\nKey Pressed: " + key + "\nX Position: " + pLoc.x + 
      "\nY Position: " + pLoc.y + "\nmouseX: " + mouseX + "\nmouseY: "
      + mouseY + "\nScreen:" + screen, width-300, height-175);
  }
  void showGrid() {
    for (int c = 0; c<width; c+=50) {
      rect(c, 0, 1, height);
    }
    for (int r = 0; r<height; r+=50) {
      rect(0, r, width, 1);
    }
  }
}
