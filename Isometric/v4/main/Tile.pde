class Tile {
  float x, y, z;
  float w = 1;
  float h = 1;
  PShape tile;
  PShape top, left, right;

  Tile(int x, int y) {
    this.x = x;
    this.y = y;

    this.tile = createShape(GROUP);

    this.top = this.drawTop();
    this.tile.addChild(this.top);

    this.left = null;
    this.right = null;
  }

  Tile(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;

    this.tile = createShape(GROUP);

    this.left = this.drawLeft();
    this.tile.addChild(this.left);

    this.right = this.drawRight();
    this.tile.addChild(this.right);

    this.top = this.drawTop();
    this.tile.addChild(this.top);
  }

  Tile(float x, float y, float z, int w, int h) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w * 1.0;
    this.h = h * 1.0;

    this.tile = createShape(GROUP);

    this.left = this.drawLeft();
    this.tile.addChild(this.left);

    this.right = this.drawRight();
    this.tile.addChild(this.right);

    this.top = this.drawTop();
    this.tile.addChild(this.top);
  }

  private PShape drawTop() {
    // Draw Top
    PShape p = createShape();    
    p.beginShape();
    p.stroke(#623CE4);
    //p.noStroke();
    p.fill(#623CE4);
    p.vertex(-tileWidth/2, tileHeight/2 - this.z * tileHeight);
    p.vertex(0, -this.z * tileHeight);
    p.vertex(tileWidth/2, tileHeight/2 - this.z * tileHeight);   
    p.vertex(0, tileHeight - this.z * tileHeight);
    p.endShape();

    return p;
  }

  private PShape drawLeft() {
    // Draw Left
    PShape p = createShape();    
    p = createShape();
    p.beginShape();
    p.stroke(#A28CE8);
    p.noStroke();
    p.fill(#3C2AA8);
    p.vertex(0, tileHeight);
    p.vertex(-tileWidth/2, tileHeight/2);
    p.vertex(-tileWidth/2, tileHeight/2 - this.z * tileHeight);
    p.vertex(0, tileHeight - this.z * tileHeight);
    p.endShape();

    return p;
  }

  private PShape drawRight() {
    // Draw Right
    PShape p = createShape();    
    p = createShape();
    p.beginShape();
    p.stroke(#A28CE8);
    p.noStroke();
    p.fill(#2A1C73);
    p.vertex(0, tileHeight);
    p.vertex(0, tileHeight - this.z * tileHeight);
    p.vertex(tileWidth/2, tileHeight/2 - this.z * tileHeight);   
    p.vertex(tileWidth/2, tileHeight/2);   
    p.endShape();

    return p;
  }

  void render() {
    pushMatrix();
    translate((this.x - this.y) * tileWidth/2, (this.x + this.y) * tileHeight/2);
    shape(this.tile);    
    popMatrix();
  }
}
