PShape hexagon;
PImage img;
final int sides = 6;
final float r = 50;
final float alpha = radians(360/sides);

void setup() {
  size(1600, 900);

  hexagon = createShape();
  hexagon.beginShape();
  hexagon.noStroke();
  hexagon.fill(255, 20);

  float x = width/2;
  float y = height/2;

  for (float a = 0; a <= TWO_PI; a += alpha) {
    float p1x = x + cos(a) * (r-5);
    float p1y = y + sin(a) * (r-5);
    hexagon.vertex(p1x, p1y);
  }

  hexagon.endShape();

  img = loadImage("DD_background.png");  
  println(hexagon.getVertexCount());
}

void draw() {
  background(img);
  //  shape(hexagon, 0, 0);
  drawHexagon(mouseX, mouseY);
}

void drawHexagon(float x, float y) {
  
  float a = 0;
  for (int i = 0; i < hexagon.getVertexCount(); i++, a += alpha) {
    PVector v = hexagon.getVertex(i);
    v.x = cos(a) * (r-5);
    v.y = sin(a) * (r-5);
    hexagon.setVertex(i, v);
  }
  pushMatrix();
  translate(x,y);
  shape(hexagon, 0, 0);
  popMatrix();
}