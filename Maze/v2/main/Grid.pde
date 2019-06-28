final static int cellSize = 20;

class Grid {
  Cell cells[];
  int rows, cols, size, active;
  ArrayList<Integer> history;
  boolean completed = false;

  Grid() {
    this.rows = int(height/cellSize);
    this.cols = int(width/cellSize);
    this.size = this.rows * this.cols;
    this.cells = new Cell[this.size];
    this.history = new ArrayList();
    this.active = int(random(this.size));

    for (int c = 0; c < this.cols; c++) {
      for (int r = 0; r < this.rows; r++) {
        int idx = r * this.cols + c;
        this.cells[idx] = new Cell(c*cellSize, r*cellSize, cellSize);
        this.cells[idx].setID(idx);
      }
    }
  }

  void update() {

    if (this.active != -1) {
      this.history.add(this.active);     
      Cell cell = this.cells[this.active];
      cell.active = true;
      cell.visited = true;
    } else if (this.history.size() > 0) {
      int idx = this.history.size() - 1;
      this.active = this.history.get(idx);
      this.cells[this.active].active = true;
      this.history.remove(idx);
    } else {
      this.completed = true;
    }

    this.active = getNext();
  }

  int getNext() {

    ArrayList<Integer> neighbours = new ArrayList();

    int r = floor(this.active/this.cols%this.cols);
    int c = floor(this.active%this.cols);
    int left   = r * this.cols + c - 1 ;
    int top    = (r-1) * this.cols + c ;
    int right  = r * this.cols + c + 1 ;
    int bottom = (r+1) * this.cols + c ;

    if (c-1>=0 && !this.cells[left].visited) neighbours.add(left);
    if (r-1>=0 && !this.cells[top].visited ) neighbours.add(top);
    if (c+1<this.cols && !this.cells[right].visited ) neighbours.add(right);
    if (r+1<this.rows && !this.cells[bottom].visited) neighbours.add(bottom);

    int choice = -1;
    int diff = 0;

    if (neighbours.size() > 0) {
      choice = floor(random(neighbours.size()));
      choice = neighbours.get(choice);

      diff = this.active - choice;      
      if (diff == -1) {
        this.cells[choice].clearWall('l');
        this.cells[this.active].clearWall('r');
      } else if (diff == 1) {
        this.cells[choice].clearWall('r');
        this.cells[this.active].clearWall('l');
      } else if (diff < -1) {
        this.cells[choice].clearWall('t');
        this.cells[this.active].clearWall('b');
      } else if (diff > 1) {
        this.cells[choice].clearWall('b');
        this.cells[this.active].clearWall('t');
      }
    }

    return choice;
  }

  void render() {
    for (Cell c : this.cells) c.render();
  }

  void drawBE() {
    noStroke();
    fill(255, 100, 100);
    rect(2, 2, cellSize-4, cellSize-4);
    rect(((this.cols-1)*cellSize)+2, ((this.rows-1)*cellSize)+2, cellSize-4, cellSize-4);
  }
}