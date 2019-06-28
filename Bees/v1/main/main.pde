import com.hamoid.*;
VideoExport videoExport;

//PVector p;
//ArrayList<Point> bees;
//ArrayList<PVector> points;
//int nPoints;
//float a, ainc, len;

Path path;

void setup() {
  size(800, 800);
  background(0,0,0);
  stroke(255, 0, 0);
  frameRate(60);
  
  path = new Path();
  path.setNumberOfBees(24);

  //nPoints = 120;
  //a = 0;
  //ainc = 360/nPoints;
  //len = (width/2 + height/2) / 3;

  //float midx = width/2;
  //float midy = height/2;

  //points = new ArrayList<PVector>();
  //bees = new ArrayList<Point>();

  //for (int i=0; i < nPoints; i++) {

  //  float x = midx + (cos(radians(a))) * len;
  //  float y = midy + (sin(radians(a))) * len;

  //  PVector np = new PVector(x, y);
  //  points.add(np);


  //  a+= ainc;

  //  x = midx + cos(random(-PI,PI)) * len;
  //  y = midy + sin(random(-PI,PI)) * len;

  //  Point p = new Point(x, y);
  //  bees.add(p);
  //}

  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

void draw() {
  noStroke();
  fill(0,0,0, 10);
  rect(0, 0, width, height);
  
  path.update();
  path.render();

  //if (bees.get(nPoints-1).moveCompleted()) {
  //  videoExport.endMovie();
  //  exit();
  //}

  //for (int i=0; i < nPoints; i++) {
  //  PVector p = points.get(i);
  //  Point b = bees.get(i);

  //  b.moveTo(p);
  //  b.update();
  //  b.render();
  //}
  
  videoExport.saveFrame();
}