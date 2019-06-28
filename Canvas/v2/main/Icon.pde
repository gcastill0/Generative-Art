class Icon {
  PImage icon;
  float x, y;
  float size;
  String note;

  Icon(float x, float y, String img) {
    this.x = x;
    this.y = y;
    this.icon = loadImage(img);
    this.note = "Hello Work!";
  }

  Icon(float x, float y, PImage img) {
    this.x = x;
    this.y = y;
    this.icon = img;
    this.note = "Hello Work!";
  }
  
  Icon(float x, float y) {
    this.x = x;
    this.y = y;   
    this.note = "Hello Work!";
  }


  void update(float x, float y) {
    this.x = x;
    this.y = y;   
  }

  void update(float x, float y, float w, float h) {
    this.x = (x + x + w)/2-150;
    this.y = (y + y + h)/2-150;   
  }
  
  void render() {
    //stroke(255, 50);
    //fill(0,200);    
    //rect(this.x, this.y, 300, 300, 5);
    this.icon.resize(300,300);
    image(this.icon, this.x, this.y);
    textSize(16);
    textAlign(CENTER, CENTER);
    fill(255);
    text(this.note, this.x+150, this.y+275);
  }
}