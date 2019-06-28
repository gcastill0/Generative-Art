class Dot {
  PVector source;
  PVector mover;
  PVector dest;
  boolean done;

  Dot(PVector s) {
    this.source = s.copy();
    this.mover  = s.copy();
    this.dest   = null;
    this.done   = false;
  }

  Dot(PVector s, PVector d) {
    this.source = s.copy();
    this.mover  = s.copy();
    this.dest   = d.copy();
    this.done   = false;
  }

  Dot(float x, float y) {
    this.source = new PVector(x, y);
    this.mover  = new PVector(x, y);
    this.dest   = null;
    this.done   = false;
  }

  Dot(float x1, float y1, float x2, float y2) {
    this.source = new PVector(x1, y1);
    this.mover  = new PVector(x1, y1);
    this.dest   = new PVector(x2, y2);
    this.done   = false;
  }

  void update() {
    float dist = PVector.dist(this.mover, this.dest);
    if (dist > 0.05) {
      this.mover = PVector.lerp(this.mover, this.dest, 0.25);
    } else {
      this.mover  = source.copy();
    }
  }

  void render() {
    ellipse(this.mover.x, this.mover.y, 5, 5);
  }
}