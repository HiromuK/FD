
class Player {
  private PImage player = loadImage("samurai.png");
  private float x = width / 2 - 10;    // 初期位置画面中央
  private float y = height - 100;  // 
  private int hp = 100;           // 初期HP
  private int attack = 3;        // 初期攻撃力
  
  void move() {
    if (keyPressed) {  // キーが押されているときだけ・・・
      switch (keyCode) {
        case UP:    y -= 2; break; // UP(38) ()内は実際のkeyCode定数値 (参考までに)
        case DOWN:  y += 2; break; // DOWN(40)
        case LEFT:  x -= 2; break; // LEFT(37)
        case RIGHT: x += 2; break; // RIGHT(39)
      }
    }
    // 画面端から三角形がはみ出ないようにチェックする
    if (x-10 < 0)      x = 10;
    if (x+10 > width)  x = width-10;
    if (y-10 < 0)      y = 10;
    if (y+10 > height) y = height-10;
  }
  
  void draw() {
    image(player, x, y, 100, 100);
    //if (frameCount % 60 == 0) flyingslash();
  }
  
  void flyingslash() {
    slashList.add(new Slash(x, y, -90, 2, 20));
  }
  
  void setX(int x){
    this.x = x;
  }
  
}