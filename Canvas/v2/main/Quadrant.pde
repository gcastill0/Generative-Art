class Quadrant {
  float x, y, w, h;
  float tx, ty, tw, th;
  boolean inTransition = false;
  float ease = 0.1;
  Icon icon;

  Quadrant(float x, float y, float w, float h) {   
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    this.icon = new Icon(this.x, this.y);
  }

  void set(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void transitionTo(float x, float y, float w, float h) {
    this.tx = x; 
    this.ty = y; 
    this.tw = w; 
    this.th = h;

    this.inTransition = true;
  }

  void update() {
    if (this.inTransition) {
      float dist = sqrt(sq(this.tx - this.x) + sq(this.ty - this.y));

      float dx = this.tx - this.x;
      float dy = this.ty - this.y;
      float vx = dx * this.ease;
      float vy = dy * this.ease;

      float dw = this.tw - this.w;
      float dh = this.th - this.h;
      float vw = dw * this.ease;
      float vh = dh * this.ease;

//      if (abs(dw - this.tw) > 1 && abs(dh - this.th) > 1) this.inTransition = false;

      this.x += vx;
      this.y += vy;
      if (abs(dw - this.tw) > 1) this.w+=vw;
      if (abs(dh - this.th) > 1) this.h+=vh;
    }
  }

  void render() {
    strokeWeight(20);
    stroke(255, 5);
    fill(0,50);
    rect(this.x, this.y, this.w, this.h);
    
    this.icon.update(this.x, this.y, this.w, this.h);
    this.icon.render();
  }
}