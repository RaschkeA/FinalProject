class Pong {
  int barY = 150;
  int aiY = 150;
  int barSpeed = 2;
  //ball
  float xSpeed = 1.5;
  float ySpeed = random(-2, 2);
  int xPos = 400;
  int yPos = 200;

  void showBar() {
    fill (255);
    rect (775, barY, 25, 100);
    rect (0, aiY, 25, 100);
    rect(0, 400, 800, 10);
    rect(800, 0, 10, 400);
    textSize(30);
    text ("arrow keys to move and left mouse button to reset", 900, 75);
  }

  void keyPressed() {
    if (key == CODED) {
      if (barY<0) {
        barY=0;
      }
      if (barY>300) {
        barY=300;
      }
      if (keyCode==UP) {
        barY-=2;
      } else if (keyCode ==DOWN) {
        barSpeed = 2;
        barY+=2;
        
      }
    }
  }
  void mousePressed() {
    if (mousePressed) {
      barY = 150;
      barSpeed = 2;
      //ball
      xSpeed = 1.5;
      ySpeed = random(-2, 2);
      xPos = 400;
      yPos = 200;
    }
  }

  void showBall() {
    ellipse ( xPos, yPos, 15, 15);
  }

  void moveBall() {
    xPos+=xSpeed;
    yPos+=ySpeed;
  }

  void blockBall() {
    
        if (xPos<=25&&yPos>=aiY+75 &&yPos<=aiY+100) { // left side bottom
      xSpeed*=-1;
      xSpeed+=.5;
      ySpeed+=.5;
    } else if (xPos<=25&&yPos<=aiY+25&&yPos>=aiY) { // top
      xSpeed*=-1;
      xSpeed+=.5;
      ySpeed-=.5;
    } else if (xPos<=25 &&yPos>aiY+25&&yPos<aiY+75) { // center
      xSpeed*=-1;
      xSpeed+=.5;
    }
    
    if (xPos>=760&&yPos>=barY+75 &&yPos<=barY+100) { // right side bottom
      xSpeed*=-1;
      xSpeed-=.5;
      ySpeed+=.5;
    } else if (xPos>=760&&yPos<=barY+25&&yPos>=barY) { // top
      xSpeed*=-1;
      xSpeed-=.5;
      ySpeed-=.5;
    } else if (xPos>=760 &&yPos>barY+25&&yPos<barY+75) { // center
      xSpeed*=-1;
      xSpeed-=.5;
    }
    if (yPos<0||yPos>400) {//top and bottom
      ySpeed*=-1;
    }
  }
  void moveAI(){
    if(yPos>=aiY+50){
     aiY+=barSpeed; 
    } else if (yPos<=aiY+50){
     aiY-=barSpeed; 
    }
    if (aiY<0){
      aiY = 0;
    } else if (aiY>300){
     aiY = 300; 
    }
  }
  void hud() {
    textSize(20);
    text ("Speed: " + Math.abs(xSpeed), 375, 20);
    if (xPos>810) {
      xSpeed = 0;
      ySpeed = 0;
      textSize(50);
      text("GAME OVER\nClick to reset", 275, 200);
    } else if(xPos<0){
      xSpeed = 0;
      ySpeed = 0;
      xPos = -10;
      textSize(50);
     text("You win!", 300, 200); 
    }
  }
  void debug() {
    textSize(18);
    text("xSpeed: "+xSpeed+"\nySpeed: "+ySpeed+"\nxPos: "+xPos+"\nyPos: "+yPos+"\nbarY: "+barY+"\naiY: "+aiY, 600, 250);
  }
}
