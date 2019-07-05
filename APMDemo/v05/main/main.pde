ArrayList<Cell> cells;
int cellSize, cols, rows;
float xoff, yoff, midx, midy;
int seconds;

Cell rc;
PVector rcl;

void setup() {
  size(720, 1280);

  //size(1600, 900);
  //noLoop();
  //noStroke();

  seconds = 0;

  cells = new ArrayList<Cell>();
  cellSize = 60;
  cols = (int)(width/(cellSize*1.0))-1;
  rows = 9;
  xoff = (width - (cols * cellSize))/2;
  yoff = (height - (rows * cellSize))/2; 

  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {

      if (random(100) < 60) {

        PVector l = new PVector();     
        l.x = x*cellSize + xoff + cellSize/2 + random(-cellSize/10, cellSize/10);
        l.y = y*cellSize + yoff + cellSize/2 + random(-cellSize/10, cellSize/10);

        Cell cell = new Cell(l, (int)(rows * x + y));
        cells.add(cell);
      }
    }
  }

  cells.get((int)(random(cells.size()))).active = true;
}

void draw() {
  //background(0);

  for (Cell c : cells) {
    c.render();
  }

  boolean done = false;

  if ((int)(frameCount % 60) == 0) {
    seconds++;
    //println(seconds, frameCount, frameRate);

    for (Cell c1 : cells) {
      if (c1.active == true && done == false) {
        for (float a = 0.0; a < (TWO_PI - PI/4); a+=PI/4) {

          float x = c1.l.x + cos(a) * cellSize;
          float y = c1.l.y + sin(a) * cellSize;

          for (Cell c2 : cells) {
            if (c1.id == c2.id) continue;
            if (c2.checkBounds(new PVector(x, y)) == true && c2.active == false) {
              line(c1.l.x, c1.l.y, c2.l.x, c2.l.y);
              c2.active = true;
              done = true;
            }
          }
        }
      }
    }

    int miss = 0;

    for (Cell c : cells) {
      if (c.active == false) miss++;
    }


    if (done == false && miss > 0) {
      println("Missing: ", miss);
      for (Cell c : cells) {
        if (c.active == false) {
          c.active = true;
          break;
        }
      }
    }
  }
}

class Cell {
  PVector l;
  int id;
  boolean active;
  int[] neighbours;

  Cell(PVector l, int id) {
    this.l    = l ;
    this.id   = id ;
    this.neighbours = new int[0];
    this.active = false;
  }

  void addNeighbour(int idx) {
    this.neighbours = (int[]) append(this.neighbours, idx);
  }

  boolean isNeighbour(int idx) {
    if (this.id == idx && this.active == true) return true;
    return false;
  }

  boolean checkBounds(PVector t) {
    if (t.x >= (this.l.x-cellSize/2) && t.x <= (this.l.x + cellSize/2) && 
      t.y >= (this.l.y-cellSize/2) && t.y <= (this.l.y + cellSize/2) ) 
      return true;
    return false;
  }

  void render() {


    //fill(#F0000F, 50);
    //noFill();
    //rect(this.l.x - cellSize/2, this.l.y - cellSize/2, cellSize, cellSize);

    if (this.active != true) return;

    fill(#FFFFFF);
    ellipse(this.l.x, this.l.y, 20, 20);

    //  print(this.id, " |\t");
    //  for (int i = 0; i < this.neighbours.length; i++) {
    //    print(this.neighbours[i], "\t");
    //  }
    //  println();
    //}
  }
}

void mousePressed() {
  for (Cell c : cells) {
    if (c.checkBounds(new PVector(mouseX, mouseY)) == true) {
      println(c.id, " pressed");
    }
  }
}
