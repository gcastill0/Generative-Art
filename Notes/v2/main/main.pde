JSONObject json;
PImage img, imgBox, dd_logo;
PFont font;

import com.hamoid.*;
VideoExport videoExport;

// Test vars
int id;
String title, subtitle;
float duration;

// control var
int tSize;  // Text size

// x start of text, y start of text
// width of string, height of string
float tx, ty, sw, sh;
float o, ox;

// Animation variables
float x, x2, y, y2, dx, dy;
boolean oneTimeDelay, fadeIn, fadeOut;
float fadeInCounter, fadeOutCounter, delayCounter;

void setup() {

  // This:
  //
  json = loadJSONObject("titles.json");
  size(1600, 900);
  tSize = 64;
  oneTimeDelay = false;
  fadeIn = false;
  fadeOut = false;

  fadeInCounter = 50;
  fadeOutCounter = 0;
  delayCounter = 0;

  textSize(tSize);
  background(0);
  frameRate(60);

  // Or, this:
  //json = new JSONObject();

  //json.setInt("id", 0);
  //json.setString("Title", "Hello Work!");
  //json.setString("Subtitle", "The JSON");
  //json.setString("Duration", "5");

  id = json.getInt("id");
  title = json.getString("Title");
  subtitle = json.getString("Subtitle");
  duration = json.getFloat("Duration");

  font = loadFont("OpenSans-SemiBold-64.vlw");
  textFont(font, tSize);

  // Temporary calc variables
  sw = textWidth(title) * 1.5;
  sh = tSize * 2.5;

  textAlign(CENTER, CENTER);

  tx = width/2 - sw/2;
  ty = height/2 - sh/2;

  //saveJSONObject(json, "data/titles.json");

  x  = 0;
  x2 = 0;
  y  = 0;
  y2 = 0;

  o =  0;
  ox = 0;

  img = loadImage("DD_background.png");
  dd_logo = loadImage("dd_logo_v_w_rgb.png");
  imgBox = new PImage();

  dd_logo.resize(ceil(dd_logo.width*0.25), ceil(dd_logo.height*0.25));

  videoExport = new VideoExport(this);
  videoExport.startMovie();

  background(img);
  delay(1000);
  videoExport.saveFrame();
}

void draw() {
  background(img);
  image(dd_logo, floor(width/2) - dd_logo.width/2, floor(height/2));

  if (x == 0) delay(2000);

  dx = sw/(duration*frameRate);
  dy = sh/(duration*frameRate);
  ox = 255/(duration*frameRate);

  if (fadeInCounter < 255) {
    fadeInCounter+=((255*4)/(duration*frameRate));
    noStroke();
    fill(0, 255-fadeInCounter);
    rect(0, 0, width, height);
  } else if (fadeInCounter >= 255 && fadeIn == false) {
    fadeIn = true;
  } else 

  if (x < sw && y < sh && fadeIn == true) {
    x += dx;
    y += dy;
    o += 2.1;

    stroke(#E0A8FF, o);
    fill(#E0A8FF, o);
    rect(tx, ty+tSize-3, x, 3);
    rect(tx, ty-tSize, 50, y);

    println(x, y, o);

    stroke(255, o);
    fill(255, o);
    textFont(font, tSize);
    text(title, width/2, height/2-tSize);

    textSize(tSize/3);
    text(subtitle, width/2, height/2);
    
  } else if ((x >= sw || y >= sh) && oneTimeDelay == false) {
    stroke(#E0A8FF);
    fill(#E0A8FF);
    rect(tx, ty+tSize-3, x, 3);
    rect(tx, ty-tSize, 50, y);

    stroke(255, o);
    fill(255, o);
    textFont(font, tSize);
    text(title, width/2, height/2-tSize);

    textSize(tSize/3);
    text(subtitle, width/2, height/2);

    delayCounter+= (1/(duration*frameRate));
    if (delayCounter >= 1) oneTimeDelay = true;
    
  } else if (x2 < sw-50) {

    x2 += dx*8;

    stroke(255);
    fill(255);
    textSize(tSize);
    text(title, width/2, height/2-tSize);
    textSize(tSize/3);
    text(subtitle, width/2, height/2);

    stroke(#E0A8FF);
    fill(#E0A8FF);
    rect(tx, ty+tSize-3, x, 3);
    rect(tx+x2, ty-tSize, 50, y);

    imgBox =  img.get(floor(tx), floor(ty-tSize), ceil(x2), ceil(sh));
    image(imgBox, floor(tx), floor(ty-tSize));
  } else if (y2 <= sh ) { 

    y2 += dy*6;

    stroke(#E0A8FF);
    fill(#E0A8FF);
    rect(tx+x2, ty-tSize+y2, 50, y-y2);
  } else if (fadeOutCounter < 255) {
    fadeOutCounter+=((255*4)/(duration*frameRate));
    noStroke();
    fill(0, fadeOutCounter);
    rect(0, 0, width, height);
  } else {
    noStroke();
    fill(0, fadeOutCounter);
    rect(0, 0, width, height);
    exit();
  }

  videoExport.saveFrame();
  //  println(frameCount, frameRate);
}
