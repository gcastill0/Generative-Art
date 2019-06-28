Window test;
final float m = 50;
int  nt;
float ms, rs;
float xoff = 0.0;
color [] rgb = {
  //  #E1FFA4, #CFFF70, #AAFF00, #87CA00, 
  #55AA55, #2D882d, #116611, #004400, 
  #55AA55, #2D882d, #116611, #004400, 
  #E1FFA4, #CFFF70, #AAFF00, #87CA00, 
  #55AA55, #2D882d, #116611, #004400, 
  #55AA55, #2D882d, #116611, #004400, 
  #FF6B6B, #FF4C4C, #E92525 
};

import com.hamoid.*;
VideoExport videoExport;

void setup() {
  //size(720, 1280);
  size(1280, 720);
  nt = int(random(50, 100));
  test = new Window(m, m, width-(m*2), height-(m*2));
  test.assignThings(nt);
  stroke(0, 100);
  //frameRate(1);
  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

void draw() {
  background(0);
  test.render();
  //xoff = xoff + .01;
  //filter(INVERT);
  videoExport.saveFrame();
  if (frameCount >= (30*60)) exit();
  //**** **** **** **** **** **** **** **** **** ****
}

class Thing {
  float m1, m2, s, a;
  int c;
  color myColor;
  PVector l;

  Thing(float x, float y, float s) {
    this.m1 = random(0, 100);
    this.m2 = random(0, 100);
    this.l = new PVector(x, y);
    this.s = s;
    this.a = 150;
    this.c = 1;
    this.myColor = rgb[int(map(this.m1, 0, 100, 0, rgb.length))];
  }

  void render() {
    fill(this.myColor, this.a);
    rect(this.l.x, this.l.y, this.s, this.s, 2);
    if ((this.a == 255 || this.a == 99) && (this.myColor == #FF6B6B || this.myColor == #FF4C4C || this.myColor == #E92525)) this.c *= -1;
    else
      if (frameCount >= (15*30) && (this.myColor != #FF6B6B && this.myColor != #FF4C4C && this.myColor != #E92525)) this.c = -1;

    this.a += this.c;
  }
}

class Window {
  PVector p1, p2;
  float h, w, r, c;
  int n;
  ArrayList<Thing> things;

  Window(float x1, float y1, float w, float h) {
    this.p1 = new PVector(x1, y1);
    this.h  = h; 
    this.w  = w; 
    this.r  = 0.0; 
    this.c  = 0.0;
    this.things = new ArrayList<Thing>();
  }

  void assignThings(int n) {
    this.n = n;
    this.r = ceil(this.n/(sqrt(this.n)*this.w/this.h));
    this.c = ceil(this.n/r);
    this.things = new ArrayList<Thing>();

    float s = 0.0;

    if ((this.w-(m*2))/this.c < (this.h-(m*2))/this.r )
      s = (this.w-(m*2))/this.c;
    else
      s = (this.h-(m*2))/this.r;

    float im = s * 0.05;    
    float y = this.p1.y+m;// + ((this.h-(m*2))-(s*this.r))/2;
    int count = 1; 

    for (int j = 0; j < this.r; j++, y+=s) {
      float x = this.p1.x+m;
      for (int i = 0; i < this.c && count <= this.n; i++, x+=s, count++) {
        Thing t = new Thing(x+im, y+im, s-(im*2));
        this.things.add(t);
      }
    }

    this.h = this.r * s + (m*2);
  }

  void render() {
    fill(#CCCCCC, 50);
    rect(this.p1.x, this.p1.y, this.w, this.h, 5);
    //rect(this.p1.x+m, this.p1.y+m, this.w-(m*2), this.h-(m*2), 5);

    for (Thing t : this.things) {
      t.render();
    }
  }
}
