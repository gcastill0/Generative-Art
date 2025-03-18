PImage myImage;
int RES = 128;
String image_name;

void setup() {
  size(3840, 3840);
  image_name = "background-circle-00";
  myImage = loadImage(image_name + ".png");
  myImage.resize(width, height);
  image(myImage, 0, 0);

  loadPixels();

  for (int row = 0; row < height; row+=RES)
    for (int col = 0; col < width; col+=RES) {
      //int idx = row * width + col;
      //color r = pixels[idx] >> 16 & 0xFF ;
      //color g = pixels[idx] >>  8 & 0xFF ;
      //color b = pixels[idx]       & 0xFF ;
      //println(row, col, idx, r, g, b);
      displayNeighbours(row, col);
    }

  updatePixels();

  noLoop();
}

void draw() {
  //drawGrid();
  save(image_name + "_alt.png");
}

void displayNeighbours(int row, int col) {
  println();
  int loops = 0;
  int rsum = 0;
  int gsum = 0;
  int bsum = 0;

  for (int r = 0; r < RES; r++) {
    for (int c = 0; c < RES; c++) {
      int idx = (r + row) * width + (c + col);
      if (idx >= (width * height)) continue;

      color rr = pixels[idx] >> 16 & 0xFF ;
      color gg = pixels[idx] >>  8 & 0xFF ;
      color bb = pixels[idx]       & 0xFF ;

      //if (rr == 255) rr = 34;
      //if (gg == 255) gg = 34;
      //if (bb == 255) bb = 34;

      rsum += (int)rr;
      gsum += (int)gg;
      bsum += (int)bb;

      loops++;
    }
  }

  for (int r = 0; r < RES; r++) {
    for (int c = 0; c < RES; c++) {
      int idx = (r + row) * width + (c + col);
      if (idx >= (width * height)) continue;
      pixels[idx] = color(rsum/loops, gsum/loops, bsum/loops);
    }
  }
}

void drawGrid() {
  noFill();
  strokeWeight(1);
  stroke(#CCCCCC,10);
  for (int r = 0; r < width; r+=RES) {
    for (int c = 0; c < height; c+=RES) {
      rect(r,c,RES,RES,2);
    }
  }
}
