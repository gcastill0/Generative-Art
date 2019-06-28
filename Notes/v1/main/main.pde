ArrayList<Box> boxes;

Box b;

void setup() {
  size(1600, 900);

  boxes = new ArrayList<Box>();
  
  float inc = width/5;
  float x = inc/5;
  float y = 700;

  for (int i = 0; i < 4; i++) {
    String s = "Hello World #"+i;
    boxes.add(new Box(s, x, y));
    x+=inc+inc/5;
  }

  background(0);
  stroke(#A9DAFF);
  fill(255);
  strokeWeight(10);
  textSize(tSize);    
  textAlign(CENTER, CENTER);
}

void draw() {

  boolean needsUpdate = false;

  for (Box b : boxes) {
    needsUpdate |= b.needsUpdate;
  }

  // First build the box

  if (needsUpdate) {
    background(52, 100, 136);
    for (Box b : boxes) {
      b.update();
      b.render();
    } 
    // Then play desired effect
    // One effect at a time,
    // Check when the effect is done
  } else {
    float i = height/(boxes.size()+1);
    float x ;
    float y = i/2;
    for (Box b : boxes) {
      x = width/2 - b.w/2;
      b.moveTo(x, y);
      y+=i;
    }
  }
}