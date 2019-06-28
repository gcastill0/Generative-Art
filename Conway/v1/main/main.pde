int cols, rows;
int cellSize = 100;
ArrayList<Cell> matrix;

void setup() {
  size(1600, 900);
  cols = floor(width/cellSize);
  rows = floor(height/cellSize);

  matrix = new ArrayList<Cell>();

  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      //  print("("+r+","+c, ") ");
      //  rect(r*cellSize, c*cellSize, cellSize, cellSize);
      matrix.add(new Cell(r, c));
    }
    //println();
  }

  noLoop();
}

void draw() {
  //  background(255);

  int midx = floor(cols/2);
  int midy = floor(rows/2);
  int midi = midy * cols + midx;

  //for (Cell c : matrix) {
  //  c.draw();
  //}

  for (int c = 0; c < cols; c++) {
    for (int r = 0; r < rows; r++) {

      int i = r * cols + c;
      Cell cell = matrix.get(i);

      if (i == midi) {
        stroke(255, 0, 0);
        strokeWeight(10);
        cell.draw();
        cell.getNeighbours();
        strokeWeight(1);
        stroke(0);
      } else {       
        cell.draw();
      }
    }
  }
}

class Cell {
  int currentState;
  int futureState;
  int id;
  float x, y;

  Cell(float x, float y) {

    this.currentState = floor(random(0, 9)); 
    this.x = x;
    this.y = y;
    this.id = floor(this.x * cols + this.y);
  }

  int nextState() {
    return 0;
  }

  void getNeighbours() {
    for (int c=-1; c < 2; c++) {
      for (int r=-1; r < 2; r++) {
        int col = floor(this.y + c);
        int row = floor(this.x + r);
        int idx = row * cols + col;

        println("idx:", this.id, "col:", col, "row:", row, "idx:", idx);
      }
    }
  }

  void update() {
    //this.currentState = this.futureState;
  }

  void draw() {
    fill(255);

    if (this.currentState == 1) {
      fill(0);
    }

    rect(this.y * cellSize, this.x * cellSize, cellSize, cellSize);

    fill(255, 0, 0);
    //text(this.id, this.y * cellSize + cellSize/2, this.x * cellSize + cellSize/4);
    //text(floor(this.y)+" , "+floor(this.x), this.y * cellSize + cellSize/2-10, this.x * cellSize + cellSize/2);
  }
}