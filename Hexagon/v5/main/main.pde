final int sides = 6;
final float r = 50;
final float alpha = radians((360)/sides);

color [] rgb = {#B2D4EF, #80B3DA, #5894C2, #3977A7, #206396, #FF0000, #EC8080, #FFA8A8} ;
int h_id;

ArrayList<Hexagon> hList;

void setup() {
  size(925, 900);
  stroke(100, 100);
  //strokeWeight(10);  
  //  fill(255);
  noFill();
  h_id = 0;

  hList = new ArrayList<Hexagon>();

  Hexagon h = new Hexagon(width/2, height/2);
  hList.add(h);
  hList.addAll(h.expandNeighbours());
  //  background(175, 0, 175);
  background(255);
}

void draw() {    

  for (Hexagon h : hList) {
    h.render();
//    h.showNeighbours();
  }

//  drawHexagon(width/2, height/2, 0);
  println(hList.size(), counter);
  noLoop();
}

int counter = 0;

void drawHexagon(float x, float y, float a) {
  if ((x < 0 || x > width) || (y < 0 || y> height)) return;

  ++counter;

  ArrayList<PVector> Points = new ArrayList<PVector>(); 

  float nx = x;
  float ny = y;
  float beta = a;

  for (; beta < TWO_PI + a; beta+=alpha) {
    Points.add(new PVector(nx, ny));
    nx = x + cos(beta) * r * 2;
    ny = y + sin(beta) * r * 2;
  }

  for (int i = 0; i < Points.size(); i++) {
    int j = i + 1;
    PVector p1 = Points.get(i);
    noFill();
    ellipse(p1.x, p1.y, r * 2, r * 2);
    fill(0);
//    text(i, p1.x, p1.y);
    if (j < Points.size()) {
      PVector p2 = Points.get(j);
      line(p1.x, p1.y, p2.x, p2.y);
    }
  }
}