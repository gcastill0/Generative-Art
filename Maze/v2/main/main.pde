Grid g; 
boolean running;
void setup() {
  size(1600, 900);
  strokeCap(PROJECT);
  noLoop();
  running = true;
  g = new Grid();

  while (!g.completed) {
    g.update();
  }
}

void draw() {
  background(255);
  g.render();
  g.drawBE();
}