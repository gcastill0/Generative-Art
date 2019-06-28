class Particle {
  PVector pos;
  PVector vel;
  PVector acc;

  Particle() {
    this.pos = PVector.random2D();
    this.vel = PVector.random2D();
    this.acc = new PVector();
  }

  Particle(float x, float y) {
    this.pos = new PVector(x,y);
    this.vel = PVector.random2D();
    this.acc = new PVector();
  }

  void update() {
    this.pos.add(this.vel);
    this.pos.add(this.acc);
  }
  
  void setPos(float x, float y) {
    this.pos.x = x;
    this.pos.y = y;
  }

  void setVel(float x, float y) {
    this.pos.x = x;
    this.pos.y = y;
  }

  void setAcc(float x, float y) {
    this.pos.x = x;
    this.pos.y = y;
  }

  void render() {
    stroke(#FF0000);
    point(this.pos.x, this.pos.y, this.pos.z);
  }

  void renderSphere() {
    pushMatrix();
    translate(this.pos.x, this.pos.y, this.pos.z);
    sphere(1);
    popMatrix();
  }

  void renderLine(Particle des) {
    float d = PVector.dist(this.pos, des.pos);
    if (d < 100) {
      strokeWeight(1/d);
      line(this.pos.x, this.pos.y, des.pos.x, des.pos.y);
      strokeWeight(1);
    }
  }
}

float r(float theta, float a, float b, float m, float n1, float n2, float n3) {  
  return pow(pow(abs(cos(m * theta / 4.0) / a), n2) + pow(abs(sin(m * theta / 4.0) / b), n3), -1.0/n1);
}

float t, theta, a, b, m, n1, n2, n3;
ArrayList<Particle> particles;

void setup() {
  size(1600, 900, P3D);
  
  theta = 0.1;
  a = random(0,0.3);
  b = random(0,0.3);
  m = 6.0;
  n1 = 1.0;
  n2 = 2.0;
  n3 = 2.0;
  
  particles = new ArrayList<Particle>();

  for (t = 0.0; t < TWO_PI; t+=0.005) {
    Particle p = new Particle();
    particles.add(p);
  }

//  println(particles.size());
  background(0);
  stroke(255);
}

void draw() {
  translate(width/2, height/2, 0);

  for (Particle p : particles) {
    float r = r(theta, a, b, m, n1, sin(theta) * 0.5 + 0.5, cos(theta) * 0.5 + 0.5);
    float x = r * cos(t) * 50;
    float y = r * sin(t) * 50;
    p.setAcc(x,y);    
    p.update();
    p.render();
  }
  
  theta+=0.1;
  t+=0.01;
  a+=random(0,0.3);
  b+=random(0,0.3);
}