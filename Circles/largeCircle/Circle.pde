int lineWeight = 2;
//color [] rgb = {#B2D4EF, #80B3DA, #5894C2, #3977A7, #206396} ;
color [] rgb = {#FFDDDD, #FFC4C4, #FFA8A8, #EC8080, #CF5656} ;

class Circle {
  float x, y, z, r;
  boolean isGrowing;
  color c;
  
  Circle(float _x, float _y, float _r) {
    this.x = _x;
    this.y = _y;
    this.r = _r;
    this.isGrowing = true;
    this.c = rgb[int(random(rgb.length))]; 
  }
  
  void render() {
    fill(c);
    strokeWeight(lineWeight);
    stroke(0, 153);    
    ellipse(x,y,r*2,r*2);
  }
  
  void grow() {
    this.checkBounds();
    if (this.isGrowing) this.r += 0.1;
  }
  
  void checkBounds() {
    if (this.x - this.r/2 <= lineWeight || this.x + this.r/2 >= width - lineWeight  ||
        this.y - this.r/2 <= lineWeight || this.y + this.r/2 >= height - lineWeight )
        this.isGrowing = false;
  }    
}