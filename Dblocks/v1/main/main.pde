float ax, ay, dx, dy;
float g, dg;


void setup() {
  size(1600, 900, P3D);
  //noLoop();
  strokeWeight(2);
  stroke(0, 10);
  //noStroke();
  
  ax = radians(15.0);
  ax = radians(15.0);
  dx = 0.001;
  dy = 0.001;
  g = 25.0;
  dg = 0.1;
}

void draw() {
  background(255);

  directionalLight(95, 26, 126, 0, 0, -1);
  ambientLight(85, 185, 200);

  if (ax > radians(25.0) || ax < radians(-15.0)) dx *= -1;
  if (ay > radians(15.0) || ay < radians(-15.0)) dy *= -1;

  //  translate((width*.25 + (3 * 75))/2, height/6);

  //rotateX(-ax);
  //rotateY(-ay);
  //rotateZ(-ax);

  ax += dx;
  ay += dy;

  if (g < 25.0 || g > 51.0) dg *= -1;
  g += dg;

  float x1 = width/2 - (100*5)/2;
  float y1 = height/2 - (100*3)/2;

  for (int h = 0; h < 3; h++) {
    for (int j = 3; j > 0; j--) {
      for (int i = 0; i < 5; i++) {
        pushMatrix();
        float x = x1 + (i*100) + 50;
        float y = y1 + (h*100) + 50;
        float z = -100 + (j*100) + 50;

        translate(x, y, z);
        box( g * 2, 50, 50 );
        box( 50, g * 2, 50    );
        box( 50, 50, g * 2);
        popMatrix();
        //println(g, x);
      }
    }
  }
}
