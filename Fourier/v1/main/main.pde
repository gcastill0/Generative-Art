ArrayList<Sine> Waves;
ArrayList<PVector> Points;
float x, y;
PShape s;
int n, c, nPoints;

void setup() {
  size(1600, 900);
  x = width/2-100;
  Points = new ArrayList<PVector>();
  n = 2;
  c = -1;
  nPoints = 360;

  createWaves();

  float pix = (128*8)/720.0;
  println(128*4, pix);
}

void createWaves() {
  PVector o = new PVector(width/4, height/2);
  Waves = new ArrayList<Sine>();
  if (n <= 1 || n > 10) c*=-1;

  n+=c;

  for (int i = 0; i < n; i++) {
    Sine s = new Sine(100, i * 2 +1);
    s.setO(o);
    o = s.getN();
    Waves.add(s);
  }
}

void draw() {
  background(255);

  stroke(0, 100);
  strokeWeight(1);
  line(x, height/2-100, x+100*8+28, height/2-100);   
  line(x, height/2+100, x+100*8+28, height/2+100);   
  line(x, height/2, x+100*8+28, height/2);

  for (int i = 0; i < 9; i+=2) {
      line(x + (i*100), height/2-128, x + (i*100), height/2+128);
  }

  for (int i = 0; i < 8; i++) {
      rect(x + (i*100), height/2-100, 100, 200);
  }

  for (Sine s : Waves) {
    s.update();
    s.render();
  }

  y = Waves.get(Waves.size()-1).getN().y;

  if (Points.size() >= nPoints*2) {
    Points.remove(0);
  }

  if (Points.size() < nPoints*2) {
    PVector p = new PVector(x, y);
    Points.add(p);
  }

  stroke(0, 100);
  strokeWeight(1);
  line(Waves.get(Waves.size()-1).getN().x, y, x, y);
  for (PVector p : Points) {
    p.x+=(((100*8)/(nPoints*1.0))/2);
  }

  stroke(#2B7E7E);
  strokeWeight(4);
  for (int i = 0; i < Points.size()-1; i++) {
    PVector p1 = Points.get(i);
    PVector p2 = Points.get(i+1);
    line(p1.x, p1.y, p2.x, p2.y);
  }

  if (Waves.get(0).done == true) {
    createWaves();
  }

  filter(INVERT);
}
