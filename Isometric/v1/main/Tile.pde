class Tile {
  float x, y, z;
  PShape tile;
  PShape top, left, right;

  Tile(int x, int y) {
    this.x = x;
    this.y = y;

    this.top = createShape();
    this.top.beginShape();
//    this.top.noStroke();
//    this.top.fill(random(100, 200), 0, random(100, 200));

    // Draw top
    this.top.vertex(-tileWidth/2, tileHeight/2);
    this.top.vertex(0, 0);
    this.top.vertex(tileWidth/2, tileHeight/2);   
    this.top.vertex(0, tileHeight);

    this.top.endShape(CLOSE);

    this.left = null;
    this.right = null;
  }

  Tile(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;

    this.top = createShape();
    this.top.beginShape();
    this.top.stroke(255);
    this.top.fill(#EEEEEE);

    // Draw top
    this.top.vertex(-tileWidth/2, tileHeight/2 - this.z * tileHeight);
    this.top.vertex(0, -this.z * tileHeight);
    this.top.vertex(tileWidth/2, tileHeight/2 - this.z * tileHeight);   
    this.top.vertex(0, tileHeight - this.z * tileHeight);

    this.top.endShape();

    // Draw Left
    this.left = createShape();
    this.left.beginShape();
    this.left.stroke(255);
    this.left.fill(#CCCCCC);

    this.left.vertex(0, tileHeight);
    this.left.vertex(-tileWidth/2, tileHeight/2);
    this.left.vertex(-tileWidth/2, tileHeight/2 - this.z * tileHeight);
    this.left.vertex(0, tileHeight - this.z * tileHeight);

    this.left.endShape();

    // Draw Right
    this.right = createShape();
    this.right.beginShape();
    this.right.stroke(255);
    this.right.fill(#AAAAAA);

    this.right.vertex(0, tileHeight);
    this.right.vertex(0, tileHeight - this.z * tileHeight);
    this.right.vertex(tileWidth/2, tileHeight/2 - this.z * tileHeight);   
    this.right.vertex(tileWidth/2, tileHeight/2);   

    this.right.endShape();
  }

  void render() {
    pushMatrix();
    translate((this.x - this.y) * tileWidth/2, (this.x + this.y) * tileHeight/2);
    shape(this.top, this.x, this.y);
    shape(this.left, this.x, this.y);
    shape(this.right, this.x, this.y);
    
    popMatrix();
  }
}