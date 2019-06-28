final float tileSize = 50;
final float tileWidth = tileSize;
final float tileHeight = tileSize/2;
//ArrayList<Tile> tiles;
int nTiles;
ArrayList<Block> blocks;

Block block;

IntDict inventory;

void setup() {
  size(1920, 1080);
  nTiles = (floor((height)/tileHeight) < floor((width*1.0)/tileWidth)) ? floor((height)/tileHeight) : floor((width*1.0)/tileWidth);
  
  blocks = new ArrayList<Block>();

  //inventory = new IntDict();
  //inventory.set("cd", 84);
  //inventory.set("tapes", 15);
  //inventory.set("records", 102);

  //String[] theKeys = inventory.keyArray();
  //for (String _key : theKeys) {
  //  println(_key, inventory.get(_key));
  //}

  //println(inventory);
  
  blocks.add(new Block(0,0,8,8));
  blocks.add(new Block(10,0,4,4));
  blocks.add(new Block(10,6,4,8));
  blocks.add(new Block(0,10,8,4));

  //for (int i = 0; i < 20; i++) {
  //  int x = int(random(nTiles));
  //  int y = int(random(nTiles));
  //  float z = 0.5;//int(random(1, 3)); //1.0;
  //  Tile tile = new Tile(x, y, z);
  //  tiles.add(tile);
  //}

  //for (int x = 0; x < nTiles; x++) {
  //  for (int y = 0; y < nTiles; y++) {
  //    float z = 0.5;//int(random(1, 3)); //1.0;
  //    Tile tile = new Tile(x, y, z);
  //    tiles.add(tile);
  //  }
  //}

  noLoop();
}

void draw() {
  background(#1D1F25);

  grid();

  pushMatrix();

  translate(width/2, height/2-(nTiles/2*tileHeight));
  
  for (Block block : blocks) {
    block.render();
  }
  popMatrix();

  stroke(#FF0000);
  line(0, height/2, width, height/2);
  line(0, height/4, width, height/4);
  line(0, height*.75, width, height*.75);
  
  line(width/2, 0, width/2, height);
  line(width/4, 0, width/4, height);
  line(width*.75, 0, width*.75, height);
}

void grid() {
  stroke(255, 15);
  noFill();

  int hTiles = int(width/tileWidth);
  int vTiles = int(height/tileHeight);
  float h_offset = (width - ( hTiles * tileWidth))/2;
  float v_offset = (height - ( vTiles * tileHeight))/2;

  for (int x = 0; x <= hTiles; x++) {
    for (int y = 0; y <= vTiles; y++) {
      float px = x * tileWidth + h_offset; 
      float py = y * tileHeight + v_offset - tileHeight/2;

      //rect(px, py, tileWidth, tileHeight*2);

      beginShape();
      vertex(px-tileWidth/2, py + tileHeight/2);
      vertex(px, py);
      vertex(px + tileWidth/2, py + tileHeight/2);   
      vertex(px, py + tileHeight);
      endShape(CLOSE);
    }
  }
}
