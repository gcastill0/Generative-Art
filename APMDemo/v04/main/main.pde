ArrayList<Cell> cells;
ArrayList<Thing> conns;
ArrayList<Thing> things;

int cellSize, cols, rows;
float xoff, yoff, midx, midy;

void setup() {
  size(1600, 900);

  cells = new ArrayList<Cell>();
  things = new ArrayList<Thing>();
  conns = new ArrayList<Thing>();

  cellSize = 120;
  cols = (int)(width/(cellSize*0.9))-1;
  rows = 3;
  xoff = (width - (cols * cellSize))/2;
  yoff = (height - (rows * cellSize))/2; 

  //noLoop();

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {

      PVector l = new PVector();     
      l.x = x*cellSize + xoff + cellSize/2 + random(-cellSize/10, cellSize/10);
      l.y = y*cellSize + yoff + cellSize/2 + random(-cellSize/10, cellSize/10);


      Thing thing = new Thing(l);
      Cell cell = new Cell(thing, (int)(rows * x + y));

      if (random(100) < 50) {
        cell.active = true;
      }

      cells.add(cell);
    }
  }

  for (int c = 0; c < cols; c++) {
    for (int r = 0; r < rows; r++) {
      Cell cell = cells.get(rows * c + r);
      if (cell.active == false) continue;
      int[] neighbours = new int[1];
      switch(r) {
      case 0:
        neighbours = new int[3];
        neighbours[0] = rows * c + r + 1;
        neighbours[1] = rows * c + r + 3;
        neighbours[2] = rows * c + r + 4;
        break;
      case 1:
        neighbours = new int[4];
        neighbours[0] = rows * c + r + 1;
        neighbours[1] = rows * c + r + 2;
        neighbours[2] = rows * c + r + 3;
        neighbours[3] = rows * c + r + 4;
        break;
      case 2:
        neighbours = new int[2];
        neighbours[0] = rows * c + r + 2;
        neighbours[1] = rows * c + r + 3;
        break;
      }

      for (int i = 0; i < neighbours.length; i++) {
        int candidateIdx = neighbours[i];
        if (candidateIdx >= 0 && candidateIdx < cells.size()) {
          if (cells.get(candidateIdx).active == true) {
            cell.addNeighbour(candidateIdx);
          }
        }
      }
    }
  }

  for (Cell c : cells) {
    if (c.active == true) {
      for (int i = 0; i < c.neighbours.length; i++) {
        Thing conn = new Thing(c.thing.l, cells.get(c.neighbours[i]).thing.l);
        conns.add(conn);
      }
    }
  }
}

void draw() {
  background(255);
  for (Thing c : conns) {
    c.update();
    c.render();
  }

  for (Cell c : cells) {
    c.render();
  }
}

class Conn {
  PVector p1, p2;

  Conn(PVector p1, PVector p2) {
    this.p1 = p1;
    this.p2 = p2;
  }

  void render() {
    strokeWeight(5);
    stroke(#0B3C61);
    line(this.p1.x, this.p1.y, this.p2.x, this.p2.y);
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
  int phase = 1;
  float alpha = 0.0;

  Thing(PVector l) {
    this.l     = l;
    this.thing = this.createThing(this.l);
  }

  Thing(PVector l, float p) {
    this.l     = l;
    this.thing = this.createThing(this.l, p);
  }

  Thing(PVector l1, PVector l2) {
    this.thing = this.createThing(l1, l2);
  }

  PShape createThing(PVector l) {
    PShape cross1, cross2, shadow, border, thingie;
    ArrayList<PShape> things;
    things = new ArrayList<PShape>();

    cross1 = this.createThing(new PVector(l.x - 35, l.y - 35), new PVector(l.x + 35, l.y +35));
    cross2 = this.createThing(new PVector(l.x + 35, l.y - 35), new PVector(l.x - 35, l.y +35));

    shadow = createShape(RECT, l.x - 37, l.y - 37, 74, 74);
    shadow.setStrokeWeight(5);
    shadow.setStroke(#FFFFFF);
    shadow.setStrokeJoin(ROUND);

    border = createShape(RECT, l.x - 35, l.y - 35, 70, 70);
    border.setStrokeWeight(3);
    border.setStroke(#0B3C61);
    border.setStrokeJoin(ROUND);

    things.add(createThing(l, 4));

    for (float r = TWO_PI/4/2; r <= TWO_PI; r+=TWO_PI/4) {
      float x = l.x + cos(r) * 40;
      float y = l.y + sin(r) * 40;
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
    PShape thingie, shadow, border;

    shadow = createShape();
    shadow.beginShape();
    shadow.strokeWeight(10);
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
    border.stroke(#0B3C61);
    border.strokeJoin(ROUND);
    border.vertex(l1.x, l1.y);
    border.vertex(l2.x, l2.y);
    border.endShape();

    thingie = createShape(GROUP);
    thingie.addChild(shadow);
    thingie.addChild(border);

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
    case 9:
      this.thing.getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(2).getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(3).getChild(1).setStroke(color(11, 60, 97, this.ttl));      
      this.thing.getChild(4).getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(5).getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(6).getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(7).getChild(1).setStroke(color(11, 60, 97, this.ttl));
      this.thing.getChild(8).getChild(1).setStroke(color(11, 60, 97, this.ttl));
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
