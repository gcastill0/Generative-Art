float maxR = 50;

Circle newCircle() {
  float x = random(25,width-25);
  float y = random(25,height-25);
  float r = int((random(0.1,maxR)+random(0.1,maxR))/2);
  Circle c = new Circle(x,y,r);
  
  c.checkBounds();
  
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