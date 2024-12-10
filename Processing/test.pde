int numOfSegments = 12; // 万華鏡のセグメント数
float angleStep; // セグメントの角度

ArrayList<Particle> particles = new ArrayList<Particle>(); // 粒子のリスト

void setup() {
  size(600, 600);
  angleStep = TWO_PI / numOfSegments; // 1セグメントの角度
  noStroke();
}

void draw() {
  background(0); // 背景色を黒に設定
  translate(width / 2, height / 2); // キャンバスの中心を基準にする

  float sizeFactor = map(mouseX, 0, width, 5, 50); // マウス位置に応じて図形サイズを変化
  float colorFactor = map(mouseY, 0, height, 0, 255); // マウス位置に応じて色を変化

  for (int i = 0; i < numOfSegments; i++) {
    pushMatrix();
    rotate(angleStep * i); // 各セグメントに回転を適用

    // 図形の描画
    fill(colorFactor, 255 - colorFactor, 150, 150); // 色の設定
    ellipse((mouseX - width / 2) / 5, (mouseY - height / 2) / 5, sizeFactor, sizeFactor); // 図形を描画

    popMatrix();
  }

  // 粒子エフェクトの処理
  updateParticles();
  displayParticles();
}

// 粒子のエフェクトを管理する
void updateParticles() {
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    if (p.isDead()) {
      particles.remove(i); // 死んだ粒子を削除
    }
  }
}

// 粒子を画面に描画する
void displayParticles() {
  for (Particle p : particles) {
    p.display();
  }
}

// マウスの動きで新しい粒子を生成
void mouseDragged() {
  for (int i = 0; i < 5; i++) { // 複数の粒子を作成する
    particles.add(new Particle(mouseX, mouseY));
  }
}

// 粒子を表現するクラス
class Particle {
  float x, y; // 粒子の位置
  float vx, vy; // 粒子の速度
  float life; // 粒子の寿命

  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    this.vx = random(-2, 2); // ランダムな速度を設定
    this.vy = random(-2, 2);
    this.life = 255; // 寿命を最大値255に設定
  }

  void update() {
    x += vx; // 位置を更新
    y += vy;
    life -= 4; // 寿命を減少
  }

  void display() {
    fill(255, life); // 色を寿命に応じて減衰
    ellipse(x - width / 2, y - height / 2, 5, 5); // 粒子の描画
  }

  boolean isDead() {
    return life < 0; // 寿命が0以下になったら「死んだ」とみなす
  }
}
