Canvas canvas;
int stage;
int [] history;
int change;
boolean running;

void setup() {
  fullScreen();
  //size(1600, 900);
  canvas = new Canvas();
  stage = 0;
  change = 1;
  running = true;
}

void draw() {
  background(0);
  canvas.render();

  float mls = millis();

  if (mls%5000<50) tryNext();
}

void mouseClicked() {
  if (running) {
    noLoop();
    running = false;
    println("NOT running");
  } else if (!running) {
    loop();
    running = true;
    println("running");
  }
}

void keyPressed() {
  if (key == 0) {
    stage++;
  } else {
    stage--;
  }
}

void tryNext() {

  //stage = floor(random(5));
  print("Previous: ", stage);

  stage+=change;

  println("  Current: ", stage);
  println();

  if (stage == 5) {
    change=-change;
  } else if (stage == -1) {
    change=-change;
  }



  canvas.transition(stage);
}