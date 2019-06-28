class Path {
  private ArrayList<PVector> points;
  private ArrayList<Point> bees;
  private int numOfBees;
  private boolean isInitialized;
  private boolean needsUpdate;

  Path() {
    this.numOfBees = 3;
    this.isInitialized = false;

    this.initializeMove();
  }

  void setNumberOfBees(int num) {
    this.numOfBees = num;
    this.initializeMove();
  }

  void addBee(float x, float y) {
    Point bee = new Point(x, y);
    this.bees.add(bee);
  }

  void addPoint(float x, float y) {
    PVector point = new PVector(x, y);
    points.add(point);
  }

  private void initializeMove() {
    if (this.isInitialized) return;

    this.points = new ArrayList<PVector>();
    this.bees = new ArrayList<Point>();

    float angle = 0.0;
    float angleIncrement = 360/this.numOfBees;
    float midx = width/2;
    float midy = height/2;
    float len = (width+height) / 2 / 3;

    for (int i=0; i < this.numOfBees; i++) {
      float x = midx + (cos(radians(angle))) * len;
      float y = midy + (sin(radians(angle))) * len;

      this.addPoint(x, y);

      angle += angleIncrement;
      x = midx + cos(radians(angle)) * len;
      y = midy + sin(radians(angle)) * len;
      //x = midx + cos(random(-PI,PI)) * random(len/2,len);
      //y = midy + sin(random(-PI,PI)) * random(len/2,len);

      this.addBee(x, y);
    }
  }

  void update() {

    if (this.bees.get(this.numOfBees-1).moveCompleted()) this.needsUpdate = false;
    else this.needsUpdate = true;

    if (this.needsUpdate) {
      for (int i=0; i < this.numOfBees; i++) {
        PVector p = this.points.get(i);
        Point b = this.bees.get(i);

        b.moveTo(p);
        b.update();
      }
    }
  }

  void render() {
    for (Point b : bees) {
      b.render();
    }
  }
}