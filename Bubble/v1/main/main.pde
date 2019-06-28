PShape s;
float xoff = 0.0;
float yoff = 0.0;

void setup() {
  size(1600, 900);
  frameRate(5);
  stroke(#FFFF00,5);
  strokeWeight(10);

  s = createShape();
  s.beginShape();
  s.stroke(255, 0, 0, 50);
  s.fill(255, 0, 0, 50);

  xoff+=0.0;

  for (float i = 0.0; i < TWO_PI; i+=0.01) {
    float r = height * 0.35 + map(noise(xoff + yoff), -1, 1, -50, 50);
    float x = cos(i) * r;
    float y = sin(i) * r;
    xoff+=0.01;
    s.vertex(x, y);
  }

  s.endShape(CLOSE);
  println(s.getVertexCount());
}

void draw() {
  background(0);
  translate(width/2, height/2);

  xoff+=0.0;
  float a = 0.0;

  for (int i = 0; i < s.getVertexCount(); i++, a+=0.01, xoff+=0.01) {
    PVector v = s.getVertex(i);
    float r = height * 0.35 + map(noise(xoff, yoff), -1, 1, -150, 150);       
    v.x = random(-1,1) + cos(a) * r;
    v.y = random(-1,1) + sin(a) * r;
    s.setVertex(i, v);

    int ii = (i+(s.getVertexCount()/4))%s.getVertexCount();   
    PVector v2 = s.getVertex(ii);
    //v2.x = cos(a) * r;
    //v2.y = sin(a) * r;
    //s.setVertex(ii, v2);

    line(v.x, v.y, v2.x, v2.y);

    //println(i, (i+(s.getVertexCount()/3))%s.getVertexCount());
  }

  s.rotate(yoff%TWO_PI);
  shape(s);
  filter(BLUR, 6);

  yoff+=0.1;
  //noLoop();
}