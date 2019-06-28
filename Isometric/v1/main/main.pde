final int tileWidth = 75;
final int tileHeight = floor(tileWidth/2);
ArrayList<Tile> tiles;
int nTiles;

void setup() {
  size(1600, 900);
  nTiles = floor((height*0.8)/tileHeight);
  tiles = new ArrayList<Tile>();
  float p = (TWO_PI*4)/nTiles;
  float a = PI;

  for (int x = 0; x < nTiles; x++) {
    for (int y = 0; y < nTiles; y++) {
      float z = 0.25; //ceil(abs(cos(a) * random(2, 4) - sin(a) * random(1, 3))%3) ;
      Tile tile = new Tile(x, y, z);
      tiles.add(tile);
      a += p;
    }
  }
}

void draw() {
  background(255);

  grid();

  translate(width/2, floor((height-(height*0.8)))/1.5);

  for (Tile tile : tiles) {
    tile.render();
  }

  noLoop();
}

void grid() {
  stroke(0, 20);
  int hTiles = width/tileWidth;
  int vTiles = height/tileWidth;

  for (int x = 0; x <= hTiles; x++) {
    for (int y = 0; y <= vTiles; y++) {
      float px = x * tileWidth; 
      float py = y * tileWidth;
      
      rect(px, py, tileWidth, tileWidth);
      
      beginShape();
      vertex(px-tileWidth/2, py + tileHeight/2);
      vertex(px, py);
      vertex(px + tileWidth/2, py + tileHeight/2);   
      vertex(px, py + tileHeight);
      endShape(CLOSE);
    }
  }
}
