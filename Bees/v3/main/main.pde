import com.hamoid.*;
VideoExport videoExport;


ArrayList<Point> points;
PVector tester;
int nPoints = 6;
float nDist = 0.01;
float dist = 100;
int iPoint = 1;
float angle = 360/nPoints;
float cStep, rStep, bStep, gStep;

void setup() {
  size(900, 900);
  background(0);
  fill(0);
  frameRate(60);

  points = new ArrayList<Point>();

  for (int i=0; i < nPoints; i++) {
    float x = 0; 
    float y = 0;

    float px = x + (cos(radians(angle)) - sin(radians(angle))) * (width/4-50);
    float py = y + (sin(radians(angle)) - cos(radians(angle/10))) * (height/4-50);

    points.add(new Point(px, py));    
    angle += 360/nPoints;
  }

  for (int i=0; i < nPoints; i++) {
    float x = 0; 
    float y = 0;

    float px = x + cos(radians(angle)) * (width/3-50);
    float py = y + sin(radians(angle)) * (height/3-50);

    points.add(new Point(px, py));    
    angle += 360/nPoints;
  }


  for (int i=0; i < nPoints; i++) {
    float x = 0; 
    float y = 0;

    float px = x + (cos(radians(angle)) + sin(radians(angle))) * (width/4-50);
    float py = y + (sin(radians(angle)) + cos(radians(angle/20))) * (height/4-50);

    points.add(new Point(px, py));    
    angle += 360/nPoints;
  }

  tester = new PVector((points.get(0)).getX(), (points.get(0)).getY());
  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

void draw() {
  //  background(255);
  fill(0, 50);
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);


  dist = tester.dist((points.get(iPoint)).getLocation());

  if (dist > nDist) {

    pushMatrix();

    cStep = 255/points.size();

    rStep = 200;
    bStep = 50;
    gStep = 0;

    for (int i = 0; i < nPoints; i++) {

      PShape s;
      s = createShape();

      rotate(radians(angle));
      tester.lerp((points.get(iPoint)).getLocation(), 0.03);

      color c = color(rStep, bStep, gStep);

      rStep += cStep;
      bStep += cStep;
      gStep += cStep;

      rStep %= 255;
      gStep %= 255;
      bStep %= 255;

      stroke(c, 30);
      fill(c, 50);

      s.beginShape();
      s.stroke(c, 10);
      s.fill(c, 10);
      s.vertex(tester.x, tester.y);
      s.vertex(-75, -150);
      s.vertex(75, 150);
      s.endShape();
      shape(s, 0, 0);


      line(tester.x, tester.y, -75, -150);
      line(-75, -150, 75, 150);
      line(75, 150, tester.x, tester.y);

      ellipse(tester.x, tester.y, 10, 10);
    }


    popMatrix();
  } else if (iPoint < points.size()-1) {
    iPoint++;
    if (iPoint == 1) exit();
  } else { 
    iPoint = 0;
  }

  println(frameCount, frameRate, points.size(), nPoints, iPoint);
  videoExport.saveFrame();
}