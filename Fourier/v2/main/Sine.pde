class Sine {
  PVector o;
  PVector n;
  float a;
  float f;
  float inc;
  int p;
  boolean done;

  Sine(float a, int p) {
    this.o = new PVector();
    this.n = new PVector();
    this.p = p;
    this.a = a * (4 / (this.p * PI));
    this.f = 0;
    this.inc = random(-0.01, 0.01);//pi_vals[int(random(pi_vals.length))]/(360);
    this.done = false;
  }

  void setO(float x, float y) {
    this.o.set(x, y);
    this.update();
  }

  void setO(PVector o) {
    this.o = o;
    this.update();
  }

  PVector getN() {
    return this.n;
  }

  void update() {
    this.n.x = this.o.x + cos(this.p * this.f) * this.a;
    this.n.y = this.o.y + sin(this.p * this.f) * this.a;
    //this.f  += 0.01;
    this.f  += this.inc;
  }

  void render() {
    stroke(0);
    strokeWeight(2);
    line(this.o.x, this.o.y, this.n.x, this.n.y);
    stroke(0, 100);
    strokeWeight(1);
    noFill();
    ellipse(this.o.x, this.o.y, this.a * 2, this.a * 2);
  }
}
