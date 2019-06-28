class Point {
  private PVector location;
  
  Point(float x, float y) {
    this.location = new PVector(x,y);
  }
  
  float getX() {
    return this.location.x;
  }

  float getY() {
    return this.location.y;
  }
  
  PVector getLocation() {
    return this.location;
  }
  
  void draw() {
    ellipse(this.location.x, this.location.y,5,5);
  }

}