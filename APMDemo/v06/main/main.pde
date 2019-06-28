ArrayList<Cell> cells;
ArrayList<Thing> conns;
ArrayList<Connection> bcons;

int cellSize, cols, rows, seconds;
float xoff, yoff, midx, midy;

import com.hamoid.*;
VideoExport videoExport;

void setup() {
  //size(1600, 900);
  size(720, 1280);

  seconds = 0;

  cells = new ArrayList<Cell>();
  conns = new ArrayList<Thing>();
  bcons = new ArrayList<Connection>();

  cellSize = 100;
  cols = (int)(width/(cellSize*1.25))-1;
  rows = 5;
  xoff = (width  - ( cols * cellSize * 1.25 ))/2;
  yoff = (height - ( rows * cellSize * 1.2 ))/2; 

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (random(100) < 70) {

        PVector l = new PVector();     
        l.x = x*cellSize*1.25 + xoff + cellSize/2 + random(-cellSize/6, cellSize/6);
        l.y = y*cellSize*1.2 + yoff + cellSize/2 + random(-cellSize/6, cellSize/6);

        Thing thing = new Thing(l);
        Cell cell = new Cell(thing, (int)(rows * x + y));
        cells.add(cell);
      }
    }
  }

  cells.get((int)(random(1, 10))).active = true;

  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

void draw() {
  background(255);

  for (Connection bcon : bcons) {
    bcon.render();
  }

  for (Thing c : conns) {
    c.update();
    c.render();
  }

  for (Cell c : cells) {
    c.render();
  }

  //**** **** **** **** **** **** **** **** **** **** 
  boolean done = false;

  if ((int)(frameCount % 30) == 0) {
    seconds++;

    for (Cell c1 : cells) {
      if (c1.active == true && done == false) {
        for (float a = 0.0; a < (TWO_PI - PI/4); a+=PI/4) {

          float x = c1.thing.l.x + cos(a) * cellSize;
          float y = c1.thing.l.y + sin(a) * cellSize;

          for (Cell c2 : cells) {
            if (c1.id == c2.id) continue;
            if (c2.checkBounds(new PVector(x, y)) == true && c2.active == false) {
              Thing conn = new Thing(c1.thing.l, c2.thing.l);
              conns.add(conn);
              c2.active = true;
              c2.thing.ttd = (30*60)-frameCount - 30 - 255;
              done = true;
            }
          }

          for (Cell c2 : cells) {
            if (c1.id == c2.id) continue;
            if (c2.checkFarXBounds(new PVector(x, y)) == true && c2.active == false && random(100) < 10) {
              Connection bcon = new Connection(c1.thing.l, c2.thing.l);
              bcons.add(bcon);
              c2.active = true;
              c2.thing.ttd = (30*60)-frameCount - 30 - 255;
              done = true;
            } else if (c2.checkFarYBounds(new PVector(x, y)) == true && c2.active == false && random(100) < 10) {
              Connection bcon = new Connection(c1.thing.l, c2.thing.l);
              bcons.add(bcon);
              c2.active = true;
              c2.thing.ttd = (30*60)-frameCount - 30 - 255;
              done = true;
            }
          }
        }
      }
    }

    int miss = 0;

    for (Cell c : cells) {
      if (c.active == false) miss++;
    }

    if (done == false && miss > 0) {
      for (Cell c : cells) {
        if (c.active == false) {
          c.active = true;
          break;
        }
      }
    }
    //**** **** **** **** **** **** **** **** **** ****
  }
  //**** **** **** **** **** **** **** **** **** ****

  //filter(INVERT);
  videoExport.saveFrame();
  if (frameCount >= (30*60)) exit();
  //**** **** **** **** **** **** **** **** **** ****
}

class Connection {
  PVector p1, p2, p3;
  int t;

  Connection(PVector p1, PVector p2) {
    this.p1 = p1;
    this.p2 = p2;
    this.t  = ((int)random(100)%2 ==  0) ? 0 : 1;
  }

