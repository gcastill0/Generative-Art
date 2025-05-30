import java.util.*;
import java.io.File;
import processing.svg.*;

int MATRIX_SIZE = 10;

int WIDTH = 1400;
int HEIGHT = (WIDTH * 9 / 16) - ((WIDTH * 9 / 16)%100) ;

int CELL_SIZE =  WIDTH > HEIGHT ? floor(HEIGHT / MATRIX_SIZE) : floor((WIDTH + HEIGHT) / 2 / MATRIX_SIZE);

int ROWS = HEIGHT / CELL_SIZE;
int COLS = WIDTH / CELL_SIZE;

int MATRIX_MAX = ROWS * COLS;

int H_OFFSET = (WIDTH - COLS * CELL_SIZE)/2;

int W = 0;
int N = 1;
int E = 2;
int S = 3;

int[][] MATRIX_TILES = {
  {1, 0, 0, 0}, //  0 =>  1
  {0, 1, 0, 0}, //  1 =>  2
  {0, 0, 1, 0}, //  2 =>  3
  {0, 0, 0, 1}, //  3 =>  4
  {1, 1, 0, 0}, //  4 =>  5
  {0, 1, 1, 0}, //  5 =>  6
  {0, 0, 1, 1}, //  6 =>  7
  {1, 0, 0, 1}, //  7 =>  8
  {0, 1, 0, 1}, //  8 =>  9
  {1, 0, 1, 0}, //  9 => 10
  {1, 1, 1, 1}, // 10 => 11
  {0, 0, 0, 0}, // 11 => 12
  {0, 1, 0, 1}, // 12 => 13
  {1, 0, 1, 0}, // 13 => 14
  {0, 1, 0, 1}, // 14 => 15
  {1, 0, 1, 0}, // 15 => 16
  {0, 1, 0, 1}, // 16 => 17
  {1, 0, 1, 0}, // 17 => 18
  {1, 1, 1, 1}, // 18 => 19
  {1, 0, 1, 0}  // 19 => 20
};

PShape[] images;
PShape s;

boolean record;

Matrix matrix;

void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  images = new PShape[MATRIX_TILES.length];

  //File dir = new File(sketchPath("data"));
  //File [] files = dir.listFiles();

  for (int i = 0; i < MATRIX_TILES.length; i++) {
    String image_name = String.format("tile_%02d.svg", i+1);
    images[i] = loadShape(image_name);
    // images[i].fill(#E1EBEF);
    // images[i].disableStyle();
  }

  matrix = new Matrix();
  matrix.initialize();

  // textAlign(CENTER, CENTER);
  // strokeWeight(3);

  // fill(#06516C, 100);
  // noStroke();
  // fill(#2C3E4A);
  // stroke(#011319);
  // background(#E1EBEF);

  // background(#011319);
  // noLoop();
  //beginRaw(SVG, "filename.svg");
  record = true;

  if (record) {
    // Note that #### will be replaced with the frame number. Fancy!
    beginRecord(SVG, "frame-####.svg");
  }
}

void draw() {

  matrix.render();
}

class Matrix {

  ArrayList<Cell> Cells = new ArrayList<Cell>();
  ArrayList<Integer> cells_available = new ArrayList<Integer>();
  ArrayList<Integer> cells_history = new ArrayList<Integer>();
  int cell_render_active = 0;

  Matrix() {
    for (int i = 0; i < MATRIX_MAX; i++) {
      this.Cells.add(new Cell(i));
      this.cells_available.add(i);
    }
  }

  void initialize() {
    float current_matrix_entropy = this.matrix_entropy();

    int running_cell_id;
    Cell running_cell;
    int tile_id;

    while (current_matrix_entropy > 1.0 && cells_available.size() >= 0) {
      running_cell_id = this.get_candidate_id();
      running_cell = this.Cells.get(running_cell_id);
      tile_id = get_tile_id(running_cell);

      running_cell.initialize(tile_id);
      running_cell.get_options();
      running_cell.calculate_rating();
      running_cell.reduce_options();
      running_cell.get_entropy();
      running_cell.next();

      current_matrix_entropy = this.matrix_entropy();
      this.matrix_reset();

      // print("Running Cell:", running_cell.id, "\tAssigned Tile:", tile_id, "\tMatrix Entropy:", current_matrix_entropy);
      // println("\t", cells_available);
    }
    println(this.cells_history.size(), this.Cells.size());
    println(this.cells_history);
  }

  int get_candidate_id() {
    int lowestEntropy = Integer.MAX_VALUE;
    int candidateID = -1;

    int index = int(random(this.cells_available.size()));
    candidateID = this.cells_available.get(index);
    lowestEntropy = this.Cells.get(candidateID).get_entropy();

    for (int cell_id : this.cells_available) {
      Cell cell = this.Cells.get(cell_id);
      int cell_entropy = cell.get_entropy();

      if (cell_entropy == 1) continue;

      if (cell_entropy < lowestEntropy) {
        lowestEntropy = cell_entropy;
        candidateID = cell.id;
      }
    }

    this.cells_history.add(candidateID);

    return candidateID;
  }

