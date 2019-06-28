ArrayList<Circle> circles;
int max = 7000;

void setup() {
  fullScreen(P3D);
  circles = new ArrayList<Circle>();
  
  int i = 0; 
  while (i < max) {  
    Circle c = newCircle();
    if (c == null) continue;
    circles.add(c);   
    i++;
  }
}

void draw() {
  background(0);
  for (Circle c: circles) {
    for (Circle cc: circles) {
      if (c == cc || !c.isGrowing) continue;
      if (collision(c,cc)) {
        c.isGrowing = false;
        cc.isGrowing = false;
      }
    }
    c.render();
    c.grow();
  }
}