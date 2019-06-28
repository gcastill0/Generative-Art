Thing connector, container, clustered;
float sx, sy, ex, ey, sw, sh;

ArrayList<Thing> things;
ArrayList<Cell> cells;
ArrayList<PVector> ndots;

void setup() {
  size(1600, 900);
  //connector = new Thing(new PVector(width/2, height/2), new PVector(width/4, height/4));
  //container = new Thing(new PVector(width/4, height/2), 4);
  //clustered = new Thing(new PVector(width*.75, height*.75));

  things = new ArrayList<Thing>();
  cells  = new ArrayList<Cell>();
  ndots  = new ArrayList<PVector>();

  pointsGrid();

  for (Cell cell : cells) {
    println(cell.id, cell.active);
  }


  sx = (60 * 4)/4;
  sy = (60 * 4)/4;
  sw = width - (60 * 4)/4;
  sh = height - (60 * 4)/4;

  noLoop();
}

void draw() {
  background(255);

  for (Cell cell : cells) {
    cell.render();
  }
}

void pointsGrid() {
  float xoff, yoff;
  int rows, cols;

  cols = (int)(width/(60*2))-1;
  rows = 3;

  xoff = (width -  (cols * 60 * 2))/2;
  yoff = (height - (rows * 60 * 2))/2;

  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      float x = (c*60*2+xoff)+60 + random(-15, 15);
      float y = (r*60*2+yoff)+60 + random(-15, 15);
      Cell cell = new Cell(new PVector(x, y));
      cell.id  = cells.size();
      cell.active = (random(100) < 50) ? true : false; 
      cells.add(cell);
    }
  }
}

class Cell {
  PVector l;
  boolean active = false;
  int id;

  Cell(PVector l) {
    this.l = l;
  }

  void getNeighbours() {
    int neighbours[] = new int[4];
    neighbours[0] = (this.id - 1 >= 0) ? this.id - 1 : -1;
    neighbours[1] = ((this.id + 1)%12 > 0) ? this.id + 1 : -1;
    neighbours[2] = (this.id - 12 >= 0) ? this.id - 12 : -1;
    neighbours[3] = ((this.id + 12) <= 35) ? this.id + 12 : -1;

    print("idx", this.id, ":");
    for (int n : neighbours) {
      print(" ", n);
    }
    println();
  }

  void render() {
    this.getNeighbours();

    fill(#FF0000, 100);
    rect(this.l.x-60, this.l.y-60, 60*2, 60*2);
    fill(#000000);
    text(this.id, this.l.x, this.l.y);

    if (this.active == false) return;

    fill(#0000FF);
    rect(this.l.x-60, this.l.y-60, 60*2, 60*2);
    fill(#FFFFFF);
    text(this.id, this.l.x, this.l.y);
  }
}

class Thing {
  PShape thing;
  int ttl = 0;
  int phase = 1;
  float alpha = 0.0;

  Thing(PVector l) {
    this.thing = this.createThing(l);
  }

  Thing(PVector l, float p) {
    this.thing = this.createThing(l, p);
  }

  Thing(PVector l1, PVector l2) {
    this.thing = this.createThing(l1, l2);
  }

  PShape createThing(PVector l) {
    PShape cross1, cross2, border, thingie;
    ArrayList<PShape> things;
    things = new ArrayList<PShape>();

    cross1 = this.createThing(new PVector(l.x - 35, l.y - 35), new PVector(l.x + 35, l.y +35));
    cross2 = this.createThing(new PVector(l.x + 35, l.y - 35), new PVector(l.x - 35, l.y +35));

    border = createShape(RECT, l.x - 35, l.y - 35, 70, 70);
    border.setStrokeWeight(5);
    border.setStroke(#0B3C61);
    border.setStrokeJoin(ROUND);

    things.add(createThing(l, 4));

    for (float r = TWO_PI/4/2; r <= TWO_PI; r+=TWO_PI/4) {
      float x = l.x + cos(r) * 40;
      float y = l.y + sin(r) * 40;
      things.add(createThing(new PVector(x, y), 4));
    }

    thingie = createShape(GROUP);
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
    facade.strokeWeight(5);
    facade.stroke(#0B3C61);
    facade.strokeJoin(ROUND);

    for (float r = 0.0; r <= TWO_PI; r+=TWO_PI/p) {
      float x, y;

      x = l.x + cos(r) * 20;
      y = l.y + sin(r) * 20;
      shadow.vertex(x, y);

      x = l.x + cos(r) * 20/1.25;
      y = l.y + sin(r) * 20/1.25;      
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
    PShape thingie;
    thingie = createShape();
    thingie.beginShape();
    thingie.strokeWeight(5);
    thingie.stroke(#0B3C61);
    thingie.strokeJoin(ROUND);
    thingie.vertex(l1.x, l1.y);
    thingie.vertex(l2.x, l2.y);
    thingie.endShape();
    return thingie;
  }

  void setStroke() {
    int children = this.thing.getChildCount();

    switch(children) {
    case 0: 
      this.thing.setStroke(color(11, 60, 97, this.ttl));
      break;
    case 2: 
      this.thing.getChild(1).setStroke(color(11, 60, 97, this.ttl));
      break;
    case 8:
      this.thing.getChild(0).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(2).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(3).getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(4).getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(5).getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(6).getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(7).getChild(1).setStroke(color(11, 60, 97, this.ttl));
      break;
    }
  }

  void fadeIn() {
    if (this.ttl > 255) return;
    else if (this.ttl < 255) {
      this.setStroke();
    } else if (this.ttl == 255) {
      this.thing.setStroke(color(#0B3C61));
      phase++;
    }
  }

  void doWork() {
  }

  void fadeOut() {
  }

  void doPanic() {
  }

  void update() {
    this.ttl++;

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

    //println("TTL", this.ttl, "Children", this.thing.getChildCount(), "Phase", this.phase, "Max", 30*60*2);
  }

  void render() {
    shape(this.thing);
  }
}
