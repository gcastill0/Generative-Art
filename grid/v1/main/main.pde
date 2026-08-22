public static final float UNIT_SIZE           = 1.3;
public static final int MATRIX_LENTGH         = 10;
public static final int MATRIX_CELL_UNITS     = 9;
public static final int MATRIX_CELL_UNIT_SIZE = 8;
public static final int MATRIX_CELL_SIZE      = int(UNIT_SIZE * MATRIX_CELL_UNIT_SIZE * MATRIX_CELL_UNITS);
public static final int MATRIX_CELL_CORNER    = int(MATRIX_CELL_SIZE * 0.02);
public static final int MATRIX_PADDING        = 2;
public static final int SKETCH_PADDING        = 10;

void settings() {
  int WIDTH  = MATRIX_LENTGH * MATRIX_CELL_SIZE + (MATRIX_PADDING * (MATRIX_LENTGH - 1)) + (SKETCH_PADDING * 2);
  int HEIGHT = MATRIX_LENTGH * MATRIX_CELL_SIZE + (MATRIX_PADDING * (MATRIX_LENTGH - 1)) + (SKETCH_PADDING * 2);
  size(WIDTH, HEIGHT);
}

void setup() {
  background(#EEF2F3);
  noStroke();
  noLoop();
}

void draw() {

  for (int r = 0; r < MATRIX_LENTGH; r++) {
    int VPAD = (r == 0) ? 0 : MATRIX_PADDING * r;
    for (int c = 0; c < MATRIX_LENTGH; c++) {
      int HPAD = (c == 0) ? 0 : MATRIX_PADDING * c;
      int ROW = r * MATRIX_CELL_SIZE + SKETCH_PADDING + VPAD;
      int COL = c * MATRIX_CELL_SIZE + SKETCH_PADDING + HPAD;
      
      noFill();
      stroke(#EEF2F3);
      rect(ROW, COL, MATRIX_CELL_SIZE, MATRIX_CELL_SIZE, MATRIX_CELL_CORNER);

      fill(#E0E4E5);
      for (int ur = 0; ur < MATRIX_CELL_UNITS; ur++) {
        for (int uc = 0; uc < MATRIX_CELL_UNITS; uc++) {
          rect(
              ROW + (ur * MATRIX_CELL_UNIT_SIZE * UNIT_SIZE),
              COL + (uc * MATRIX_CELL_UNIT_SIZE * UNIT_SIZE),
              MATRIX_CELL_UNIT_SIZE * UNIT_SIZE,
              MATRIX_CELL_UNIT_SIZE * UNIT_SIZE,
              MATRIX_CELL_CORNER
            );
        }
      }
    }
  }
  
  save("sample-matrix.png");
}
