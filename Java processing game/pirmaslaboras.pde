final static float MOVE_SPEED = 5;
final static float SPRITE_SCALE = 32.0/18;
final static float SPRITE_SIZE = 32;
final static float GRAVITY = 0.3;
final static float JUMP_SPEED = 8;

final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 100;
final static float VERTICAL_MARGIN = 40;

final static int NEUTRAL_FACING = 0;
final static int RIGHT_FACING = 1;
final static int LEFT_FACING = 2;

final static float WIDTH = SPRITE_SIZE * 80;
final static float HEIGHT = SPRITE_SIZE * 15;
final static float GROUND_LEVEL = HEIGHT - SPRITE_SIZE;
//globalus kintamieji
Player p;
PImage tile_0068, tile_0085, tile_0111, tile_0131; // Dygliai-zenklas-veliav_virsus-veliav-apacia
PImage tile_0081, tile_0082, tile_0083; // Skraidantys sniego left-center-right
PImage tile_0101, tile_0102, tile_0103; // Virsus zemes sniego left-center-right
PImage tile_0121, tile_0122, tile_0123; // Zeme left-center-right
PImage tile_0153, tile_0154, tile_0155; // Debesis left-center-right
PImage tile_0151; // pinigas
PImage saw;
PImage Owlet_Monster;

ArrayList<Sprite> platforms;
ArrayList<Sprite> coins;
Enemy enemy;
boolean isGameOver;
int numCoins;

float view_x;
float view_y;

void setup(){
  size(800, 600);
  imageMode (CENTER);
  Owlet_Monster = loadImage("Owlet_Monster.png");
  p = new Player(Owlet_Monster, 1.0);
  p.setBottom(GROUND_LEVEL);
  p.center_x = 100;
  platforms = new ArrayList<Sprite>();
  coins = new ArrayList<Sprite>();
  isGameOver = false;
  numCoins = 0;
  tile_0081 = loadImage("tile_0081.png"); tile_0082 = loadImage("tile_0082.png"); tile_0083 = loadImage("tile_0083.png");
  tile_0101 = loadImage("tile_0101.png"); tile_0102 = loadImage("tile_0102.png"); tile_0103 = loadImage("tile_0103.png");
  tile_0121 = loadImage("tile_0121.png"); tile_0122 = loadImage("tile_0122.png"); tile_0123 = loadImage("tile_0123.png"); 
  tile_0153 = loadImage("tile_0153.png"); tile_0154 = loadImage("tile_0154.png"); tile_0155 = loadImage("tile_0155.png"); 
  tile_0068 = loadImage("tile_0068.png"); tile_0085 = loadImage("tile_0085.png");
  tile_0131 = loadImage("tile_0131.png"); tile_0111 = loadImage("tile_0111.png");
  tile_0151 = loadImage("tile_0151.png");
  saw = loadImage("saw.png");
  createPlatforms("platf1test.csv");
  view_x = 0;
  view_y = 0;
}

void draw(){
  background(125, 192, 209);
  scroll();//butina turi but pirmas pacallint'as
  displayAll();
  if(!isGameOver){
    updateAll();
    collectCoins();
  }
}
void displayAll(){
  for(Sprite s: platforms)
    s.display();
  for(Sprite c: coins){
    c.display();
  }
  p.display();
  enemy.display();
  
  fill(255, 0, 0);
  textSize(32);
  text("Coins: " + numCoins, view_x + 50, view_y + 50);
  text("Lives: " + p.lives, view_x + 650, view_y + 50);

  if(isGameOver){
   fill(0, 0, 255);
   text("GAME OVER!", view_x + width/2 - 80, view_y + height/2 - 200);
   if(p.lives == 0){
     text("You lose!", view_x + width/2 - 55, view_y + height/2 - 150);
   }
   else
     text("You win!", view_x + width/2 - 55, view_y + height/2 - 150);
   text("Press SPACE to restart!", view_x + width/2 - 150, view_y + height/2 - 100);
  }
}
void updateAll(){
  p.updateAnimation();
  resolvePlatformCollisions(p, platforms);
  enemy.update();
  enemy.updateAnimation();
  for(Sprite c: coins){
    ((AnimatedSprite)c).updateAnimation();
  }
  collectCoins();
  checkDeath();
}
void checkDeath(){
 boolean collideEnemy = checkCollision(p, enemy);
 boolean fallOffCliff = p.getBottom() > GROUND_LEVEL;
 if(collideEnemy || fallOffCliff){
  p.lives--;
  if(p.lives == 0){
   isGameOver = true;
  }
  else {
   p.center_x = 100;
   p.setBottom(GROUND_LEVEL);
  }
 }
}
void collectCoins(){
 ArrayList<Sprite> coin_list = checkCollisionList(p, coins);
 if(coin_list.size() > 0){
  for(Sprite coin: coin_list){
   numCoins++;
   coins.remove(coin);
  }
 }
 if(coins.size() == 0){
  isGameOver = true; 
 }
}

