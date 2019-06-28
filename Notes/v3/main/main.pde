PFont light, lightItalic, normal, normalItalic, bold, boldItalic, black; 

Attributes textAttributes;
Title text;

void setup() {
  size(1280,720);

  light         = createFont("Frutiger-Light", 100);
  lightItalic   = createFont("Frutiger-LightItalic", 100);
  normal        = createFont("Frutiger", 100);
  normalItalic  = createFont("Frutiger-Italic", 100);
  bold          = createFont("Frutiger-Bold", 100);
  boldItalic    = createFont("Frutiger-BoldItalic", 100);
  black         = createFont("Frutiger-UltraBold", 100);
  
  text = new Title(width/4, height/2, "Hello Work");
}

void draw() {
  background(255);
  text.render();
  text.update();
  if (!text.isMoving) text.moveTo(width*.75,height/2);
  fill(255);
  noStroke();
  rect(0,0,width/2,height);
}

class Attributes {
  float s;
  String f;
  color c;
}

class Title{
  PVector l;
  PVector d;
  String  t;
  boolean isMoving;
  
  Title(float x, float y, String t) {
    this.l = new PVector(x,y);
    this.d = new PVector(x,y);
    this.t = t;
    this.isMoving = false;
  }
  
  void moveTo(float x, float y) {
    if (!this.isMoving) {
      this.d = new PVector(x,y);
      isMoving = true;
    }
  }
  
  void update() {
    float d = PVector.dist(this.l,this.d);
    if (abs(d) <= 0.25) {
      this.isMoving = false;
    }
    if (!this.isMoving) return;
    this.l = PVector.lerp(this.l, this.d, 0.075);
  }
  
  void render() {
    fill(0);
    textSize(48);
    textAlign(CENTER);
    textFont(black);
    text(this.t, this.l.x, this.l.y);
  }
}