  int get_tile_id(Cell c) {
    int tile_id = -1;

    // print(c.options, "\t");

    if (c.get_tile_average() == -1.0) {
      tile_id = int(random(MATRIX_TILES.length));
    } else {
      int index = int(random(c.options.size()));
      tile_id = c.options.get(index);
    }

    return tile_id;
  }

  void matrix_reset() {
    for (Cell cell : this.Cells) {
      if (cell.get_entropy() == 1 && this.cells_available.contains(cell.id)) {
        this.cells_available.remove(Integer.valueOf(cell.id));
      }
      cell.visited = false;
    }
  }

  float matrix_entropy() {
    float average_matrix_entropy = 0.0;
    for (Cell cell : this.Cells) {
      average_matrix_entropy += cell.get_entropy();
    }

    average_matrix_entropy /= this.Cells.size();

    return average_matrix_entropy;
  }

  void render() {
    if (this.cell_render_active >= this.cells_history.size()) {
      save("cross.jpg");
      endRecord();
      noLoop();
      exit();
    }

    int index = this.cells_history.get(this.cell_render_active);

    this.Cells.get(index).render();
    delay(50);
    this.cell_render_active++;

    //   for (Integer cellId: this.cells_history) {
    //     this.Cells.get(cellId).render();
    //     delay(100);
    //   }
    // for (Cell cell : this.Cells) {
    //   cell.render();
    // }
  }
}

/**** **** **** **** **** **** **** **** **** **** ****/
/**** **** **** **** **** **** **** **** **** **** ****/

class Cell {
  int id, col, row;
  int[] neighbour_ids = new int[4];
  int[] faces = new int[4];
  ArrayList<Integer> options = new ArrayList<Integer>();
  Map<Integer, Integer> options_frequency = new HashMap<>();

  int entropy;
  boolean visited;

  Cell(int id) {
    this.id = id;

    // index = row * COLS + col

    this.col = this.id % COLS;
    this.row = this.id / COLS;

    // West  id - 1,    col != 0
    this.neighbour_ids[W] = this.col == 0 ? - 1 : this.id - 1;

    // North id - COLS  row != 0
    this.neighbour_ids[N] = this.row == 0 ? - 1 : this.id - COLS;

    // East  id + 1     col != MATRIX_SIZE - 1
    this.neighbour_ids[E] = this.col >= COLS - 1 ? - 1 : this.id + 1;

    // South id + MATRIX_SIZE  row != MATRIX_SIZE - 1
    this.neighbour_ids[S] = this.row >= ROWS - 1 ? - 1 : this.id + COLS;

    for (int i = 0; i < MATRIX_TILES.length; i++) {
      this.options.add(i);
    }

    for (int i = 0; i < 4; i++) {
      this.faces[i] = -1;
    }

    this.entropy = this.options.size();

    this.visited = false;

    // this.printData();
  }

  /**** **** **** **** **** **** **** **** **** ****/

  void initialize(int tile_id) {
    for (int i = 0; i < 4; i++) {
      this.faces[i] = MATRIX_TILES[tile_id][i];
    }

    this.options.removeAll(this.options);
    this.options.add(tile_id);
  }

  /**** **** **** **** **** **** **** **** **** ****/

  void get_options() {
    for (int i = 0; i < 4; i++) {
      switch(i) {
      case 0:
        this.options.addAll(this.getOptions(W, this.faces[i]));
        break;
      case 1:
        this.options.addAll(this.getOptions(N, this.faces[i]));
        break;
      case 2:
        this.options.addAll(this.getOptions(E, this.faces[i]));
        break;
      case 3:
        this.options.addAll(this.getOptions(S, this.faces[i]));
        break;
      }
    }

    Collections.sort(this.options);
  }

  /**** **** **** **** **** **** **** **** **** ****/

  void calculate_rating() {
    for (int i : this.options) {
      this.options_frequency.put(i, this.options_frequency.getOrDefault(i, 0) + 1);
    }
  }

  /**** **** **** **** **** **** **** **** **** ****/

  void reduce_options() {

    List<Integer> repeatedElements = new ArrayList<>();
    int highestCount = Integer.MIN_VALUE;

    for (int count : this.options_frequency.values()) {
      if ( count > highestCount ) {
        highestCount = count;
      }
    }

    for (int i : this.options) {
      if (this.options_frequency.get(i) == highestCount) {
        repeatedElements.add(i);
      }
    }

    if (repeatedElements.size() == 0) {
      return;
    }

    this.options.removeAll(this.options);
    this.options.addAll(new LinkedHashSet<>(repeatedElements));
  }

