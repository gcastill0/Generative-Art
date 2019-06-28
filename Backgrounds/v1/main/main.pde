ArrayList<Dot> Dots;
int nDots;

void setup() {
  size(1280, 720);
  nDots = 100;
  Dots = new ArrayList<Dot>();
}

void draw() {
  background(0);
  
  if(Dots.size() < nDots) {
    Dot d = new Dot(new PVector(random(width), random(height)));
    Dots.add(d);
  }

  for (Dot d : Dots) {
    d.update();
    d.render();
  }

}

class Dot {
  PVector l, v, d;
  
  Dot(PVector l) {
    this.l = l;
    this.v = PVector.random2D();
    this.d = PVector.random2D();
  }
  
  void update() {
    if (this.l.x >= width)  this.l.x = 0;
    if (this.l.y >= height) this.l.y = 0;
    
    this.l.add(this.v);
    this.d.x += cos(this.d.x) * 1;
    this.d.y += sin(this.d.x) * 1;
    this.l.add(this.d);
  }
  
  void render() {
    ellipse(this.l.x, this.l.y, 10, 10);
  }
}
