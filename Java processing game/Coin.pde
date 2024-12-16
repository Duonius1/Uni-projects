public class Coin extends AnimatedSprite{
 public Coin(PImage img, float scale){
  super(img, scale);
  standNeutral = new PImage[2]; // kiek fotkiu turi, toks ir skaicius
  standNeutral[0] = loadImage("tile_0151.png");
  standNeutral[1] = loadImage("tile_0152.png");
  currentImages = standNeutral;
 }
}
