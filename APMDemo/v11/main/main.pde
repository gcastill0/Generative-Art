ArrayList<PVector> points;
float xoff, yoff;
float a;
String t;

import com.hamoid.*;
VideoExport videoExport;

void setup() {
  size(1280, 720);
  textSize(64);
  textAlign(CENTER);

  a = 0;
  t = "";
  yoff = 0.001;
  videoExport = new VideoExport(this);
  videoExport.startMovie();
}

void draw() {


  background(0);

  float x1, x2;
  float y1, y2;

  stroke(#FFFFFF, 150);
  strokeWeight(8);
  fill(#FF0000, 150);
  arc(width/2, height/2, 600, 600, radians(180), radians(225), PIE);
  fill(#FF7400, 150);
  arc(width/2, height/2, 600, 600, radians(225), radians(270), PIE);
  fill(#FFFF00, 150);
  arc(width/2, height/2, 600, 600, radians(270), radians(315), PIE);
  fill(#00FF00, 150);
  arc(width/2, height/2, 600, 600, radians(315), radians(360), PIE);


  a = radians(map(noise(yoff), 0, 1, 200, 360));
  println(yoff, a);
  yoff+= 0.005125;

  stroke(#000FFF, 150);
  strokeWeight(14);
  //  float a = radians(random(180, 360));
  float x = width/2 + cos(a) * 300;
  float y = height/2 + sin(a) * 300;
  line(width/2, height/2, x, y);

  stroke(#000000);
  strokeWeight(8);
  fill(#000000);
  ellipse(width/2, height/2, 400, 400);

  stroke(#FFFFFF, 175);
  strokeWeight(8);
  noFill();
  arc(width/2, height/2, 400, 400, radians(180), radians(360));

  if (frameCount%30 == 0) {
    t = ""+round(x);
  }

  fill(#FFFFFF);
  text(t, width/2, height/2);

  //**** **** **** **** **** **** **** **** **** ****
  //filter(INVERT);
  videoExport.saveFrame();
  if (frameCount >= (30*60)) exit();
  //**** **** **** **** **** **** **** **** **** ****
}