void scroll() {
  float right_boundary = view_x + width - RIGHT_MARGIN;
  if(p.getRight() > right_boundary){
   view_x += p.getRight() - right_boundary; 
  }
  float left_boundary = view_x + LEFT_MARGIN;
  if(p.getLeft() < left_boundary){
   view_x -= left_boundary - p.getLeft(); 
  }
  float bottom_boundary = view_y + height - VERTICAL_MARGIN;
  if(p.getBottom() > bottom_boundary){
   view_y += p.getBottom() - bottom_boundary; 
  }
  float top_boundary = view_y + VERTICAL_MARGIN;
  if(p.getTop() < top_boundary){
   view_y -= top_boundary - p.getTop(); 
  }
  translate(-view_x, -view_y);
}
public boolean isOnPlatforms(Sprite s, ArrayList<Sprite> walls){
  s.center_y += 5;
  ArrayList<Sprite> col_list = checkCollisionList(s, walls);
  s.center_y -= 5;
  if(col_list.size() > 0){
    return true;
  }
  else {
    return false;
  }
}

public void resolvePlatformCollisions(Sprite s, ArrayList<Sprite> walls){
  s.change_y += GRAVITY;
  
  
  s.center_y += s.change_y;
  ArrayList<Sprite> col_list = checkCollisionList(s, walls);
  if(col_list.size() > 0){//jeigu i kazka atsitrenki, tada > 0
    Sprite collided = col_list.get(0);
    if(s.change_y > 0){//jeigu krenti zemyn
       s.setBottom(collided.getTop());//suranda virsu platformos
    }
    else if(s.change_y < 0){ //jeigu aukstyn varai
      s.setTop(collided.getBottom());
    }
    s.change_y = 0;
  }
  
  s.center_x += s.change_x;
  col_list = checkCollisionList(s, walls);
  if(col_list.size() > 0){//jeigu i kazka atsitrenki, tada > 0
    Sprite collided = col_list.get(0);
    if(s.change_x > 0){//jeigu judi i desine
       s.setRight(collided.getLeft());//suranda kaire platformos ir settina tavo desine i platformos kaire
    }
    else if(s.change_x < 0){ //jeigu judi i kaire
      s.setLeft(collided.getRight());// suranda desine platformos ir settina tavo kaire i platformos desine
    }
    s.change_y = 0;
  }
}

boolean checkCollision(Sprite s1, Sprite s2){
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  if(noXOverlap || noYOverlap){
   return false; 
  }
  else {
   return true;
  }
}

public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
  ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
  for(Sprite p: list){
   if(checkCollision(s, p))
     collision_list.add(p);
  }
  return collision_list;
}

void createPlatforms(String filename){
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++){
   String[] values = split(lines [row], ",");
   for(int col = 0; col < values.length; col++){
    if(values[col].equals("69")){
     Sprite s = new Sprite(tile_0068, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("86")){
     Sprite s = new Sprite(tile_0085, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("132")){
     Sprite s = new Sprite(tile_0131, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("112")){
     Sprite s = new Sprite(tile_0111, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("82")){
     Sprite s = new Sprite(tile_0081, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("83")){
     Sprite s = new Sprite(tile_0082, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("84")){
     Sprite s = new Sprite(tile_0083, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("102")){
     Sprite s = new Sprite(tile_0101, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("103")){
     Sprite s = new Sprite(tile_0102, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("104")){
     Sprite s = new Sprite(tile_0103, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("122")){
     Sprite s = new Sprite(tile_0121, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("123")){
     Sprite s = new Sprite(tile_0122, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("124")){
     Sprite s = new Sprite(tile_0123, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("154")){
     Sprite s = new Sprite(tile_0153, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("155")){
     Sprite s = new Sprite(tile_0154, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("156")){
     Sprite s = new Sprite(tile_0155, SPRITE_SCALE);
     s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     platforms.add(s);
    }
    else if(values[col].equals("152")){
     Coin c = new Coin(tile_0151, SPRITE_SCALE);
     c.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     c.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     coins.add(c);
    }
    else if(values[col].equals("1")){
     float bLeft = col * SPRITE_SIZE;
     float bRight = bLeft + 3 * SPRITE_SIZE;
     enemy = new Enemy(saw, SPRITE_SCALE, bLeft, bRight);
     enemy.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     enemy.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
    }
   }
  }
}
// pakvieciamas kada paspaudi mygtuka
void keyPressed()
{
  if(keyCode == RIGHT){
    p.change_x = MOVE_SPEED;
  }
  else if(keyCode == LEFT){
    p.change_x = -MOVE_SPEED;
  }
  else if(keyCode == UP && isOnPlatforms(p, platforms)){
    p.change_y = -JUMP_SPEED;
  }
  else if (isGameOver && key == ' ')
    setup();
}
// pakvieciamas kai atleidi mygtuka
void keyReleased(){
  if(keyCode == RIGHT){
    p.change_x = 0;
  }
  else if(keyCode == LEFT){
    p.change_x = 0;
  }
}
