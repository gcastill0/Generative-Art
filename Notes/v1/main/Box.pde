int tSize = 32;
int tBuff = int(tSize*3);

class Box {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector pre;
  float w, h;
  String t;

  PVector p1, p2, p3, p4;
  boolean p1d = false, p2d = false, p3d = false, p4d = false;
  boolean boxComplete = false;
  boolean textWritten = false;
  boolean needsUpdate = true;

  Box(String s, float x, float y) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.pre = new PVector();
    this.t = s;

    textSize(32);
    textLeading(6);

    this.w = textWidth(this.t)+tBuff;
    this.h = tSize+tBuff;

    float tx, ty;
    // From the top-left to the top-right
    tx = this.pos.x + this.w;
    ty = this.pos.y;
    p1 = new PVector(tx, ty);

    // From the top-right to the bottom-right
    tx = this.pos.x + this.w;
    ty = this.pos.y + this.h;
    p2 = new PVector(tx, ty);

    // From the bottom-right to the bottom-left
    tx = this.pos.x;
    ty = this.pos.y + this.h;
    p3 = new PVector(tx, ty);

    // From the bottom-left to the top-left
    tx = this.pos.x;
    ty = this.pos.y;
    p4 = new PVector(tx, ty);
  }

  Box(float x, float y, float w, float h) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.pre = new PVector();
    this.t = "?";
    this.w = w;
    this.h = h;

    float tx, ty;
    // From the top-left to the top-right
    tx = this.pos.x + this.w;
    ty = this.pos.y;
    p1 = new PVector(tx, ty);

    // From the top-right to the bottom-right
    tx = this.pos.x + this.w;
    ty = this.pos.y + this.h;
    p2 = new PVector(tx, ty);

    // From the bottom-right to the bottom-left
    tx = this.pos.x;
    ty = this.pos.y + this.h;
    p3 = new PVector(tx, ty);

    // From the bottom-left to the top-left
    tx = this.pos.x;
    ty = this.pos.y;
    p4 = new PVector(tx, ty);
  }

  void update() {
    if (this.needsUpdate) {
      this.pre = this.pos.copy();
      this.vel.add(this.acc);
      this.pos.add(this.vel);
      this.acc.mult(0);
    }
  }

  void render() {

    if (!boxComplete) {
      if (!p1d) {
        p1d = this.easeTo(p1); 
        line(this.p4.x, this.p4.y, this.pos.x, this.pos.y);
      } else if (!p2d) {
        p2d = this.easeTo(p2); 
        line(this.p4.x, this.p4.y, this.p1.x, this.p1.y);
        line(this.p1.x, this.p1.y, this.pos.x, this.pos.y);
      } else if (!p3d) {
        p3d = this.easeTo(p3); 
        line(this.p4.x, this.p4.y, this.p1.x, this.p1.y);
        line(this.p1.x, this.p1.y, this.p2.x, this.p2.y);
        line(this.p2.x, this.p2.y, this.pos.x, this.pos.y);
      } else if (!p4d) {
        p4d = this.easeTo(p4); 
        line(this.p4.x, this.p4.y, this.p1.x, this.p1.y);
        line(this.p1.x, this.p1.y, this.p2.x, this.p2.y);
        line(this.p2.x, this.p2.y, this.p3.x, this.p3.y);
        line(this.p3.x, this.p3.y, this.pos.x, this.pos.y);
      } else {
        fill(#0E4671);
        rect(this.pos.x, this.pos.y, this.w, this.h);
        fill(#A9DAFF);
        text(this.t, this.pos.x + this.w/2, this.pos.y + this.h/2);
        this.boxComplete = true;
      }
    } else {
      fill(#0E4671);
      rect(this.pos.x, this.pos.y, this.w, this.h);
      fill(#A9DAFF);
      text(this.t, this.pos.x + this.w/2, this.pos.y + this.h/2);
      this.textWritten = true;
      this.needsUpdate = false;
    }
  }

  void moveTo(float x, float y) {
    PVector dest = new PVector(x, y);

    float dx = (dest.x - this.pos.x) * 0.1;
    float dy = (dest.y - this.pos.y) * 0.1;

    this.vel.set(dx, dy);

    if (abs(dx) <= 0.1 && abs(dy) <= 0.1) {
      this.vel.set(0, 0);
      this.needsUpdate = false;
      return;
    }

    this.needsUpdate = true;
  }

  boolean easeTo(PVector dest) {

    float dx = (dest.x - this.pos.x) * 0.1257;
    float dy = (dest.y - this.pos.y) * 0.1257;

    this.vel.set(dx, dy);

    if (abs(dx) <= 0.1 && abs(dy) <= 0.1) {
      this.vel.set(0, 0);
      return true;
    }

    return false;
  }

  void linkTo(Box dest) {
  }
}