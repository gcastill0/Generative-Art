ArrayList<Connection> conn;
PVector s, t;

void setup() {
  size(1600, 900);

  conn = new ArrayList<Connection>();

  float x = random(width);
  float y = random(height);

  for (int i = 0; i < 10; i++) {
    Connection c = new Connection();

    s = new PVector(x, y);
    x = random(width);
    y = random(height);
    t = new PVector(x, y);

    c.setSource(s);
    c.setDestination(t);  
    c.calculatePath();

    conn.add(c);
  }

  fill(255, 0, 255);
  noStroke();
}

void draw() {
  background(0);

  for (Connection c : conn) {
    c.update();
    c.render();
  }
}