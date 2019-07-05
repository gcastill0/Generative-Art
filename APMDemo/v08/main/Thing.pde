class Thing {
  PShape thing;
  PVector l;
  int ttl = 0;
  int ttd = (30*60)-frameCount - 30 - 255;
  int phase = 1;
  float alpha = 0.0;
  int type;

  Thing(PVector l) {
    this.l     = l;
    this.thing = this.createThing(this.l);
    this.type = 0;
  }

  Thing(PVector l, float p) {
    this.l     = l;
    this.thing = this.createThing(this.l, p);
    this.type = 1;
  }

  Thing(PVector l1, PVector l2) {
    this.thing = this.createThing(l1, l2);
    this.type = 2;
  }

  PShape createThing(PVector l) {
    PShape cross1, cross2, shadow, border, thingie;
    ArrayList<PShape> things;
    things = new ArrayList<PShape>();

    cross1 = this.createThing(new PVector(l.x - CELL/3.42, l.y - CELL/3.42), new PVector(l.x + CELL/3.42, l.y + CELL/3.42));
    cross2 = this.createThing(new PVector(l.x + CELL/3.42, l.y - CELL/3.42), new PVector(l.x - CELL/3.42, l.y + CELL/3.42));

    shadow = createShape(RECT, l.x - CELL/3.25, l.y - CELL/3.25, CELL/1.62, CELL/1.62);
    shadow.setStrokeWeight(5);
    shadow.setStroke(#FFFFFF);
    shadow.setStrokeJoin(ROUND);

    border = createShape(RECT, l.x - CELL/3.42, l.y - CELL/3.42, CELL/1.76, CELL/1.76);
    border.setStrokeWeight(3);
    border.setStroke(#CCCCCC);
    border.setStrokeJoin(ROUND);

    things.add(createThing(l, 4));

    for (float r = TWO_PI/4/2; r <= TWO_PI; r+=TWO_PI/4) {
      float x = l.x + cos(r) * CELL/3;
      float y = l.y + sin(r) * CELL/3;
      things.add(createThing(new PVector(x, y), 4));
    }

    thingie = createShape(GROUP);
    thingie.addChild(shadow);
    thingie.addChild(border);
    thingie.addChild(cross1);
    thingie.addChild(cross2);

    for (PShape p : things) {
      thingie.addChild(p);
    }

    return thingie;
  }

  PShape createThing(PVector l, float p) {
    PShape thingie, shadow, facade;

    shadow = createShape();
    shadow.beginShape();
    shadow.strokeWeight(5);
    shadow.stroke(#FFFFFF);
    shadow.strokeJoin(ROUND);

    facade = createShape();
    facade.beginShape();
    facade.strokeWeight(4);
    facade.stroke(#0B3C61);
    facade.strokeJoin(ROUND);

    for (float r = 0.0; r <= TWO_PI; r+=TWO_PI/p) {
      float x, y;

      x = l.x + cos(r) * CELL/6;
      y = l.y + sin(r) * CELL/6;
      shadow.vertex(x, y);

      x = l.x + cos(r) * (CELL/6)/1.25;
      y = l.y + sin(r) * (CELL/6)/1.25;      
      facade.vertex(x, y);
    }

    shadow.endShape();
    facade.endShape();

    thingie = createShape(GROUP);
    thingie.addChild(shadow);
    thingie.addChild(facade);

    return thingie;
  }

  PShape createThing(PVector l1, PVector l2) {
    PShape thingie, shadow, border;

    shadow = createShape();
    shadow.beginShape();
    shadow.strokeWeight(1);
    shadow.stroke(#FFFFFF);
    shadow.strokeJoin(ROUND);
    shadow.vertex(l1.x-2, l1.y-2);
    shadow.vertex(l1.x+2, l1.y+2);
    shadow.vertex(l2.x-2, l2.y-2);
    shadow.vertex(l2.x+2, l2.y+2);
    shadow.endShape();

    border = createShape();
    border.beginShape();
    border.strokeWeight(3);
    border.stroke(#222222);
    border.strokeJoin(ROUND);
    border.vertex(l1.x, l1.y);
    border.vertex(l2.x, l2.y);
    border.endShape();

    thingie = createShape(GROUP);
    thingie.addChild(shadow);
    thingie.addChild(border);

    return thingie;
  }
  
  void convertThing() {
    this.thing = this.createThing(this.l, 4);
  }

  void setThingStroke() {
    switch(this.type) {
    case 0:
      this.thing.getChild(1).setStroke(color(124, 124, 124, this.alpha));
      this.thing.getChild(2).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      this.thing.getChild(3).getChild(1).setStroke(color(11, 60, 97, this.alpha));      
      this.thing.getChild(4).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      this.thing.getChild(5).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      this.thing.getChild(6).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      this.thing.getChild(7).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      this.thing.getChild(8).getChild(1).setStroke(color(11, 60, 97, this.alpha));
      break;
    case 1: 
      this.thing.setStroke(color(11, 60, 97, this.alpha));
      break;
    case 2: 
      this.thing.getChild(1).setStroke(color(204, 204, 204, this.alpha));
      break;
    case 3: 
      this.thing.getChild(1).setStroke(color(204, 204, 204, this.alpha));
      break;
    }
  }

  void fadeIn() {
    if (this.alpha > 255) return;
    else if (this.alpha < 255) {
      this.setThingStroke();
    } else if (this.alpha == 255) {
      this.thing.setStroke(color(#0B3C61));
      this.phase++;
    }
    this.alpha+=2;
  }

  void doWork() {
  }

  void fadeOut() {
    if (this.alpha <= 0) return;
    this.setThingStroke();
    this.alpha--;
  }

  void doPanic() {
  }

  void update() {
    this.ttl++;

    if (this.ttl == 900) this.phase = 3;

    switch(this.phase) {
    case 1: 
      this.fadeIn();
      break;
    case 2: 
      this.doWork();
      break;
    case 3: 
      this.fadeOut();
      break;
    case 4: 
      this.doPanic();
      break;
    }
  }

  void render() {
    shape(this.thing);
  }
}
