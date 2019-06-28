Grid g; 
boolean running;
void setup() {
  size(800, 800);
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