public class Enemy extends AnimatedSprite{
 float boundaryLeft, boundaryRight;
 public Enemy(PImage img, float scale, float bLeft, float bRight){
   super(img, scale);
   moveLeft = new PImage[2];
   moveLeft[0] = loadImage("saw.png");
   moveLeft[1] = loadImage("saw_move.png");
   moveRight = new PImage[2];
   moveRight[0] = loadImage("saw_move.png");
   moveRight[1] = loadImage("saw.png");
   currentImages = moveRight;
   direction = RIGHT_FACING;
   boundaryLeft = bLeft;
   boundaryRight = bRight;
   change_x = 2;
 }
 void update(){
   super.update();
   if(getLeft() <= boundaryLeft){
    setLeft(boundaryLeft);
    change_x *= -1;
   }
   else if(getRight() >= boundaryRight){
    setRight(boundaryRight);
    change_x *= -1;
   }
 }
}
