
class Enemy {
  private PImage fan = loadImage("fan.png");
  private float x = width /6;
  private float y = height / 10 - 45;
  private int angle = 0;
  private int hp = 30;
  private int attack = 20;
  

   
  void draw() {
    image(fan, x, y);
    if (frameCount % 100 == 0) slowCurveShotL();
    if (frameCount % 120 == 0) slowCurveShotR();
    if (frameCount % 60 == 0) snipeShot();
  }
  
  void slowCurveShotL() {
    Bullet bullet = new Bullet(x, y, angle, 1, 0.2);
    bulletList.add(bullet);
  }
  
  void slowCurveShotR() {
    Bullet bullet = new Bullet(x+300, y, angle, -1, -0.2);
    bulletList.add(bullet);
  }
  
  void snipeShot() {
    float dx = player.x - x;
    float dy = player.y - y;
    float degree = degrees(atan2(dy,dx));
    Bullet bullet = new Bullet(x+100, y, degree, 2, 0);
    bulletList.add(bullet);
  }
}