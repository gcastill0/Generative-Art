final int sides = 6;
final float r = 50;
final float alpha = radians((360)/sides);

color [] rgb = {#B2D4EF, #80B3DA, #5894C2, #3977A7, #206396, #FF0000, #EC8080, #FFA8A8} ;

ArrayList<Hexagon> hList;

void setup() {
  size(900, 900);
  stroke(255);
  strokeWeight(10);
  fill(0);

  hList = new ArrayList<Hexagon>();

  Hexagon h = new Hexagon(width/2, height/2);
  hList.add(h);
  hList.addAll(h.expandNeighbours());
}

void draw() {    
  background(175, 0, 175);

  for (Hexagon h : hList) {
    h.render();
    h.showNeighbours();
  }

  println(hList.size());
  noLoop();
}