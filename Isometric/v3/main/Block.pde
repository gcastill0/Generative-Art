class Block {
  ArrayList<Tile> tiles;
  int xPos, yPos;
  int xLen, yLen;

  Block (int xPos, int yPos, int xLength, int yLength) {
    this.tiles = new ArrayList<Tile>();
    this.xPos  = xPos;
    this.yPos  = yPos;
    this.xLen  = xLength;
    this.yLen  = yLength;

    for (int x = this.xPos, i = 0; i < xLength; x++, i++) {
      for (int y = this.yPos, j = 0; j < yLength; y++, j++) {
        this.tiles.add(new Tile(x, y, 0.5));
      }
    }
  }

  void render() {
    for (Tile tile : this.tiles) {
      tile.render();
    }
  }
}
