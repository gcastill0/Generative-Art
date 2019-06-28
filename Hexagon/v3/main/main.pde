final int sides = 6;
final float r = 50;
final float alpha = radians((360)/sides);

color [] rgb = {#B2D4EF, #80B3DA, #5894C2, #3977A7, #206396, #FF0000, #EC8080, #FFA8A8} ;
int h_id = 0;

ArrayList<Hexagon> hList;

void setup() {
  size(800, 800);
  fill(0);

  hList = new ArrayList<Hexagon>();

  Hexagon h = new Hexagon(width/2, height/2);
  hList.add(h);
  hList.addAll(h.expandNeighbours());
}

void draw() {    
  background(255);

  //for (Hexagon h : hList) {
  //  h.render();
  //  //    h.showNeighbours();
  //}

  println(hList.size());
  println(floor(width/(r*2)), floor(height/(r*2)));

  stroke(0,100);
  noFill();
  drawGrid_r(width/2, height/2, 0);



  noLoop();
}

void drawGrid_r(float x, float y, int c) {
  ellipse(x, y, 5, 5);
  for (float a = PI/2; (round( a * 100000.0f ) / 100000.0f) <= TWO_PI + PI/2; a += alpha) {
    float nx = x + cos(a) * r * 2 ;
    float ny = y + sin(a) * r * 2 ;

    if (((nx > 0 && nx < width ) && (ny > 0 && ny < height )) && c < 6) {
      ellipse(nx, ny, r * 2, r * 2);
      drawGrid_r(nx, ny, c+1);
    }
  }
}

void drawGrid() {

  for (float a = 0; (round( a * 100000.0f ) / 100000.0f) <= TWO_PI; a += alpha) {
    float x = width/2 + cos(a) * r * 2 ;
    float y = height/2 + sin(a) * r * 2 ;
    ellipse(x, y, 5, 5);
  }


  //boolean real = false;

  //for (float x = r ; x < width; x += cos(alpha) * r * 2) {
  //  for (float y = height/2; y < height; y += sin(alpha) * r * 2) {
  //    line(x, 0, x, height);
  //    line(0, y, width, y);

  //    float px = x;
  //    float py = y;

  //    if (real) ellipse(px, py, 10, 10);
  //    real = !real;
  //  }
  //  for (float y = height/2; y > 0; y -= sin(alpha) * r * 2) {
  //    line(x, 0, x, height);
  //    line(0, y, width, y);

  //    int px = floor(x);
  //    int py = floor(y);

  //    if (real) ellipse(px, py, 10, 10);
  //    real = !real;
  //  }
  //  real = !real;
  //}
}