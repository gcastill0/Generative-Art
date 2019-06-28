ArrayList<Oscillator> v_oscillators;
ArrayList<Oscillator> h_oscillators;
final float [] pi_vals = {HALF_PI, QUARTER_PI, PI, TWO_PI} ;

float oSize = 100;
int rows, cols;

float cr, cg, cb, ca, ss;
float ri, gi, bi, ai, si;

void setup() {
  size(1000, 1000);
  noFill();

  cols = rows = int(height/(oSize+100)) - 1;
  cr = 100;
  cg = 1;
  cb = 240;
  ca = 10.5;
  si = 0.001;
  bi = ri = ai = 0.05;
  gi = 0.01;
  ss = 1.05;

  startOscillators();
}

void draw() {
  translate(-oSize, -oSize);

  strokeWeight(ss);
  if (ss <= 0.5 || ss >= 8.0) si*=-1;
  ss+=si;

  for (int i = 0; i < rows; i++) {
    PVector pv = v_oscillators.get(i).ac.getN();
    v_oscillators.get(i).update();
    //v_oscillators.get(i).render();    
    h_oscillators.get(i).update();
    //h_oscillators.get(i).render();

    if (cr >= 250 || cr <= 0) ri*=-1;
    cr += ri;
    cr %= 255.0;

    //if (cg >= 250 || cg <= 0) gi*=-1;
    //cg += bi;
    //cg %= 255.0;

    if (cb >= 250 || cb <= 0) bi*=-1;
    cb += bi;
    cb %= 255.0;

    if (ca >= 50 || ca <= 5.0) ai*=-1;
    ca += ai;
    
    stroke(color(cr, cg, cb), map(ss, 0, 8, 20, 2));

    for (int ii = 0; ii < rows; ii++) {
      PVector ph = h_oscillators.get(ii).ac.getN();

      //line(pv.x, pv.y, width, pv.y);
      //line(ph.x, ph.y, ph.x, height);
      point(ph.x, pv.y);
    }
  }

  if (frameCount%18000==0) {

    int day = day();    // Values from 1 - 31
    int mon = month();  // Values from 1 - 12
    int year = year();   // 2003, 2004, 2005, etc.
    int sec = second();  // Values from 0 - 59
    int min = minute();  // Values from 0 - 59
    int hr = hour();    // Values from 0 - 23

    saveFrame("lissajous-"+year+"-"+mon+"-"+day+"-"+hr+"-"+min+"-"+sec+"-"+".png");
    startOscillators();
  }
}

void startOscillators() {
  background(255);

  v_oscillators = new ArrayList<Oscillator>();
  h_oscillators = new ArrayList<Oscillator>();

  for (int i = 0; i < rows; i++) {
    float y = i * (oSize + 100) + (oSize + 100) + (oSize + 100)/2;
    float x = (oSize + 100)/2;
    Oscillator o = new Oscillator(oSize/2, int(random(1, 2)), new PVector(x, y));
    v_oscillators.add(o);
  }

  for (int i = 0; i < rows; i++) {
    float y = (oSize + 100)/2;
    float x = i * (oSize + 100) + (oSize + 100) + (oSize + 100)/2;
    Oscillator o = new Oscillator(oSize/2, int(random(1, 2)), new PVector(x, y));
    h_oscillators.add(o);
  }
}

class Oscillator {
  ArrayList<Sine> waves;
  Sine ac;

  Oscillator(float f, float n, PVector o) {

    this.waves = new ArrayList<Sine>();

    for (int i = 0; i < n; i++) {
      Sine sine = new Sine(f, i * 2 +1);
      sine.setO(o);
      o = sine.getN();
      this.waves.add(sine);
    }

    this.ac = this.waves.get(this.waves.size()-1);
  }

  void update() {
    for (Sine sine : this.waves) {
      sine.update();
    }
  }

  void render() {
    for (Sine sine : this.waves) {
      sine.render();
    }
  }
}
