class Area {
  float x, y, h, w;

  Area(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
  }

  boolean contains(PVector p) {
    if (
      p.x > this.x && p.x < (this.x + this.w) &&
      p.y > this.y && p.y < (this.y + this.h) 
      ) {
      return true;
    }

    return false;
  }

  boolean contains(float x, float y) {
    if (
      ( x < this.x || x > (this.x + this.w)) &&
      ( y < this.y || y > (this.y + this.h))
      ) {
      return false;
    }

    return true;
  }
  
  boolean instersects(Area area) {
    if ( 
      area.contains(this.x, this.y) == true                   || this.contains(area.x, area.y) == true           ||
      area.contains(this.x + this.w, this.y) == true          || this.contains(area.x + area.w, area.y) == true  ||
      area.contains(this.x, this.y + this.h) == true          || this.contains(area.x, area.y + area.h) == true  ||
      area.contains(this.x + this.w, this.y + this.h) == true || this.contains(area.x + area.w, area.y + area.h) == true
      )      
      return true;

    return false;
  }

  void render() {
    //rect(this.x, this.y, this.w, this.h);
  }

  void write(String s) {
    noStroke();
    fill(#FF0000, 100);
    float tw = textWidth(s);
    float th = 10.0;
    textSize(th);
    text(s, this.x + this.w/2, this.y + this.h/2);
    noFill();
  }
}
