public class Player extends AnimatedSprite {
 int lives;
 boolean onPlatform, inPlace;
 PImage[] standLeft;
 PImage[] standRight;
 PImage[] jumpLeft;
 PImage[] jumpRight;
 public Player(PImage img, float scale){
  super(img, scale);
  lives = 3;
  direction = RIGHT_FACING;
  onPlatform = false;
  inPlace = true;
  standLeft = new PImage[4];
  standLeft[0] = loadImage("owlet_stand_left1.png");
  standLeft[1] = loadImage("owlet_stand_left2.png");
  standLeft[2] = loadImage("owlet_stand_left3.png");
  standLeft[3] = loadImage("owlet_stand_left4.png");
  standRight = new PImage[4];
  standRight[0] = loadImage("owlet_stand_right1.png");
  standRight[1] = loadImage("owlet_stand_right2.png");
  standRight[2] = loadImage("owlet_stand_right3.png");
  standRight[3] = loadImage("owlet_stand_right4.png");
  jumpLeft = new PImage[2];
  jumpLeft[0] = loadImage("owlet_jump_left1.png");
  jumpLeft[1] = loadImage("owlet_jump_left2.png");
  jumpRight = new PImage[2];
  jumpRight[0] = loadImage("owlet_jump_right1.png");
  jumpRight[1] = loadImage("owlet_jump_right2.png");
  moveLeft = new PImage[6];
  moveLeft[0] = loadImage("owlet_run_left1.png");
  moveLeft[1] = loadImage("owlet_run_left2.png");
  moveLeft[2] = loadImage("owlet_run_left3.png");
  moveLeft[3] = loadImage("owlet_run_left4.png");
  moveLeft[4] = loadImage("owlet_run_left5.png");
  moveLeft[5] = loadImage("owlet_run_left6.png");
  moveRight = new PImage[6];
  moveRight[0] = loadImage("owlet_run_right1.png");
  moveRight[1] = loadImage("owlet_run_right2.png");
  moveRight[2] = loadImage("owlet_run_right3.png");
  moveRight[3] = loadImage("owlet_run_right4.png");
  moveRight[4] = loadImage("owlet_run_right5.png");
  moveRight[5] = loadImage("owlet_run_right6.png");
  currentImages = standRight;
 }
 
 @Override
 public void updateAnimation(){
   onPlatform = isOnPlatforms(this, platforms);
   inPlace = change_x == 0 && change_y == 0;
   super.updateAnimation();
 }
 @Override
 public void selectDirection(){
   if(change_x > 0)
    direction = RIGHT_FACING; 
   else if (change_x < 0)
    direction = LEFT_FACING; 
 }
 @Override
 public void selectCurrentImages(){
   if(direction == RIGHT_FACING){
    if(inPlace){
     currentImages = standRight; 
    }
    else if(!onPlatform){
     currentImages = jumpRight; 
    }
    else {
     currentImages = moveRight; 
    }
   }
   if(direction == LEFT_FACING){
    if(inPlace){
     currentImages = standLeft; 
    }
    else if(!onPlatform){
     currentImages = jumpLeft; 
    }
    else {
     currentImages = moveLeft; 
    }
   }
 }
}
