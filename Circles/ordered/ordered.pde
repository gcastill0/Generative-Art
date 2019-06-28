ArrayList<Circle> circles;
long iters;

void setup() {
  fullScreen(P3D);
  int startTime = millis();
  circles = new ArrayList<Circle>(); 
  newCircle();
  int ellapsedTime = millis() - startTime;
  println(iters, ellapsedTime/1000);
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

void newCircle() {
  float x = width/2;
  float y = height/2;
  float r = 50;
  
  Circle c = new Circle(x,y,r);
  circles.add(c);
  
  for (float rr = r; rr < width && r >= 0; rr+=0.01, r-=0.001) {
    
    iters++;
  
    for (int a = 0; a < 360; a+=1) {
      
      iters++;
      
      float xx = x + sin(a*PI/180) * rr;
      float yy = y + cos(a*PI/180) * rr;
      boolean valid = true;
            
      Circle cc = new Circle(xx,yy,r);
      
      for (Circle ccc: circles) {
        iters++;
        if (collision(cc,ccc)) {
          valid = false;
          break;
        }
      }
      
      if (valid) circles.add(cc);
    }
  }
}

boolean collision(Circle c, Circle cc) {
  float d = dist(c.x, c.y, cc.x, cc.y);
  if (d < c.r + cc.r + 5) return true;   
  return false;
}

int lineWeight = 2;
//color [] rgb = {#B2D4EF, #80B3DA, #5894C2, #3977A7, #206396} ;
//color [] rgb = {#A9DAFF, #79C5FF, #1097FF, #004F8B, #003D6B} ;
color [] rgb = {#FFDDDD, #FFC4C4, #FFA8A8, #EC8080, #CF5656} ;
//color [] rgb = {#FFCDA4, #FFB170, #FF7400, #D96200, #A74C00} ;

class Circle {
  float x, y, z, r;
  boolean isGrowing;
  color c;
  
  Circle(float _x, float _y, float _r) {
    this.x = _x;
    this.y = _y;
    this.r = _r;
    this.isGrowing = true;
    this.c = rgb[int((random(rgb.length)+random(rgb.length)+random(rgb.length))/3)]; 
  }
  
  void render() {
    pushMatrix();
    translate(this.x,this.y,this.r);
    noStroke();
    lights();
    fill(c);
    //stroke(155, 200);    
    //ellipse(x,y,r*2,r*2);
    sphere(this.r);
    popMatrix();
  }
  
  void grow() {
    this.checkBounds();
    if (this.isGrowing) this.r += 0.1;
  }
  
  void checkBounds() {
    if (this.x - this.r/2 <= -width  + lineWeight || this.x + this.r/2 >= width*2 - lineWeight  ||
        this.y - this.r/2 <= -height + lineWeight || this.y + this.r/2 >= height*2 - lineWeight )
        this.isGrowing = false;
  }
}