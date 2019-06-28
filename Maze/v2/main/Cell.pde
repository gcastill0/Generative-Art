class Cell {
  float x, y;
  int size;
  boolean visited, block;
  int walls[], id;
  boolean active;
  Cell neighbours[];

  Cell(float x, float y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.visited = false;
    this.block = false;
    this.walls = new int[4];
    this.id = -1;
    this.active = false;
    this.neighbours = new Cell[4];

    for (int i=0; i < this.walls.length; i++) {
      this.walls[i] = 1;
    }
  }

  void setID(int id) {
    this.id = id;
  }

  void clearWall(char w) {
    switch(w) {
    case 'l' :
      this.walls[0] = 0;
      break;
    case 't' : 
      this.walls[1] = 0;
      break;
    case 'r' : 
      this.walls[2] = 0;
      break;
    case 'b' : 
      this.walls[3] = 0;
      break;
    }
  }
  
  void clearWalls() {
    for (int i=0; i < walls.length; i++) {
      walls[i] = 0;
    }
  }

  void render() {
    float x1 = this.x;
    float x2 = this.x+this.size;
    float y1 = this.y;
    float y2 = this.y+this.size;
    
    noStroke();
    if (this.visited) fill(255);
    else noFill();
    //if (this.active) fill(255, 0, 0, 100);   
    rect(x1+2, y1+2, this.size-2, this.size-2);

    stroke(0);
    strokeWeight(5);

    if (this.walls[0] == 1) line(x1, y1, x1, y2);
    if (this.walls[1] == 1) line(x1, y1, x2, y1);
    if (this.walls[2] == 1) line(x2, y1, x2, y2);
    if (this.walls[3] == 1) line(x1, y2, x2, y2);

    this.active = false;
  }
}