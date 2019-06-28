final int sides = 6;
final float r = 50;
final float alpha = radians((360)/sides);

color [] rgb = {#B2D4EF, #80B3DA, #5894C2, #3977A7, #206396, #FF0000, #EC8080, #FFA8A8} ;

ArrayList<Hexagon> hList;

void setup() {
  size(1600, 900);
  stroke(255);
  strokeWeight(10);
  fill(0);

  hList = new ArrayList<Hexagon>();

  Hexagon h = new Hexagon(width/2, height/2);
  hList.add(h);
  hList.addAll(h.expandNeighbours());

  Hexagon k = new Hexagon(width/2 + r * 4, height/2);
  hList.add(k);
  hList.addAll(k.expandNeighbours());

}

void draw() {    
  background(175,0,175);

  rect(width/2 - r * 6 + r * 2, height/2 - r * 3.5, r * 12, r * 7, 10, 10, 10, 10);
  for (Hexagon h : hList) {
    h.render();
  }

//  println(hList.size());
//  noLoop();
}