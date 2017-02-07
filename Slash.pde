
class Slash extends Bullet {
  private float w;
  private float h;
  
  Slash (float x, float y, float angle, float w, float h) {
    super(x, y, angle, 3, 0);
    this.w = w;
    this.h = h;
  }
  void draw() {
    rect(x-w/2, y-h/2, w, h);
  }
}