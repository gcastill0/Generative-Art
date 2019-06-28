final int sides = 6;
final float r = 100;
final float alpha = radians((360)/sides);
int looper = 0;

color [] rgb = {  #F3F7FE, #9FB9F6, #6490F3, #2E6AF3, 
                  #B6C7F0, #FF5858, #85A0DD, #5F7EC6,
                  #4061AD, #9FB9F6, #6490F3, #2E6AF3
                } ;
int h_id;

PVector p1;

ArrayList<Hexagon> hList;

void setup() {
  size(3168, 798);
//  fullScreen();
  background(#2d2d2f);
  noLoop();
  
  hList = new ArrayList<Hexagon>();

  float nx = floor(width/r);
  float ny = floor(height/(sin(alpha) * r * 2));

  float ix = (width - (nx * r))/2;
  float iy = (height - (ny * sin(alpha) * r * 2))/2;
  
  for (int x = int(ix), _x=0; x < width; x+=r, _x++) {
    for (int y = int(iy), _y=0 ; y < height; y+=sin(alpha) * r * 2, _y++) {
      if (x > 0 && y > 0 && x < width && y < height) {
          if (_x%2==0 && _y%2==1) {
              hList.add(new Hexagon(x,y));
          } else if (_x%2==1 && _y%2==0) {
              hList.add(new Hexagon(x,y));
          }
      }
    }
  }
}

void draw() {
  for (Hexagon h: hList) {
    h.render();
  }

  saveFrame("line-######.png");
}
