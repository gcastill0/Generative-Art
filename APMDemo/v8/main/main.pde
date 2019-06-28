final int UNIT = 15;
final int MULT =  8;
final int CELL = UNIT * MULT;
int QUADTREE_CAPACITY = 4;
int COLS, ROWS;
float X, Y, W, H;
int COUNT;

QuadTree qtree, tree2;
ArrayList<PVector> points;
ArrayList<PVector> pointsFound;
ArrayList<Thing> bcons, things;

Area area;
Area area2;
float angle;

import com.hamoid.*;
VideoExport videoExport;

void setup() {
  size(720, 1280);
  background(#FFFFFF);
  //noFill();
  //noLoop();

  COLS = (width/CELL) - 1;
  ROWS = 5; //(height/CELL) - 1;
  COUNT = 0;

  X = (width - (COLS * CELL))/2 ;
  Y = (height - (ROWS * CELL))/2;
  W = COLS * CELL;
  H = ROWS * CELL;
  angle = random(TWO_PI);
  pointsFound = new ArrayList<PVector>();
  points = new ArrayList<PVector>();
  bcons = new ArrayList<Thing>();
  things = new ArrayList<Thing>();

  area  = new Area(X, Y, W, H);
  area2 = new Area(-200, -200, 100, 100);
  qtree = new QuadTree(area);

  stroke(#7FA6FF, 150);
  strokeWeight(2);

  for (int row = 0; row < ROWS; row++) {
    for (int col = 0; col < COLS; col++) {
      float x = random(col * CELL + X + random(40, 50), col * CELL + X + CELL - random(40, 50)); 
      float y = random(row * CELL + Y + random(40, 50), row * CELL + Y + CELL - random(40, 50));
      if (random(100) % 100 > 30) {
        PVector p = new PVector(x, y);
        Thing cluster = new Thing(p);
        bcons.add(cluster);
        points.add(p);
        qtree.insert(p);
      }
    }
  }

  for (PVector p : points) {
    pointsFound = new ArrayList<PVector>();

    Area ne = new Area(p.x, p.y - CELL * 0.60, CELL * 0.60 * 2, CELL * 0.60 * 2);
    Area nw = new Area(p.x - CELL * 0.60, p.y - CELL * 0.60, CELL * 0.60 * 2, CELL * 0.60 * 2);
    Area se = new Area(p.x, p.y, CELL * 0.60 * 2, CELL * 0.60 * 2);
    Area sw = new Area(p.x - CELL * 0.60, p.y, CELL * 0.60 * 2, CELL * 0.60 * 2);

    pointsFound.addAll(qtree.find(ne));
    pointsFound.addAll(qtree.find(nw));
    pointsFound.addAll(qtree.find(se));
    pointsFound.addAll(qtree.find(sw));

    for (int i = 0; i < pointsFound.size(); i++) { 
      Thing connection = new Thing(p, pointsFound.get(i));
      bcons.add(connection);
    }
  }

  for (int i = bcons.size() - 1; i >= 0; i--) {
    Thing thing = bcons.get(i);
    things.add(thing);
  }

  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

void draw() {
  background(#FFFFFF);

  for (Thing thing : things) {
    thing.update();
    thing.render();
  }

  //**** **** **** **** **** **** **** **** **** ****

  //filter(INVERT);
  videoExport.saveFrame();
  if (frameCount >= (30*45)) exit();
  //**** **** **** **** **** **** **** **** **** ****
}

boolean chance() {
  if (random(100) < 10) {
    return false;
  }
  return true;
}

void makeGrid(Area area, int l) {
  if (l <= 0) return; 

  Area ne = new Area(area.x, area.y, area.w/2, area.h/2);
  Area nw = new Area(area.x + area.w/2, area.y, area.w/2, area.h/2);
  Area se = new Area(area.x, area.y + area.h/2, area.w/2, area.h/2);
  Area sw = new Area(area.x + area.w/2, area.y + area.h/2, area.w/2, area.h/2);

  makeGrid(ne, l-1);
  makeGrid(nw, l-1);
  makeGrid(se, l-1);
  makeGrid(sw, l-1);

  area.render();
}
