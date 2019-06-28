
class TextBox {
  String t;
  Box b;
  float x, y;
  float w, h;

  TextBox(String s, float x, float y) {    

    this.t = s;
    this.w = textWidth(this.t);
    this.h = tSize+tBuff;
    this.b = new Box(x, y, w+tBuff, tSize+tBuff);
    this.x = x+(w+tBuff)/2;
    this.y = y+(tSize+tBuff)/2;
  }

  void update() {
    this.b.update();
  }

  void render() {
    this.b.render();
    textSize(tSize);    
    textAlign(CENTER, CENTER);
    text(this.t, this.x, this.y);
    //text("Hello World!", 100, 100);
  }
  
  void moveTo(float dx, float dy) {
    this.b.moveTo(dx,dy);
  }
}