  void arrow(PVector s, PVector e) {

    strokeWeight(3);
    stroke(#FFDB70);
    stroke(#1097FF);

    float a = atan2(e.y-s.y, e.x-s.x);  
    float a1 = a - radians(30);
    float a2 = a + radians(30);

    float nex = e.x - cos(a) * 14;
    float ney = e.y - sin(a) * 14;

    float nx1 = nex - cos(a1) * 6;
    float ny1 = ney - sin(a1) * 6;
    float nx2 = nex - cos(a2) * 6;
    float ny2 = ney - sin(a2) * 6;

    float len = sqrt(sq(s.x-nex)+sq(s.y-ney));

    if (len < (cellSize*3)) {
      line(s.x, s.y, nex, ney);
      line(nex, ney, nx1, ny1);
      line(nex, ney, nx2, ny2);
    }
  }

  void render() {

    float alpha = 255;
    
    if (frameCount >= ((30*60)-(30*5))) alpha-=1.5;
    
    strokeWeight(3);
    stroke(color(#d1d1d1), alpha);
    noFill();

    if (this.t == 0) {

      float cx  = (p1.x + p2.x)/2;
      float cy  = (p1.y + p2.y)/2;
      float lab = sqrt(sq(cx-p2.x) + sq(cy-p2.y));

      float cpx1 = (cx+p1.x)/2;
      float cpy1 = (cy+p1.y)/2-lab*0.75;
      float cpx2 = (cx+p2.x)/2;
      float cpy2 = (cy+p2.y)/2-lab*0.75;

      float ai   = degrees(atan((cpy1-p1.y)/(cpx1-p1.x)));
      float labi = sqrt(sq(cpx1-p1.x)+sq(cpy1-p1.y));
      float bi   = ai + 90.0;

      cpx1 = cpx1 + labi * cos(bi*PI/180);
      cpy1 = cpy1 + labi * sin(bi*PI/180); 

      float aii   = degrees(atan((cpy2-p2.y)/(cpx2-p2.x)));
      float labii = sqrt(sq(cpx2-p2.x)+sq(cpy2-p2.y));
      float bii   = aii + 90.0;

      cpx2 = cpx2 + labii * cos(bii*PI/180);
      cpy2 = cpy2 + labii * sin(bii*PI/180); 

      bezier(p1.x, p1.y, cpx2, cpy2, cpx1, cpy1, p2.x, p2.y);
    } else if (this.t == 1) {
      line(p1.x, p1.y, p2.x, p2.y);
    } else if (this.t == 2) {
      arrow(this.p1, this.p2);
    }
  }
}

class Cell {
  int id;
  Thing thing;
  boolean active;
  int[] neighbours;

  Cell(Thing t, int id) {
    this.id   = id;
    this.thing = t;
    this.neighbours = new int[0];
    this.active = false;
  }

  void addNeighbour(int idx) {
    this.neighbours = (int[]) append(this.neighbours, idx);
  }

  boolean isNeighbour(int idx) {
    if (this.id == idx && this.active == true) return true;
    return false;
  }

  boolean checkBounds(PVector t) {
    if (t.x >= (this.thing.l.x-cellSize/2) && t.x <= (this.thing.l.x + cellSize/2) && 
      t.y >= (this.thing.l.y-cellSize/2) && t.y <= (this.thing.l.y + cellSize/2) ) 
      return true;
    return false;
  }

  boolean checkFarXBounds(PVector t) {
    if ( t.x >= (this.thing.l.x-cellSize*1.50) && t.x <= (this.thing.l.x + cellSize*1.50) && 
      t.y >= (this.thing.l.y-cellSize) && t.y <= (this.thing.l.y + cellSize) ) 
      return true;
    return false;
  }

  boolean checkFarYBounds(PVector t) {
    if ( t.x >= (this.thing.l.x-cellSize) && t.x <= (this.thing.l.x + cellSize) && 
      t.y >= (this.thing.l.y-cellSize*1.50) && t.y <= (this.thing.l.y + cellSize*1.50) ) 
      return true;
    return false;
  }

  void render() {

    if (this.active != true) return;

    this.thing.update();
    this.thing.render();

    //print(this.id, " |\t");
    //for (int i = 0; i < this.neighbours.length; i++) {
    //  print(this.neighbours[i], "\t");
    //}
    //println();
  }
}

class Thing {
  PShape thing;
  PVector l;
  int ttl = 0;
  int ttd = (30*60)-frameCount - 30 - 255;
  int phase = 1;
  float alpha = 0.0;
  int type;

  Thing(PVector l) {
    this.l     = l;
    this.thing = this.createThing(this.l);
    this.type = 0;
  }

  Thing(PVector l, float p) {
    this.l     = l;
    this.thing = this.createThing(this.l, p);
    this.type = 1;
  }

  Thing(PVector l1, PVector l2) {
    this.thing = this.createThing(l1, l2);
    this.type = 2;
  }

  PShape createThing(PVector l) {
    PShape cross1, cross2, shadow, border, thingie;
    ArrayList<PShape> things;
    things = new ArrayList<PShape>();

    cross1 = this.createThing(new PVector(l.x - cellSize/3.42, l.y - cellSize/3.42), new PVector(l.x + cellSize/3.42, l.y + cellSize/3.42));
    cross2 = this.createThing(new PVector(l.x + cellSize/3.42, l.y - cellSize/3.42), new PVector(l.x - cellSize/3.42, l.y + cellSize/3.42));

    shadow = createShape(RECT, l.x - cellSize/3.25, l.y - cellSize/3.25, cellSize/1.62, cellSize/1.62);
    shadow.setStrokeWeight(5);
    shadow.setStroke(#FFFFFF);
    shadow.setStrokeJoin(ROUND);

    border = createShape(RECT, l.x - cellSize/3.42, l.y - cellSize/3.42, cellSize/1.76, cellSize/1.76);
    border.setStrokeWeight(3);
    border.setStroke(#CCCCCC);
    border.setStrokeJoin(ROUND);

    things.add(createThing(l, 4));

    for (float r = TWO_PI/4/2; r <= TWO_PI; r+=TWO_PI/4) {
      float x = l.x + cos(r) * cellSize/3;
      float y = l.y + sin(r) * cellSize/3;
      things.add(createThing(new PVector(x, y), 4));
    }

    thingie = createShape(GROUP);
    thingie.addChild(shadow);
    thingie.addChild(border);
    thingie.addChild(cross1);
    thingie.addChild(cross2);

    for (PShape p : things) {
      thingie.addChild(p);
    }

    return thingie;
  }

  PShape createThing(PVector l, float p) {
    PShape thingie, shadow, facade;

    shadow = createShape();
    shadow.beginShape();
    shadow.strokeWeight(5);
    shadow.stroke(#FFFFFF);
    shadow.strokeJoin(ROUND);

    facade = createShape();
    facade.beginShape();
    facade.strokeWeight(4);
    facade.stroke(#0B3C61);
    facade.strokeJoin(ROUND);

    for (float r = 0.0; r <= TWO_PI; r+=TWO_PI/p) {
      float x, y;

      x = l.x + cos(r) * cellSize/6;
      y = l.y + sin(r) * cellSize/6;
      shadow.vertex(x, y);

      x = l.x + cos(r) * (cellSize/6)/1.25;
      y = l.y + sin(r) * (cellSize/6)/1.25;      
      facade.vertex(x, y);
    }

    shadow.endShape();
    facade.endShape();

    thingie = createShape(GROUP);
    thingie.addChild(shadow);
    thingie.addChild(facade);

    return thingie;
  }

  PShape createThing(PVector l1, PVector l2) {
    PShape thingie, shadow, border;

    shadow = createShape();
    shadow.beginShape();
    shadow.strokeWeight(1);
    shadow.stroke(#FFFFFF);
    shadow.strokeJoin(ROUND);
    shadow.vertex(l1.x-2, l1.y-2);
    shadow.vertex(l1.x+2, l1.y+2);
    shadow.vertex(l2.x-2, l2.y-2);
    shadow.vertex(l2.x+2, l2.y+2);
    shadow.endShape();

    border = createShape();
    border.beginShape();
    border.strokeWeight(3);
    border.stroke(#222222);
    border.strokeJoin(ROUND);
    border.vertex(l1.x, l1.y);
    border.vertex(l2.x, l2.y);
    border.endShape();

    thingie = createShape(GROUP);
    thingie.addChild(shadow);
    thingie.addChild(border);

    return thingie;
  }

  void setThingStroke() {
    switch(this.type) {
    case 0:
      this.thing.getChild(1).setStroke(color(124, 124, 124, this.alpha));
      this.thing.getChild(2).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      this.thing.getChild(3).getChild(1).setStroke(color(11, 60, 97, this.alpha));      
      this.thing.getChild(4).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      this.thing.getChild(5).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      this.thing.getChild(6).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      this.thing.getChild(7).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      this.thing.getChild(8).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      break;
    case 1: 
      this.thing.setStroke(color(11, 60, 97, this.alpha));
      break;
    case 2: 
      this.thing.getChild(1).setStroke(color(204, 204, 204, this.alpha));
      break;
    case 3: 
      this.thing.getChild(1).setStroke(color(204, 204, 204, this.alpha));
      break;
    }
  }

  void fadeIn() {
    if (this.alpha > 255) return;
    else if (this.alpha < 255) {
      this.setThingStroke();
    } else if (this.alpha == 255) {
      this.thing.setStroke(color(#0B3C61));
      this.phase++;
    }
    this.alpha+=2;
  }

  void doWork() {
  }

  void fadeOut() {
    if (this.alpha <= 0) return;
    this.setThingStroke();
    this.alpha--;
  }

  void doPanic() {
  }

  void update() {
    this.ttl++;

    if (this.ttl == 900) this.phase = 3;

    switch(this.phase) {
    case 1: 
      this.fadeIn();
      break;
    case 2: 
      this.doWork();
      break;
    case 3: 
      this.fadeOut();
      break;
    case 4: 
      this.doPanic();
      break;
    }

    println("Phase", this.phase, "TTL", this.ttl, "TTD", this.ttd, "Max", 30*60*1, frameCount, frameCount/30);
  }

  void render() {
    shape(this.thing);
  }
}
