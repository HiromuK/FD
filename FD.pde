PFont font;
NanoBoardAG[] nb;
int[] arrayOfPortID = {0};
ArrayList<Bullet> bulletList;
ArrayList<Slash> slashList;
Enemy enemy;
Player player;

int counter = 0;

// マウスクリックでリスタート
void mouseClicked() {
  size(500, 500);
  noStroke();
  bulletList = new ArrayList<Bullet>();
  slashList = new ArrayList<Slash> ();
  enemy = new Enemy();
  player = new Player();
}

void setup() {
  size(500, 500);
  noStroke();
  
  // NanoBoardAG導入
  nb = new NanoBoardAG[arrayOfPortID.length];
  for(int i = 0; i< arrayOfPortID.length; i++){
    nb[i] = new NanoBoardAG(this, arrayOfPortID[i]);
  }

  bulletList = new ArrayList<Bullet>();
  slashList = new ArrayList<Slash> ();
  enemy = new Enemy();
  player = new Player();
}

void draw() {
  fill(255, 255, 255);
  rect(0, 0, width, height);

  // Enemyの攻撃当たり判定
  fill(255, 0, 0);
  for (int i = bulletList.size()-1; i >= 0; i--) {
    Bullet bullet = bulletList.get(i);
    bullet.move();
    bullet.draw();
    if (collision(player.x+30, player.y+15, 25, 25, bullet.x, bullet.y, 36, 36)) {
      bullet.hit = true;
      player.hp = player.hp - enemy.attack;
    }
    if (bullet.needRemove()) bulletList.remove(i);
  }
  
  // Playerの攻撃当たり判定
  fill(0, 0, 255);
  for (int i = slashList.size()-1; i >= 0; i--) {
    Slash slash = slashList.get(i);
    slash.move();
    slash.draw();
    if (collision(enemy.x*3, enemy.y, 50, 20, slash.x, slash.y, slash.w, slash.h)) {
      slash.hit = true;
      enemy.hp = enemy.hp - player.attack;
    }
    if (slash.needRemove()) slashList.remove(i);
  }
  
  // Enemy描画
  fill(255, 255, 255);
  enemy.draw();
  
  // Player描画
  fill(0, 0, 0);
  player.move();
  player.setX((int)(nb[0].getValSlider() * 5 - 10));
  player.draw();
  // 音が鳴ったら攻撃(斬撃を飛ばす)
  if (nb[0].getValSound() > 30) {
    if (counter < 5) {
      player.flyingslash();  // 同時数制御
      counter++;
    }
  }
  if (nb[0].getValButton() > 50)  counter = 0;
  

  // HP表示
  fill(255, 0, 0);
  text("Player:" + nf(player.hp, 3) , 20, 20);
  text("Enemy:" + nf(enemy.hp, 3) , 20, 40); 
  text("Slider: " + nf((int)nb[0].getValSlider(), 3) , 20, 60);

  // モーター制御
  if (enemy.hp == 0)  nb[0].setMotorPower(0);
  if (enemy.hp > 0)  nb[0].setMotorPower(100);
  
  // 最新のセンサーデータ取得
  for(int i = 0; i< arrayOfPortID.length; i++){
    nb[i].sendData();
  }
  
  // 終了判定
  if (player.hp == 0 || enemy.hp == 0) {
    noLoop(); // game over
  }
}

// 衝突判定
boolean collision(float x1, float y1, float w1, float h1,
                  float x2, float y2, float w2, float h2) {
  if (x1 + w1/2 < x2 - w2/2) return false;
  if (x2 + w2/2 < x1 - w1/2) return false;
  if (y1 + h1/2 < y2 - h2/2) return false;
  if (y2 + h2/2 < y1 - h1/2) return false;
  return true;
}

// シリアル通信からデータが送出されたことを検知するイベント
void serialEvent(Serial p){
  for(int i = 0; i< arrayOfPortID.length; i++){
    nb[i].serialEvent(p);
  }  
}