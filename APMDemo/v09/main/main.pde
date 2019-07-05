ArrayList<PVector> points;
int nPoints;
float t, yoff, x, xoff, xmargin, avg;
PVector firstHighestP, secondHighestP;
boolean f, s, g;

import com.hamoid.*;
VideoExport videoExport;

void setup() {
  size(1280, 720);
  nPoints = 600;
  t = 0.01;
  points = new ArrayList<PVector>();
  xoff = width/nPoints;
  xmargin = (width - (xoff*nPoints))/2;
  x = 1;
  f = false;
  s = false;
  g = false;
  firstHighestP = new PVector(-100, height+1000);
  secondHighestP = new PVector(-100, -100);

  textAlign(RIGHT, CENTER);
  textSize(14); 

  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

void draw() {
  background(0);
  float cyoff = abs(firstHighestP.y - secondHighestP.y) * .25;

  if (points.size() >= nPoints*.75); 
  {
    float woff = (nPoints*.75 - points.size());
    translate(woff/2, 0);
  }

  stroke(#CCCCCC, 10);
  strokeWeight(3);
  noFill();

  for (int x = -25; x < (width/25)*2; x++) {
    for (int y = 0; y < (width/25); y++) {
      float woff = (width%40)/2;
      float hoff = (height%40)/2;
      rect(x*50 + woff, y*50 + hoff, 50, 50);
    }
  }

  if (points.size() < nPoints) {
    float y = map(noise(yoff), 1, 0, 50, height-50);
    PVector p = new PVector((x * xoff) + xmargin, y);
    points.add(p);
    x++;
  }

  yoff+= 0.0154321;

  avg = 0;
  for (int i = 0; i < points.size(); i++) {
    PVector p1 = points.get(i);
    avg+=p1.y;
  }

  avg /= points.size();

  for (int i = 0; i < points.size(); i++) {
    PVector p1 = points.get(i);

    if (firstHighestP.y > p1.y) {
      firstHighestP = p1;
    }

    PVector p2 = points.get(i);

    if (p2.y > firstHighestP.y && secondHighestP.y < p2.y) {
      secondHighestP = p2;
    }
  }

  // *****************
  for (int i = 0; i < points.size()-1; i++) {
    if ((i+1) < points.size() && points.get(i+1) != null) {
      //for (int ii = i+1; ii < points.size(); ii++) {
      PVector p1 = points.get(i);
      PVector p2 = points.get(i+1);


      fill(#5D83DC, 150);
      stroke(#5D83DC, 150);
      strokeWeight(15);

      if (p1.y < avg-cyoff || p1.y > avg+cyoff) {
        noFill();
        stroke(#F81897, 150);
        strokeWeight(15);
      } 

      if (p2.y < avg-cyoff || p2.y > avg+cyoff) {
        noFill();
        stroke(#F81897, 150);
        strokeWeight(15);
      } 

      line(p1.x, p1.y, p2.x, p2.y);
      point(p1.x, p1.y);
      point(p2.x, p2.y);
    }
  }

  noFill();
  stroke(#00FF00);
  strokeWeight(6);

  ellipse(firstHighestP.x, firstHighestP.y, 5, 5);
  ellipse(firstHighestP.x, firstHighestP.y, 25, 25);
  ellipse(secondHighestP.x, secondHighestP.y, 5, 5);
  ellipse(secondHighestP.x, secondHighestP.y, 25, 25);


  fill(255);
  stroke(#CCCCCC, 150);
  strokeWeight(6);

  line(0, avg, width*2, avg);
  text("Mean", width/2, avg-12);

  stroke(#CCCCCC, 50);
  strokeWeight(6);

  line(0, avg-cyoff, width*2, avg-cyoff*1.25);
  text("2 x STDEV", width/2, avg-cyoff*1.18);

  stroke(#CCCCCC, 50);
  strokeWeight(6);

  line(0, avg+cyoff, width*2, avg+cyoff*1.25);
  text("2 x STDEV", width/2, avg+cyoff*1.18);

  noFill();
  stroke(#00FF00, 150);
  strokeWeight(6);
  drawCurve(firstHighestP, secondHighestP);

  strokeWeight(2);

  line(firstHighestP.x, firstHighestP.y, firstHighestP.x, height -100);  
  line(secondHighestP.x, secondHighestP.y, secondHighestP.x, height -100);

  drawEvent(firstHighestP.x, firstHighestP.y);
  drawEvent(secondHighestP.x, secondHighestP.y);
  //}

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
  triangle.stroke(#00FF00, 100);
  triangle.fill(#00FF00, 150);
  triangle.vertex(x, height - 50);
  triangle.vertex(x - 25, height-25);
  triangle.vertex(x + 25, height-25);
  triangle.endShape();
  shape(triangle, 0, -50);

  //println(x, height-100);
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

  bezier(p1.x, p1.y, cpx1, cpy1, cpx2, cpy2, p2.x, p2.y);
}
