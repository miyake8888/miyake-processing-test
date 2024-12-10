int numOfSegments = 12; // 万華鏡のセグメント数
float angleStep; // セグメントの角度

void setup() {
  size(600, 600);
  angleStep = TWO_PI / numOfSegments; // 1セグメントの角度
  noStroke();
}

void draw() {
  background(0); // 背景色を黒に設定
  translate(width / 2, height / 2); // 中心を基準にする

  float sizeFactor = map(mouseX, 0, width, 5, 50); // マウス位置に応じて図形サイズを変化
  float colorFactor = map(mouseY, 0, height, 0, 255); // マウス位置に応じて色を変化

  for (int i = 0; i < numOfSegments; i++) {
    pushMatrix();
    rotate(angleStep * i); // 各セグメントに回転を適用

    // 図形の描画
    fill(colorFactor, 255 - colorFactor, 150, 150); // 色の設定
    ellipse(mouseX / 5, mouseY / 5, sizeFactor, sizeFactor); // 図形を描画

    popMatrix();
  }
}