  /**** **** **** **** **** **** **** **** **** ****/

  ArrayList<Integer> getOptions(int direction, int match) {
    ArrayList<Integer> newOptions  = new ArrayList<Integer>();

    for (int i = 0; i < MATRIX_TILES.length; i++) {
      if (MATRIX_TILES[i][direction] == match) {
        newOptions.add(i);
      }
    }

    // println(newOptions);
    return newOptions;
  }

  /**** **** **** **** **** **** **** **** **** ****/

  int get_entropy() {
    this.entropy = this.options.size();
    return this.entropy;
  }

  /**** **** **** **** **** **** **** **** **** ****/

  float get_tile_average() {
    float avg = 0.0;
    float sum = 0.0;

    for (Integer f : this.faces) {
      sum += f;
    }

    avg = sum / this.faces.length;

    return avg;
  }

  /**** **** **** **** **** **** **** **** **** ****/

  void next() {
    if (this.visited) return;
    this.visited = true;
    // print(this.id, " => ");

    for (int i = 0; i < this.neighbour_ids.length; i++) {
      // if neighbour ID is invalid, ignore it

      if (this.neighbour_ids[i] == -1) {
        continue;
      }

      Cell neighbour = matrix.Cells.get(this.neighbour_ids[i]);
      //   print(neighbour.id, this.neighbour_ids[i]);
      switch(i) {
      case 0:
        //print("W: ");
        if (neighbour.faces[W] == -1) {
          neighbour.faces[E] = this.faces[W];
        }
        break;
      case 1:
        //print("N: ");
        if (neighbour.faces[N] == -1) {
          neighbour.faces[S] = this.faces[N];
        }
        break;
      case 2:
        //print("E: ");
        if (neighbour.faces[E] == -1) {
          neighbour.faces[W] = this.faces[E];
        }
        break;
      case 3:
        //print("S: ");
        if (neighbour.faces[S] == -1) {
          neighbour.faces[N] = this.faces[S];
        }
        break;
      }

      neighbour.get_options();
      neighbour.calculate_rating();
      neighbour.reduce_options();
      neighbour.get_entropy();
      neighbour.next();
    }
  }

  /**** **** **** **** **** **** **** **** **** ****/

  void printData() {
    System.out.printf("ID :%2d", this.id);
    print("\tR", this.row, "C", this.col);
    print("\tN: [");
    for (int i = 0; i < 4; i++) {
      System.out.printf(" % 3d", this.neighbour_ids[i]);
      if (i < 3) print(",");
    }
    print(" ]");
    System.out.printf("  E :%2d, Eavg: %3f\n", this.entropy, this.get_tile_average());
    print("O:", this.options);
    print("\tF: [");
    for (int i = 0; i < 4; i++) {
      System.out.printf("%3d", this.faces[i]);
      if (i < 3) print(",");
    }
    print(" ]");

    print("\nRatings: [ ");

    for (Map.Entry < Integer, Integer > entry : options_frequency.entrySet()) {
      System.out.print(entry.getKey() + " : " + entry.getValue() + ", ");
    }
    print(" ] ");
    print("\tV:", this.visited);
    println();
    println();
  }

  /**** **** **** **** **** **** **** **** **** ****/

  void printFaces() {
    text(this.faces[W], this.col * CELL_SIZE + 10, this.row * CELL_SIZE + CELL_SIZE / 2);
    text(this.faces[N], this.col * CELL_SIZE + CELL_SIZE / 2, this.row * CELL_SIZE + 10);
    text(this.faces[E], this.col * CELL_SIZE + CELL_SIZE - 10, this.row * CELL_SIZE + CELL_SIZE / 2);
    text(this.faces[S], this.col * CELL_SIZE + CELL_SIZE / 2, this.row * CELL_SIZE + CELL_SIZE - 10);
  }

  void render() {
    // this.printData();

    //fill(#E1EBEF);
    strokeWeight(0.5);
    stroke(#596979);
    fill(#001219);
    // rect(this.col * CELL_SIZE, this.row * CELL_SIZE, CELL_SIZE, CELL_SIZE);

    // fill(#222222);
    // text(this.get_entropy(), this.col * CELL_SIZE + CELL_SIZE / 2, this.row * CELL_SIZE + CELL_SIZE / 2);
    // this.printFaces();

    // noFill();
    // strokeWeight(4);
    // stroke(#011319);

    noStroke();
    // fill(#2C3E4A);
    // fill(#03A4B0);

    if (this.get_entropy() == 1) {
      int option = this.options.get(0);
      shape(images[option], this.col * CELL_SIZE, this.row * CELL_SIZE, CELL_SIZE, CELL_SIZE);
    }
  }
}
