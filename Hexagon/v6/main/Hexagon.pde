class Hexagon {
  PVector l;
  PShape s;
  boolean [] neighbours;
  ArrayList<Hexagon> myNeighbours;
  int id;

  Hexagon(float x, float y) {
    this.l = new PVector(x, y);
    this.s = createShape();

    this.s.beginShape();
    color thisColor = (rgb[int(random(rgb.length))]);
    this.s.fill(thisColor);
    this.s.stroke(thisColor,100);

    for (float a = PI/2; a < PI/2 + TWO_PI; a += alpha) {
      float px = cos(a) * (r);
      float py = sin(a) * (r);
      this.s.vertex(px, py);
    }

    this.s.endShape();
    
    this.id = h_id++;
  }

  void setNeighbour(int i) {
    this.neighbours[i] = true;
  }

  void render() {
    shape(this.s, this.l.x, this.l.y);
  }
}
