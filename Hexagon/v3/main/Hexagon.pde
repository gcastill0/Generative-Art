class Hexagon {
  PVector l;
  PShape s;
  boolean [] neighbours;
  //  Hexagon [] myNeighbours;
  ArrayList<Hexagon> myNeighbours;
  int id;

  Hexagon(float x, float y) {
    this.l = new PVector(x, y);
    this.s = createShape();

    this.s.beginShape();
    this.s.stroke(0,50);
    this.s.fill(rgb[int(random(rgb.length))], 50);

    for (float a = PI/2; a <= PI/2 + TWO_PI; a += alpha) {
      float px = cos(a) * (r);
      float py = sin(a) * (r);
      this.s.vertex(px, py);
    }

    this.s.endShape();

    this.neighbours = new boolean [sides];

    for (boolean n : this.neighbours) {
      n = false;
    }

    this.myNeighbours = new ArrayList<Hexagon>();
    //    this.myNeighbours = new Hexagon[6];

    this.id = ++h_id;
  }

  void setNeighbour(int i) {
    this.neighbours[i] = true;
  }

  ArrayList<Hexagon> expandNeighbours() {

    ArrayList<Hexagon> newNeighbours = new ArrayList<Hexagon>();
    int side = 0;

    for (float a = 0; (round( a * 100000.0f ) / 100000.0f) <= TWO_PI && this.id < 8; a += alpha, side++) {

      if (this.neighbours[side] == true) continue;

      float x = this.l.x + cos(a) * r * 2 ;
      float y = this.l.y + sin(a) * r * 2 ;

      //      if (x < (-r/2) || y < (-r/2) || x>(width+r/2) || y > (height+r/2)) continue;
      if ( (x > r/2 && x < width-r/2) && (y > r/2 && y < height-r/2)) {

        Hexagon h = new Hexagon(x, y);
        h.setNeighbour(((side+3)-1)%sides);
        h.setNeighbour(((side+3)+0)%sides);      
        h.setNeighbour(((side+3)+1)%sides);

        //h.render();

        newNeighbours.add(h);
        //        newNeighbours.addAll(h.expandNeighbours());

        this.setNeighbour(side);
        this.myNeighbours.add(h);
      }

      println(this.id, a, "x:", x, "y:", y, newNeighbours.size());
    }

    for (Hexagon h : this.myNeighbours) {
      newNeighbours.addAll(h.expandNeighbours());
    }

    return newNeighbours;
  }

  void showNeighbours() {
    int i = 0;
    for (float a = 0; (round( a * 100000.0f ) / 100000.0f) <= TWO_PI; a += alpha, i++) {
      float x = this.l.x + cos(a) * r * 2 ;
      float y = this.l.y + sin(a) * r * 2 ;
      if (this.neighbours[i] == false) {
        ellipse(x, y, 5, 5);
        //text(i, x, y+4);
        //text((i+3)%6, x+10, y+4);
        //text(((i+3)+1)%6, x+10, y-12);
        //text(((i+3)-1)%6, x+10, y+16);
      }
      //shape(this.s, nx, ny);
    }
  }

  void render() {
    shape(this.s, this.l.x, this.l.y);
    //text(this.id, this.l.x, this.l.y);
    //println(this.id, this.l.x, this.l.y);
    

    //for (boolean n : this.neighbours) {
    //  print(n, "\t");
    //}
    //println();
    //println(this.myNeighbours);
  }
}