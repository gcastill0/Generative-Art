// Peter de Jong map
// X[n+1] = sin( a * PI * Y[n]) - cos( b * PI * X[n])
// Y[n+1] = sin( c * PI * X[n]) - cos( d * PI * Y[n])

// Bourke's constants
//float a = 1.641, b = 1.902, c = 0.316, d= 1.525;
float a = -2, b = -2.3, c = 2.4, d= -2.1, e = 1.4, f = -1.4;

float gs = 3.5;
float gx = 0.5;
float gy = 0.5;
int dim = 800;
int maxP = 6000;
int maxA = 256;
int maxF = 30*60*3;

ArrayList<Particle> particles;

void setup() {
  size(900, 900, P3D);
  particles = new ArrayList<Particle>();

  background(255);
  stroke(#161B29, 5);
  fill(#161B29);
}

void draw() {
  translate(width/2, height/2, -width/6);

  if (particles.size() < maxP) {
    Particle p = new Particle();
    particles.add(p);
  }

  for (Particle p : particles) {
    p.update();
    p.draw();
  }

  if (frameCount % maxF == 0) {
    saveframe();
    reset();
  }
}

class Particle {
  float x, y, z;
  float xn, yn, zn;
  int age = 0;

  Particle() {
    this.x = random(-1.0, 1.0);
    this.y = random(-1.0, 1.0);
    this.z = random(-1.0, 1.0);
  }

  void update() {
    this.xn = sin(a*y) - cos(b*x);
    this.yn = sin(c*x) - cos(d*y);
    this.zn = sin(e*y) - cos(f*x);
    
    this.x = this.xn;
    this.y = this.yn;
    this.z = this.zn;
    
    this.age++;
  }

  void draw() {
    point((this.x/(gs+gx))*dim, (this.y/(gs+gy))*dim, (this.z/(gs+gy))*dim);

    if (this.age > maxA) this.rebirth();
  }

  void rebirth() {
    this.x = random(-1.0, 1.0);
    this.y = random(-1.0, 1.0);
    this.z = random(-1.0, 1.0);
    this.age = 0;
  }
}

void reset() {
  background(255);
  stroke(#161B29, 5);

  a+=0.1;
  if (a >= 2) exit();

  particles = new ArrayList<Particle>();
}

void saveframe() {
  //textAlign(CENTER, CENTER);
  //fill(#161B29);
  //String str = "a: "+nf(a,1,2)+" b: "+nf(b,1,2)+" c: "+nf(c,1,2)+" d: "+nf(d,1,2);
  //textSize(12);
  //text(str, 0, height/2 - 20);
  //println(str);

  String d = "-"+nf(day(), 2);    // Values from 1 - 31
  String m = "-"+nf(month(), 2);  // Values from 1 - 12
  String y = "-"+nf(year(), 4);   // 2003, 2004, 2005, etc.
  String s = "-"+nf(second(), 2);  // Values from 0 - 59
  String mi = "-"+nf(minute(), 2);  // Values from 0 - 59
  String h = "-"+nf(hour(), 2);    // Values from 0 - 23

  String frameName = "ga"+y+m+d+h+mi+s+"-#########.png";

  saveFrame(frameName);
}