Cluster cl;
float w = 40;

// **************************************************
//
// **************************************************

void setup() {
  size(1600, 900);
  //size(1400,425);
  cl = new Cluster();
}

// **************************************************
//
// **************************************************

void draw() {
  background(255);
  canvasGrid(0, 0, width, height, 3);
  cl.render();
}

// **************************************************
//
// **************************************************

void canvasGrid(float x1, float y1, float x2, float y2, int d) {
  if (d <=0) return;

  strokeWeight(d*2);
  stroke(#78C4FF, 25);

  float midx = (x1+x2)/2;
  float midy = (y1+y2)/2;

  line(x1, midy, x2, midy);
  line(midx, y1, midx, y2);

  fill(0);
  ellipse(midx, midy, 10, 10);
  noFill();

  canvasGrid(x1, y1, midx, midy, d-1);
  canvasGrid(midx, midy, x2, y2, d-1);
  canvasGrid(midx, y1, x2, midy, d-1);
  canvasGrid(x1, midy, midx, y2, d-1);
}

// **************************************************
//
// **************************************************

class Cluster {
  Pod c1, c2;
  Conns conn;
  Thing thing;

  Cluster() {
    this.c1 = new Pod(new PVector(width/2, height/2), 4);
    this.c2 = new Pod(new PVector(width/2, height/4), 4);

    this.thing = new Thing(new PVector(width/4, height/4), 4);
    this.conn = new Conns(this.thing, this.c1.things.get(2));
  }

  void render() {
    this.conn.render();
    this.thing.render();
    this.c1.render();
    this.c2.render();
  }
}

// **************************************************
//
// **************************************************

class Conns {
  Thing thingA, thingB;

  Conns(Thing a, Thing b) {
    this.thingA = a;
    this.thingB = b;
  }

  Conns(Pod a, Thing b) {
    this.thingA = a.things.get(0);
    this.thingB = b;
  }

  Conns(Thing a, Pod b) {
    this.thingA = a;
    this.thingB = b.things.get(0);
  }

  Conns(Pod a, Pod b) {
    this.thingA = a.things.get(0);
    this.thingB = b.things.get(0);
  }

  void render() {
    strokeWeight(5);
    stroke(#0B3C61);
    line(this.thingA.l.x, this.thingA.l.y, this.thingB.l.x, this.thingB.l.y);
  }
}

// **************************************************
//
// **************************************************

class Pod {
  PVector l;
  ArrayList<Thing> things;
  ArrayList<Conns> conns;
  float ttl;

  Pod(PVector l, float sides) {
    this.l = l;

    this.things = new ArrayList<Thing>();
    this.things.add(new Thing(this.l, sides));

    for (float r = TWO_PI/sides/2; r <= TWO_PI; r+=TWO_PI/sides) {
      float x = this.l.x + cos(r) * w;
      float y = this.l.y + sin(r) * w;
      Thing t = new Thing(new PVector(x, y), sides);
      things.add(t);
    }

    this.conns = new ArrayList<Conns>();

    this.conns.add(new Conns(this.things.get(1), this.things.get(3)));
    this.conns.add(new Conns(this.things.get(2), this.things.get(4)));

    this.ttl = 0;
  }

  void render() {
    this.ttl++;

    float x1 = this.l.x-(w*0.924);
    float y1 = this.l.y-(w*0.924);
    float wa = w*1.82;

    noStroke();
    fill(#FFFFFF);
    rect(x1-4, y1-4, wa+8, wa+8);

    if (this.ttl < 255) {
      stroke(color(11, 60, 97, this.ttl));
    } else if (this.ttl >= 255) {
      stroke(#0B3C61);
    }

    strokeWeight(5);
    fill(#FFFFFF);
    rect(x1, y1, wa, wa);

    for (Conns c : conns) {
      c.render();
    }

    for (Thing t : things) {
      t.update();
      t.render();
    }
  }
}

// **************************************************
//
// **************************************************

class Thing {
  PVector l;
  float s, p, f, b;
  PShape t, ts;
  int ttl;
  boolean blk;

  Thing(PVector l, float p) {
    this.l  = l;
    this.p  = p;
    this.s  = w/2.0;
    this.t  = this.createThing();
    this.ts = this.createThingShadow();
    this.f  = 0;
    this.b  = 0;
    this.ttl = 0;
    this.blk = true;
  }

  PShape createThingShadow() {
    PShape thingie;
    thingie = createShape();
    thingie.beginShape();
    thingie.strokeWeight(5);
    thingie.stroke(#FFFFFF);
    thingie.strokeJoin(ROUND);

    for (float r = 0.0; r <= TWO_PI; r+=TWO_PI/this.p) {
      float x = this.l.x + cos(r) * this.s;
      float y = this.l.y + sin(r) * this.s;
      thingie.vertex(x, y);
    }

    thingie.endShape();
    return thingie;
  }

  PShape createThing() {
    PShape thingie;
    thingie = createShape();
    thingie.beginShape();
    thingie.strokeWeight(5);
    thingie.stroke(#0B3C61);
    thingie.strokeJoin(ROUND);

    for (float r = 0.0; r <= TWO_PI; r+=TWO_PI/this.p) {
      float x = this.l.x + cos(r) * this.s/1.25;
      float y = this.l.y + sin(r) * this.s/1.25;
      thingie.vertex(x, y);
    }

    thingie.endShape();
    return thingie;
  }

  void update() {
    this.ttl++;
    if (this.ttl <= 255) this.fadeIn();
    //else if (this.ttl >= 256 && this.blk == true) this.blink();
  }

  void blink() {
    println(this.ttl, this.b);
    if (this.b < 50) {
      this.t.setStroke(color(11, 60, 97, this.b));
      this.b++;
    } else if (this.b <= 50) {
      this.t.setStroke(color(#0B3C61));
      this.b++;
    }
  }

  void fadeIn() {    
    if (this.ttl < 255) {
      this.t.setStroke(color(11, 60, 97, this.ttl));
    } else if (this.ttl == 255) {
      this.t.setStroke(color(#0B3C61));
    }
  }

  void render() {
    shape(this.ts);
    shape(this.t);
  }
}
