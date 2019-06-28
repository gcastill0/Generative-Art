class Connection {

  PVector source, destination;
  ArrayList<Dot> dots;
  PVector[] path;
  
  // Properties
  // Fill tight, normal, lose [10,20,40]
  float fill = 20;

  Connection() {
    source = null;
    destination = null;
    path = null;
    dots = new ArrayList<Dot>();
  }

  void setSource(PVector s) {
    this.source = s.copy();
  }

  void setDestination(PVector d) {
    this.destination = d.copy();
  }

  void setSource(float x, float y) {
    this.source = new PVector(x, y);
  }

  void setDestination(float x, float y) {
    this.destination = new PVector(x, y);
  }

  void calculatePath() {
    if (this.path == null) {
      if (this.source != null && this.destination != null) {
        float dist = PVector.dist(this.source, this.destination);
        int nPoint = ceil((dist/fill));

        float x = this.source.x;
        float y = this.source.y;
        float a = atan2(this.destination.y - this.source.y, this.destination.x - this.source.x); 

        for (int i=0; i < nPoint-1; i++) {
          PVector s = new PVector(x, y);
          x = x + cos(a) * fill;
          y = y + sin(a) * fill;
          PVector d = new PVector(x, y);
          dots.add( new Dot(s, d));
        }
      }
    }
  }

  void update() {
    for (Dot dot : dots) {
      dot.update();
    }
  }

  void render() {
    for (Dot dot : dots) {
      dot.render();
    }
  }
}