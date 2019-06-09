# FinalProject

# Project Title and purpose
Quick shot - try to survive waves of enemies
One Paragraph of project description goes here
Quick shot is a 2D platformer style game.  You have three different floors with a ladder to climb to get between them.  It has jump physics and a hard-coded gravity logic.  You would try to shoot all of the enemies, which would have been red squares, before they could reach the player.  
### Difficulties or opportunities you encountered along the way.

The toughest part was...
creating the collision conditionals to prevent the player from falling through the different floors in the level
### Most interesting piece of your code and explanation for what it does.

```Java
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
  
  This was the code that allows the character to walk on the different floors without falling through, and the more complex character movements, such as jumping.
  
## Built With
* [Processing](https://processing.org/) - The IDE used

## Authors

* **Aaron Rachke** 

## Acknowledgments
Gabe Berken
* Hat tip to anyone whose code was used
* Inspiration
* etc



*** ran of out time for enemies***
THE LADDER GOES OFF OF THE TOP OF SCREEN (YOU SHOULD TRY IT; IT'S WORTH IT)
