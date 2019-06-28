float x, y, a;
int i, pi_inc, inc, linc;

void setup() {
  size(900, 900);
  frameRate(60);
  a = 0.0;
  x = 0.0;
  y = 0.0;
  i = 0;
  inc = 1;
  linc = 1;
  pi_inc = 1;
  background(#000000);
}

void draw() {
  //fill(#000000, 20);
  //noStroke();
  //rect(0, 0, width, height);
  //background(#000000);

  translate(width/2, height/2);
  rotate(a);


  if (linc >= 3) pi_inc *= -1;

  if (inc == -1 && x <= 0) {
    linc+= pi_inc;
    x = 0;
    y = 0;
    inc = 1;
  } 

  if (linc < 0) exit();

  if (x > 100 || x < 0) {
    inc *= -1;
  }


  y+= ((sin(radians(a))) * inc);
  x+= 0.1 * inc;
  a+= 0.05 * inc;
  i++;

//  filter(BLUR);

  for (float angle = 0.0; angle < TWO_PI; angle+=PI/linc) {
    pushMatrix();

    rotate(angle);
    stroke(#00FFFF, 25);
    fill(#000000, 50);
    ellipse(x, y, 60, 60);
    ellipse(x-10, y-10, 50, 50);
    ellipse(x-10, y+10, 50, 50);
    ellipse(x+10, y-10, 50, 50);
    ellipse(x+10, y+10, 50, 50);
    fill(#055A5A, 25);
    ellipse(x, y, 50, 50);

    rotate(angle);
    stroke(#00FFFF, 25);
    fill(#055A5A, 25);
    ellipse(x, y, 50, 50);

    rotate(angle);
    noStroke();
    fill(#FF7070, 25);
    ellipse(x, y, 25, 25);

    rotate(angle);
    noStroke();
    fill(#FF7070, 25);
    ellipse(x, y, 50, 50);

    popMatrix();
  }

  println(i, linc, "Angle:",a, x, y);
}