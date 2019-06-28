ArrayList<Circle> circles;
int max = 5000;
int maxRadius = int(max/500);

Circle master;

void setup() {
  fullScreen();
  circles = new ArrayList<Circle>();
  master  = new Circle(width/2,height/2,(height-maxRadius*2)/2-maxRadius);
  
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

Circle newCircle() {
  float x = random(maxRadius,width-maxRadius);
  float y = random(maxRadius,height-maxRadius);
  float d = dist(x,y,master.x,master.y);
  float r =  maxRadius - map(d,0,master.r,0,maxRadius);
  Circle c = new Circle(x,y,r);
  
  if (!collision(c,master)) return null;
  
  for (Circle cc: circles) {
    if (collision(c, cc) || !c.isGrowing) return null;
  }
  
  return c;
}

boolean collision(Circle c, Circle cc) {
  float d = dist(c.x, c.y, cc.x, cc.y);
  if (d < c.r + cc.r + 4) return true;   
  return false;
}