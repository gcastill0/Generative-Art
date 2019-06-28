class Path {
  private ArrayList<PVector> path;
  private PVector end;
  Path () {
    this.path = new ArrayList<PVector>();
    this.end  = null;
  }
  
  void setStart(float x, float y) {
    this.path.add(new PVector(x,y));
  }
  
  void setDestination(float x, float y) {
    this.end = new PVector(x,y);
  }
  
  private void calculatePoints() {
    if (this.end == null) return;
    
    
  }
}