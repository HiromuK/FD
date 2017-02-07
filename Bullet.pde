
class Bullet {
  private PImage wind = loadImage("wind.png");
  float x;
  float y;
  private float angle;
  private float speed;
  private float angleSpeed;
  boolean hit = false;
  
  Bullet (float x, float y, float angle, float speed, float angleSpeed) {
    this.x = x; 
    this.y = y;
    this.angle = angle;
    this.speed = speed;
    this.angleSpeed = angleSpeed;
  }
  
  void move() {
    angle = (angle + angleSpeed) % 360;
    x += cos(radians(angle)) * speed;
    y += sin(radians(angle)) * speed;
  }
  
  void draw() {
    image(wind,x, y);
  }
  
  boolean needRemove() {
    return x < 0 || x > width || y < 0 || y > height || hit;
  }
}