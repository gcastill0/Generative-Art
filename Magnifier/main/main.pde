PImage myImage;
PImage imgBox;

void setup() {
  size(1600, 900);
  myImage = loadImage("ga-2017-09-19-15-53-48-000014400.png");
}

void draw() {
  background(255);
  fill(0);
  rect(0, 0, width-height, height);
  rect(width-height, 0, height, height);
  image(myImage, width-height, 0);

  if (mouseX > (width-height+21) && mouseX < width-21 &&
      mouseY > 21 && mouseY < height-21) {

    imgBox = get(mouseX-20, mouseY-20, 40, 40);
    imgBox.resize(640, 640);
    image(imgBox, (width-height-imgBox.width)/2, (height/2)-320);

    noFill();
    rect(mouseX-20, mouseY-20, 40, 40);
  }

}
