Divider d;
float xs, ys;
float t;
float noff;
Chart chart;
ArrayList<Datapoint> data;
int dpm;

void setup() {
  size(1600, 900);

  d = new Divider();
  t = 1.5;
  noff = -25;
  dpm = 180;

  chart = new Chart();
  data = new ArrayList<Datapoint>();

  for (int i = 0; i < dpm; i++) {
    data.add(new Datapoint());
  }

  for (int i = 0; i < data.size()-1; i++) {
    float p1 = data.get(i).period;
    float v1 = data.get(i).value;

    for (int j = i+1; j < data.size(); j++) {
      float p2 = data.get(j).period;
      float v2 = data.get(j).value;

      if (p2 < p1) {
        float tmp_p = p2;
        float tmp_v = v2;

        data.get(j).period = data.get(i).period;
        data.get(j).value  = data.get(i).value;

        data.get(i).period = tmp_p;

        p1 = data.get(i).period;
        v1 = data.get(i).value;
      }
    }
  }

  for (Datapoint dp : data) {
    dp.set_l();
  }

  xs = ( width*.80  - width*.20 )  / (30*t);
  ys = ( height*.80 - height*.20 ) / (30*t);

  //print(day()+"-"+month()+"-"+year(), hour()+":"+minute()+":"+second()+"."+millis());
}

void draw() {
  background(0);
  
  if (chart.done == true) {
    stroke(#FF0000, 150);
    fill(#FF0000, 150);
    strokeWeight(10);
    for (int i = 0; i < data.size()-1; i++) {
      line(data.get(i).period, data.get(i).l.y, data.get(i+1).period, data.get(i+1).l.y);
    }
    for (Datapoint dp : data) {
      dp.update();
    }
  }

  chart.update();
  chart.render();

  //filter(INVERT);
}

class Datapoint {
  PVector l;
  float value;
  float period;
  float dp_yoff;

  Datapoint() {
    this.period  = map(random(100), 0.0, 100.0, width*.20, width*.80);
    this.dp_yoff = 10;
  }

  void set_l() {
    this.l = new PVector(this.period, height*.80);
    //this.value  = sin(noff/5);
    //float period = (millis()%5==0) ? 5 : 10;
    //this.value  = map(sin(noff/period), -2.0, 2.0, height*.20, height*.60);
    //this.value  = map(sin(noff) + cos(sqrt(3)*noff), -2.0, 2.0, height*.20, height*.60);
    this.value  = map(noise(noff) * 100, 0.0, 100.0, height*.20, height*.80);
    println(this.value);
    this.dp_yoff = (height*.80 - this.value)/(30*t);
    noff+=0.15;
  }

  void update() {
    if (this.l.y > this.value) {
      this.l.y-=this.dp_yoff;
    }
  }

  void render() {
    ellipse(this.l.x, this.l.y, 5, 5);
  }
}

class Chart {
  XAxis x;
  YAxis y;
  Grid g;
  boolean done;

  Chart() {
    this.x = new XAxis();
    this.y = new YAxis();
    this.g = new Grid();
    this.done = false;
  }

  void update() {
    if (this.done == true) return;

    if (this.x.done == false || this.y.done == false) {
      this.x.update();
      this.y.update();
    } else {  
      this.g.update();
    }

    this.done = (this.x.done && this.y.done && this.g.done) ? true : false;
  }

  void render() {
    stroke(#AAAAAA);
    strokeWeight(3);
    this.x.render();
    this.y.render();

    stroke(#AAAAAA, 40);
    strokeWeight(3);
    this.g.render();
  }
}


class Grid {

  ArrayList<XAxis> xs;
  ArrayList<YAxis> ys;
  boolean done;

  Grid() {
    this.xs = new ArrayList<XAxis>();
    this.ys = new ArrayList<YAxis>();
    this.done = false;

    float yoff = (height*.80 - height*.20)/8;
    for (float y = height*.20; y <= height*.80; y+=yoff) {
      this.xs.add(new XAxis(new PVector(width*.20, y)));
    }

    float xoff = (width*.80 - width*.20)/5;
    for (float x = width*.20; x <= width*.80; x+=xoff) {
      this.ys.add(new YAxis(new PVector(x, height*.80)));
    }
  }

  void update() {
    if (this.done == true) return;

    boolean x_check_done = true;

    for (XAxis xa : this.xs) {
      xa.update();
      x_check_done = (x_check_done && xa.done) ? true : false;
    }

    boolean y_check_done = true;

    for (YAxis ya : this.ys) {
      ya.update();
      y_check_done = (y_check_done && ya.done) ? true : false;
    }

    this.done = (x_check_done && y_check_done) ? true : false;
  }

  void render() {
    for (XAxis xa : this.xs) {
      xa.render();
    }

    for (YAxis ya : this.ys) {
      ya.render();
    }
  }
}

class XAxis {
  PVector p1, p2;
  boolean done;

  XAxis(PVector p) {
    this.p1 = p.copy();
    this.p2 = p.copy();
    this.done = false;
  }

  XAxis() {
    this.p1 = new PVector(width*.20, height*.80);
    this.p2 = new PVector(width*.20, height*.80);
  }

  void update() {
    if (this.done == true) return;
    if (this.p2.x <= width*.80) {
      this.p2.x+=xs;
    } else {
      this.done = true;
    }
  }

  void render() {
    line(this.p1.x, this.p1.y, this.p2.x, this.p2.y);
  }
}

class YAxis {
  PVector p1, p2;
  boolean done;

  YAxis(PVector p) {
    this.p1 = p.copy();
    this.p2 = p.copy();
    this.done = false;
  }

  YAxis() {
    this.p1 = new PVector(width*.20, height*.80);
    this.p2 = new PVector(width*.20, height*.80);
  }

  void update() {
    if (this.done == true) return;
    if (this.p2.y >= height*.20) {
      this.p2.y-=ys;
    } else {
      this.done = true;
    }
  }

  void render() {
    line(this.p1.x, this.p1.y, this.p2.x, this.p2.y);
  }
}

class Divider {
  PVector p1, p2;

  Divider() {
    this.p1 = new PVector(width/2+10, 0);
    this.p2 = new PVector(width/2-10, 0);
  }

  void update() {
    if (this.p1.x >= 0) {
      this.p1.x-=10;
    }

    if (this.p2.x <= width) {
      this.p2.x+=10;
    }
  }

  void render() {
    rect(this.p1.x, this.p1.y, 10, height);
    rect(this.p2.x, this.p2.y, 10, height);
  }
}
