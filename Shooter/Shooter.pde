/*
screen 0: menu
 screen 1: how to play
 screen 2: game
 */
Game run = new Game();
Pong bonk = new Pong();
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
      run.moveChar();
    }
    keyReleased();
    run.gravity();
    run.jump();
    run.climb();
    run.top();
  }
  if (screen == 3) {
    background(0);
    bonk.showBar();
    if (keyPressed) {
      bonk.keyPressed();
    }
    run.mousePressed();
    bonk.showBall();
    bonk.moveBall();
    bonk.blockBall();
    bonk.moveAI();
    bonk.hud();
    //bonk.debug();
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
  int charSpeed = 7;
  PVector pLoc = new PVector(originX, originY);
  PVector velocity = new PVector(charSpeed, 0);
  PVector acceleration = new PVector(0, .15);
  boolean up = false;
  boolean right = false;
  boolean down = false;
  boolean left = false;
  boolean fall = false;
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
  void howPlay() {
    textSize(50);
    text("Quick Shot!", 825, 100);
    text("How To Play", 825, 200);
    text("W: jump\nA: left\nS: climb down\nD: right", 800, 400);
  }
  void mousePressed() {
    if (screen==0) {
      if (mouseX>825 && mouseX<1075 && mouseY<500 && mouseY>460 ) {
        screen = 1;
      } else if (mouseX>900 && mouseX<1000 && mouseY>350 && mouseY<400) {
        screen = 2;
        run.newGame();
      }
    }

    if (mouseX>100 && mouseX<130 && mouseY>70 && mouseY<100 && (screen == 1 || screen == 2)) {
      screen = 0;
    }
    if (mouseX>100 && mouseX<130 && mouseY>70 && mouseY<100 && screen ==3) {
      screen = 2;
    }
  }
  void newGame() {
    originX = 1920/2;
    originY = 1080/2;
    charSpeed = 7;
    pLoc = new PVector(originX, originY);
    velocity = new PVector(charSpeed, 0);
    acceleration = new PVector(0, .25);
    up = false;
    right = false;
    down = false;
    left = false;
    fall = false;
  }
  void showChar() {
    fill(0, 102, 255);
    ellipse(pLoc.x, pLoc.y, 20, 20);
  }
  void showMap() {
    fill(200);
    noStroke();
    rect(0, 150, width, 200); //top ho
    rect(0, 440, width, 200); //middle ho
    rect(0, height-350, width, 200); //bottom ho
    rect(width/4, 150, 200, 780); //left vert
    fill(50);
    for (int i = 175; i <= height-150; i+=50) {
      rect(width/4, i, 200, 25);
    }
  }
  void keyPressed() {
    up = false;
    left = false;
    down = false;
    right = false;
    if (key == 'w'&&((pLoc.y>1080-165 || (pLoc.y >= 625 && pLoc.y<640) || (pLoc.y>=630 && pLoc.y<650)) || (pLoc.x < width/4+200 && pLoc.x > width/4))) {
      up = true;
    }
    if (key== 'a' && pLoc.x>10) {
      left = true;
      ;
    }
    if (key== 's') {
      down = true;
    }
    if (key== 'd' && pLoc.x<width-10) 
      right = true;
  }
  void moveChar() {
    if (pLoc.y>920) {
      pLoc.y = 920;
    }
    if (up) {
      jump();
    }
    if (right) {
      pLoc.x+=velocity.x;
    }
    if (left) {
      pLoc.x-=velocity.x;
    }
    if (down && pLoc.y< 923 && pLoc.x > width/4 && pLoc.x < width/4 + 200) {
      pLoc.y+=charSpeed;
    }
    if (pLoc.y> 640 && pLoc.y<730 && (pLoc.x>width/4+200 || pLoc.x < width/4)) {// middle
      pLoc.y = 630;
    }
    if (pLoc.y> 340 && pLoc.y<440 && (pLoc.x>width/4+200 || pLoc.x < width/4)) {// top
      pLoc.y = 340;
    }
  }
  void gravity() {
    if ((pLoc.x>width/4+200 || pLoc.x < width/4) && ((pLoc.y<1080-165 && pLoc.y>height-350) || (pLoc.y<625 && pLoc.y>440) || (pLoc.y<330 && pLoc.y>150))) {//bottom and middle and top
      pLoc.y+=velocity.y;
      velocity.add(acceleration);
    }
    if (pLoc.y>913) {//bottom
      velocity.y = 0;
      pLoc.y = 920;
    }
  }
  void jump() {
    if (up && (pLoc.x>width/4+200 || pLoc.x < width/4)) {
      velocity.y = -7;
      up = false;
      fall = true;
    }
    if (fall) { // bottom
      pLoc.y+=velocity.y;
      velocity.y+=acceleration.y;
      if (pLoc.y>=900) {
        fall = false;
      }
      if (pLoc.y> 640 && pLoc.y<730 && (pLoc.x>width/4+200 || pLoc.x < width/4)) {// middle
        pLoc.y = 630; 
        velocity.y = 0;
        fall = false;
      }
      if (pLoc.y== 340 && (pLoc.x>width/4+200 || pLoc.x < width/4)) {// top
        velocity.y = 0;
        fall = false;
      }
    }
  }
  void climb() {
    if (pLoc.x<width/4+200 && pLoc.x > width/4 && up) {
      pLoc.y-=7;
      up = false;
    }
  }
  void top() {
    if (pLoc.y<100) {
      screen = 3;
    }
  }
  void debug() {
    fill(255);
    textSize(18);
    text("Origin points: (" + originX + ", " + originY + ")\nKey Pressed: " + key + "\nX Position: " + pLoc.x + 
      "\nY Position: " + pLoc.y + "\nmouseX: " + mouseX + "\nmouseY: "
      + mouseY + "\nScreen:" + screen + "\nvelocity.x: " + velocity.x + "\nvelocity.y: " + velocity.y +
      "\nacceleration: " + acceleration, width-300, height-270);
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
