Circle newCircle() {
  float x = random(0,width);
  float y = random(0,height);
  float r = random(0,50);
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