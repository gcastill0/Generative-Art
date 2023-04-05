// Peter de Jong map
// X[n+1] = sin( a * PI * Y[n]) - cos( b * PI * X[n])
// Y[n+1] = sin( c * PI * X[n]) - cos( d * PI * Y[n])

// Bourke's constants
//float a = 1.641, b = 1.902, c = 0.316, d= 1.525;
//float a = 1.4, b = -2.3, c = 2.4, d= -2.1;
//float a = -3, b = -2.3, c = 2.4, d = -2.1;

int m = 4;
int sec = 60;
int fpm = 30;
float a, b, c, d;
float gs = 3.5;
float gx = 0.5;
float gy = 0.5;
int dim = 800;
int maxP = 6000;
int maxA = 128;
int maxF = fpm*sec*m;
int pics = 50;

ArrayList<Particle> particles;

void setup() {
  size(900, 900, P3D);
  reset();
}

void draw() {
  translate(width/2, height/2);
  lights();

  if (particles.size() < maxP) {
    Particle p = new Particle();
    particles.add(p);
  }

  for (Particle p : particles) {
    p.update();
    p.draw();
  }

  //if (frameCount % (30*60*(m-2)) == 0) {
////    blendMode(ADD);
  //  stroke(#70FFFF, 5);
  //  strokeWeight(1);
  //}


  if (frameCount % (fpm*sec*(m-1.5)) == 0) {
//    blendMode(ADD);
    stroke(#00FFFF, 5);
    strokeWeight(1);
  }


  if (frameCount % maxF == 0) {
    saveframe();
    reset();
  }
}

class Particle {
  float x, y;
  float xn, yn;
  int age = 0;

  Particle() {
    this.x = random(-1.0, 1.0);
    this.y = random(-1.0, 1.0);
  }

  void update() {
    this.xn = sin(a*y) - cos(b*x);
    this.yn = sin(c*x) - cos(d*y);
    this.x = this.xn;
    this.y = this.yn;
    this.age++;
  }

  void draw() {

    point((this.x/(gs+gx))*dim, (this.y/(gs+gy))*dim);

    if (this.age > maxA) this.rebirth();
  }

  void rebirth() {
    this.x = random(-1.0, 1.0);
    this.y = random(-1.0, 1.0);
    this.age = 0;
  }
}

void reset() {
  background(0);
  stroke(#273D3D, 5);
  strokeWeight(2);
  fill(#FFC0C0);
  textAlign(CENTER, CENTER);
  textSize(12);
  
  a = random(-4,4);
  b = random(-4,4);
  c = random(-4,4);
  d = random(-4,4);

  pics--;
  if (pics <= 1) exit();

  particles = new ArrayList<Particle>();
}

void saveframe() {
  String str = "a:"+nf(a, 1, 2)+"  b:"+nf(b, 1, 2)+"  c:"+nf(c, 1, 2)+"  d:"+nf(d, 1, 2);
  text(str, 0, height/2 - 20);
  println(str);

  String d = "-"+nf(day(), 2);    // Values from 1 - 31
  String m = "-"+nf(month(), 2);  // Values from 1 - 12
  String y = "-"+nf(year(), 4);   // 2003, 2004, 2005, etc.
  String s = "-"+nf(second(), 2);  // Values from 0 - 59
  String mi = "-"+nf(minute(), 2);  // Values from 0 - 59
  String h = "-"+nf(hour(), 2);    // Values from 0 - 23

  String frameName = "ga"+y+m+d+h+mi+s+"-#########.png";

  saveFrame(frameName);
}