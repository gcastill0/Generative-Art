class Point {
  private PVector position;
  private PVector destination;
  private boolean needsUpdate;
  private boolean moveComplete;

  Point(float x, float y) {
    this.position = new PVector(x, y);
    this.destination = null;
    this.needsUpdate = false;
    this.moveComplete = false;
  }

  void moveTo(float x, float y) {
    this.destination = new PVector(x, y);
    float dist = PVector.dist(this.position, this.destination);
    if (this.needsUpdate == false && dist > 0.05) {
      this.needsUpdate = true;
      this.moveComplete = false;
    }
  }

  void moveTo(PVector dest) {
    this.destination = dest;
    float dist = PVector.dist(this.position, this.destination);
    if (this.needsUpdate == false && dist > 0.05) {
      this.needsUpdate = true;
      this.moveComplete = false;
    }
  }

  boolean moveCompleted() {
    return this.moveComplete;
  }

  void update() {
    if (this.needsUpdate) {
      float dist = PVector.dist(this.position, this.destination);

      if (dist < 0.01) {
        this.destination = null;
        this.needsUpdate = false;
        this.moveComplete = true;
        println("Done!");
      } else {
        position.lerp(destination, 0.05);
      }
    }
  }

  void render() {
    if (this.needsUpdate) {
      line(position.x, position.y,width/2, height/2);
    stroke(255, 0, 0, 10);
    for (float a = 0; a < 360; a++) {
      float x = position.x + cos(radians(a)) * random(1, 20);
      float y = position.y + sin(radians(a)) * random(1, 20);
      fill(255, 0, 0, 10);
      ellipse(x, y, 1, 1);
    }
    fill(255, 0, 0);
    line(position.x, position.y, width/2, height/2);
    ellipse(position.x, position.y, 10, 10);
    }
  }
}