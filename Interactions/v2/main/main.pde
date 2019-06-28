ArrayList<Connection> conn;
PVector s, t;
ArrayList<Icon> icon;
PImage img;

void setup() {
  size(1600, 900);

  conn = new ArrayList<Connection>();
  icon = new ArrayList<Icon>();

  s = new PVector(width*0.25, height*0.25);
  t = new PVector(width*0.75, height*0.75);

  img = loadImage("noun_78632.png");
  Icon i = new Icon(s,img);
  icon.add(i);

  img = loadImage("noun_195757.png");
  Icon ii = new Icon(t,img);
  icon.add(ii);

  
  Connection c = new Connection();
  c.setSource(s);
  c.setDestination(t);  
  c.calculatePath();

  conn.add(c);

  fill(255);
  noStroke();
}

void draw() {
  background(0);

  for (Connection c : conn) {
    c.update();
    c.render();
  }
  
  for (Icon i : icon) {
    i.render();
  }
}