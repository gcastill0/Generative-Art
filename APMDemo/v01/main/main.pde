Container c1, c2;
Connector cn;
Grid g;

void setup() {
  size(1600, 900);

  c1 = new Container(new PVector(100, 100), 50, 50);
  c2 = new Container(new PVector(400, 400), 50, 50);
  cn = new Connector(new PVector(425, 425), new PVector(125, 125));
  g = new Grid();
}

void draw() {
  background(255);
  c1.render();
  c2.render();
  cn.render();
  g.render();
}

class Connector {
  PVector s, e;
  
  Connector(PVector s, PVector e) {
    this.s = s;
    this.e = e;
  }
  
  void render() {
    line(this.s.x, this.s.y, this.e.x, this.e.y);
  }
}

class Container {
  PVector l;
  int w, h;

  Container(PVector l, int w, int h) {
    this.l = l;
    this.w = w;
    this.h = h;
  }

  void render() {
    stroke(3, 150);
    strokeWeight(3);
    rect(this.l.x, this.l.y, this.w, this.h, 3);
  }
}

class Grid {
  Grid() {
  }

  void render() {
    stroke(150, 100);
    strokeWeight(1);
    noFill();
    for (int x = (width%150)/2; x < width && (x+150<=width) ; x+=150) {
      for (int y = (height%150)/2; y < height && (y+150<=height); y += 150) {
        rect(x, y, 150, 150);
      }
    }
  }
}
