final int UNIT = 20;
final int MULT =  4;
final int CELL = UNIT * MULT;
final int CON  =  1;
final int POD  =  2;

int CELLS, ROWS, COLS;

final float a1 [] = {0, 45, 270, 315};

Grid grid;
void setup() {
  size(1600, 900);
  background(#FFFFFF);
  noFill();

  COLS = (width/(CELL))-1;
  ROWS = 7;
  CELLS = COLS * ROWS;

  grid = new Grid(ROWS, COLS);
  int s = ROWS/2;
  println("Columns", COLS, "Rows: ", ROWS, "Cells:", CELLS, s, s * COLS);
  
  createMesh();
  noLoop();
}

void draw() {
  background(#FFFFFF);
  grid.render();

  //stroke(#0000FF, 50);
  //strokeWeight(1);
  //line(0, 0, width, height);
  //line(0, height, width, 0);
  //line(0, height/2, width, height/2);
  //line(width/2, 0, width/2, height);


}

boolean chance() {
  if (random(100) < 10) {
    return false;
  }
  return true;
}

void createMesh() {
  int id = ROWS / 2 * COLS;
  println(ROWS, COLS, id);
  
  grid.cells.get(id).strk = #CC0000;
  
}

class Grid {
  int rows, cols;
  ArrayList<Cell> cells;

  Grid(int r, int c) {
    this.rows = r;
    this.cols = c;
    this.cells = new ArrayList<Cell>();

    float xoff = (width - (this.cols * (CELL)))/2;
    float yoff = (height - (this.rows * (CELL)))/2;

    for (int col = 0; col < this.cols; col++) {
      for (int row = 0; row < this.rows; row++) {
        float x = (col * (CELL)) + xoff + CELL/2;
        float y = (row * (CELL)) + yoff + CELL/2;
        int idx = row * this.cols + col;

        Cell cell = new Cell(new PVector(x, y));

        // row * numCols + cols = index
        cell.id = idx;

        this.cells.add(cell);
      }
    }
  }
  
  Cell getCell(int id) {
    return this.cells.get(id);
  }

  void render() {
    for (Cell cell : this.cells) {
      cell.render();
    }
  }
}

class Cell {
  PVector l;
  int id;
  color strk;

  Cell(PVector l) {
    this.l = l;
    this.strk = #000000;
  }

  void render() {
    noFill();
    stroke(#CCCCCC, 100);

    float x = this.l.x - (CELL/2);
    float y = this.l.y - (CELL/2);

    for (int unitX = 0; unitX < MULT; unitX++) {
      for (int unitY = 0; unitY < MULT; unitY++) {
        rect(x + (unitX * UNIT), y + (unitY * UNIT), UNIT, UNIT);
      }
    }

    stroke(this.strk);
    rect(this.l.x - (UNIT * 2), this.l.y - (UNIT * 2), UNIT * 4, UNIT * 4);

    noStroke();
    fill(0);
    //ellipse(this.l.x, this.l.y, 5, 5);
    String t = ""+ this.id;
    float tw = textWidth(t);
    float th = 12.0;
    textSize(th);
    text(t, this.l.x - tw/2, this.l.y+th/2);
    println(this.id, hex(this.strk, 6));
  }
}
