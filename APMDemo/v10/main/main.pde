ArrayList<PVector> points;
int nPoints;
float t, yoff, x, xoff, xmargin, avg;
PVector firstHighestP, secondHighestP;
boolean f, s, g;
float woff, hoff;

import com.hamoid.*;
VideoExport videoExport;

void setup() {
  size(1280, 720);
  nPoints = 300;
  t = 0.01;
  points = new ArrayList<PVector>();
  xoff = width/nPoints;
  xmargin = (width - (xoff*nPoints))/2;
  x = 1;
  f = false;
  s = false;
  g = false;
  avg = 0;
  firstHighestP = new PVector(-100, -100);
  secondHighestP = new PVector(-100, -100);
  woff = (width%50)/2;
  hoff = (height%50)/2;

  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

void draw() {
  background(0);
  float cyoff = abs(firstHighestP.y - secondHighestP.y) * .25;

  stroke(#CCCCCC, 10);
  strokeWeight(3);
  noFill();

  for (int x = 0; x < (width/50); x++) {
    for (int y = 0; y < (width/50); y++) {
      rect(x*50 + woff, y*50 + hoff, 50, 50);
    }
  }

  if (points.size() < nPoints) {
    float y = map(noise(yoff), 0, 1, 0, height);
    PVector p = new PVector((x * xoff) + xmargin, y);
    points.add(p);
    x++;
  }


  for (int i = 0; i < points.size()-2; i++) {
    if ((i+1) < points.size()-1 && points.get(i+1) != null) {
      //for (int ii = i+1; ii < points.size(); ii++) {

      if (i % 2 == 0) {
        stroke(#FFCDA4, 50);
        fill(#FFCDA4, 50);
        strokeWeight(1);
      } else if (i % 3 == 0) {
        stroke(#FFB170, 50);
        fill(#FFB170, 50);
        strokeWeight(1);
      } else if (i % 5 == 0) {
        stroke(#FF7400, 50);
        fill(#FF7400, 50);
        strokeWeight(1);
      } else {
        stroke(#D96200, 50);
        fill(#D96200, 50);
        strokeWeight(1);
      }

      PVector p1 = points.get(i);
      PVector p2 = points.get(i+1);      
      rect(p1.x, p1.y, p2.x-p1.x, height-600-p2.y);
      rect(p1.x, p1.y, p2.x-p1.x, height-500-p2.y);
    }
  }

  yoff+= 0.05;

  noFill();
  stroke(#FF5858);
  strokeWeight(6);

  if (points.size() >= nPoints && f == false) {
    firstHighestP = new PVector(0, height);
    for (PVector p : points) {
      if (p.y < firstHighestP.y) {
        firstHighestP = p;
      }
    }
    f = true;
  }

  if (points.size() >= nPoints && s == false) {
    avg = 0;
    secondHighestP = new PVector(0, height);
    for (PVector p : points) {
      if (p.y < secondHighestP.y && p.y > firstHighestP.y && p.x > (firstHighestP.x+(xoff*50))) {
        secondHighestP = p;
        avg += p.y;
      }
    }
    avg /= points.size();
    s = true;
  }

  noFill();
  stroke(#FF0000);
  strokeWeight(6);
  
  ellipse(firstHighestP.x, firstHighestP.y, 5, 5);
  ellipse(firstHighestP.x, firstHighestP.y, 25, 25);
  ellipse(secondHighestP.x, secondHighestP.y, 5, 5);
  ellipse(secondHighestP.x, secondHighestP.y, 25, 25);

  if (f == true && s == true) {

    noFill();
    stroke(#00FFFF, 150);
    strokeWeight(6);
  }

  //**** **** **** **** **** **** **** **** **** ****
  //filter(INVERT);
  videoExport.saveFrame();
  if (frameCount >= (30*30)) exit();
  //**** **** **** **** **** **** **** **** **** ****
}

void drawEvent(float x, float y) {
  PShape triangle;
  triangle = createShape();
  triangle.beginShape();
  triangle.stroke(#00FFFF, 150);
  triangle.fill(#00FFFF, 100);
  triangle.vertex(x, height - 50);
  triangle.vertex(x - 25, height-25);
  triangle.vertex(x + 25, height-25);
  triangle.vertex(x, height - 50);
  triangle.endShape();
  shape(triangle, 0, -50);
}

class Bar {

  float h;
  float x;

  Bar(float x, float y) {
    this.x = x;
    this.h = y;
  }

  void update() {
  }

  void render() {
    rect(this.x - 50, this.h - 50, 100, height-this.h);
  }
}

void drawCurve(PVector p1, PVector p2) {
  float cx  = (p1.x + p2.x)/2;
  float cy  = (p1.y + p2.y)/2;
  float lab = sqrt(sq(cx-p2.x) + sq(cy-p2.y));

  float cpx1 = (cx+p1.x)/2;
  float cpy1 = (cy+p1.y)/2-lab*0.75;
  float cpx2 = (cx+p2.x)/2;
  float cpy2 = (cy+p2.y)/2-lab*0.75;

  float ai   = degrees(atan((cpy1-p1.y)/(cpx1-p1.x)));
  float labi = sqrt(sq(cpx1-p1.x)+sq(cpy1-p1.y))/4;
  float bi   = ai + 90.0;

  cpx1 = cpx1 + labi * cos(bi*PI/180);
  cpy1 = cpy1 + labi * sin(bi*PI/180); 

  float aii   = degrees(atan((cpy2-p2.y)/(cpx2-p2.x)));
  float labii = sqrt(sq(cpx2-p2.x)+sq(cpy2-p2.y))/4;
  float bii   = aii + 90.0;

  cpx2 = cpx2 + labii * cos(bii*PI/270);
  cpy2 = cpy2 + labii * sin(bii*PI/270); 

  bezier(p1.x, p1.y, cpx2, cpy2, cpx1, cpy1, p2.x, p2.y);
}
