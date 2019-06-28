int rows, cols;
float alpha, beta, gamma;

void setup() {
  size(1600, 900, P3D);
  background(255);
  stroke(0, 100);
  rows = int((height/2)/100);
  cols = int((width/2)/100);
  alpha = beta = gamma = 0.0;
}

void draw() {

  translate(width/4, height/4);
  
  gamma += 0.001;
  rotateZ(gamma);

  for (int c = 0; c < cols; c++) {
    for (int r = 0; r < rows; r++) {
      float x = c * 100;
      float y = r * 100;
      rect(x, y, 100, 100);  
    }
  }
}
