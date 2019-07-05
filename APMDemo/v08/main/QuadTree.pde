class QuadTree {
  Area area;
  ArrayList<PVector> points;
  ArrayList<QuadTree> subtree;
  boolean divided;
  color strk;

  QuadTree(Area area) {
    this.area    = area;
    this.points  = new ArrayList<PVector>();
    this.subtree = new ArrayList<QuadTree>();
    this.divided = false;
    this.strk = color(#222222, 150);
  }

  void subdivide() {

    this.subtree.add(new QuadTree(new Area(  this.area.x, this.area.y, this.area.w/2, this.area.h/2 )));
    this.subtree.add(new QuadTree(new Area(  this.area.x, this.area.y + this.area.h/2, this.area.w/2, this.area.h/2 )));
    this.subtree.add(new QuadTree(new Area(  this.area.x + this.area.w/2, this.area.y, this.area.w/2, this.area.h/2 )));
    this.subtree.add(new QuadTree(new Area(  this.area.x + this.area.w/2, this.area.y + this.area.h/2, this.area.w/2, this.area.h/2 )));

    this.divided = true;
  }

  void insert(PVector p) {
    if (this.area.contains(p) == false) return;

    if (this.points.size() < QUADTREE_CAPACITY) {
      this.points.add(p);
    } else {
      if (this.divided == false) {
        this.subdivide();
      }

      for (QuadTree branch : subtree) {
        branch.insert(p);
      }
    }
  }

  ArrayList<PVector> find(Area area) {
    ArrayList<PVector> pointsFound = new ArrayList<PVector>();
    ArrayList<PVector> pointsRange = new ArrayList<PVector>();

    for (QuadTree branch : subtree) {
      pointsRange.addAll(branch.find(area));
    }

    if (this.area.instersects(area) == false) return pointsRange;
    else {
      pointsRange.addAll(this.points);
    }

    for (PVector p : pointsRange) {
      if (area.contains(p) == true) {
        pointsFound.add(p);
      }
    }

    return pointsFound;
  }

  int Size() {
    int s = 0;

    for (QuadTree branch : subtree) {
      s += branch.Size();
    }

    s += this.points.size();

    return s;
  }

  void render() {

    for (QuadTree branch : subtree) {
      branch.render();
    }

    stroke(#CCCCFF, 100);
    strokeWeight(1);
    this.area.render();
    //this.area.write(""+this.points.size());

    for (PVector p : this.points) {      
      stroke(#7FA6FF, 150);
      strokeWeight(4);
      point(p.x, p.y);
      
      stroke(#7FA6FF, 50);
      strokeWeight(2);
      rect(p.x-CELL/2, p.y-CELL/2, CELL, CELL);
    }
  }
}
