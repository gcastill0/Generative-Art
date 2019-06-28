int scale = 1;
class Canvas {
  Quadrant q1, q2, q3, q4;

  Canvas() {
    // Cut this out later. These coordinates are required for the prototype only.
    float x = 0;
    float y = 0;
    float w = width/scale;
    float h = height/scale;
    String[] icons = {"noun_78632.png","noun_122714.png","noun_145864.png","noun_195757.png"};
    
    // End cut
    q1 = new Quadrant(x, y, w, h);
    q1.icon = new Icon(x, y, icons[0]);

    // Recalculate x, y; height and width stay the same
    x = q1.x + w;
    y = q1.y ;

    q2 = new Quadrant(x, y, w, h);
    q2.icon = new Icon(x, y, icons[1]);

    x = q1.x ;
    y = q1.y + h;
    q3 = new Quadrant(x, y, w, h);
    q3.icon = new Icon(x, y, icons[2]);

    x = q1.x + w;
    y = q1.y + h;

    q4 = new Quadrant(x, y, w, h);
    q4.icon = new Icon(x, y, icons[3]);
  }

  void render() {
    q1.update();
    q1.render();

    q2.update();
    q2.render();

    q3.update();
    q3.render();

    q4.update();
    q4.render();
  }

  void transition(int mode) {
    if (mode==0) {
      // Recalculate x, y; height and height
      float x = 0;
      float y = 0;
      float w = width/scale;
      float h = height/scale;
      q1.transitionTo(x, y, w, h);

      // Recalculate x, y; height and height
      x = w;
//      y = q1.y;
//      w = q1.w;
//      h = q1.h;
      q2.transitionTo(x, y, w, h);

      // Recalculate x, y; height and height
      x = 0;
      y = h;
//      w = q1.w;
//      h = q1.h;
      q3.transitionTo(x, y, w, h);      

      // Recalculate x, y; height and height
      x = w;
      y = h;
      //w = q1.w;
      //h = q1.h;
      q4.transitionTo(x, y, w, h);
    }
    if (mode==1) {

      // Recalculate x, y; height and width stay the same
      float x = 0;
      float y = 0;
      float w = width/(scale*2);
      float h = height/scale;
      q1.transitionTo(x, y, w, h);

      // Recalculate x, y; height and width stay the same
      x = 0 + w;
      y = 0;
      //w = q1.w;
      //h = q1.h;
      q2.transitionTo(x, y, w, h);

      // Recalculate x, y; height and height
      x = 0;
      y = h;
//      w = q1.w;
//      h = q1.h;
      q3.transitionTo(x, y, w, h);      

      // Recalculate x, y; height and height
      x = w;
      y = h;
      //w = q1.w;
      //h = q1.h;
      q4.transitionTo(x, y, w, h);

    } else
      if (mode==2) {

        // Recalculate x, y; height and height
        float x = 0;
        float y = 0;
        float w = width/(scale*2);
        float h = height/scale;
        q1.transitionTo(x, y, w, h);

        // Recalculate x, y; height and height
        x = w;
        h = height/(scale*2);
//        y = q1.y;
//        w = q1.w;
//        h = q1.h/2;       
        q2.transitionTo(x, y, w, h);

        // Recalculate x, y; height and height
        x = 0;
        y = height/scale;
//        w = q1.w;
//        h = q1.h/2;
        q3.transitionTo(x, y, w, h);

        // Recalculate x, y; height and height
        x = w;
        y = height/(scale*2);
//        w = q1.w;
//        h = q1.h/2;
        q4.transitionTo(x, y, w, h);

      } else
        if (mode==3) {

          // Recalculate x, y; height and height
          float x = 0;
          float y = 0;
          float w = width/(scale*2);
          float h = height/(scale*2);
          q1.transitionTo(x, y, w, h);

          // Recalculate x, y; height and height
          x = width/(scale*2);
          h = height/scale;
//          w = q1.w;
//          h = q1.h;
          q2.transitionTo(x, y, w, h);

          // Recalculate x, y; height and height
          x = 0;
          y = height/(scale*2);
          h = height/(scale*2);
//          w = q1.w;
//          h = q1.h;
          q3.transitionTo(x, y, w, h);      

          // Recalculate x, y; height and height
          x = width/(scale*2);;
          y = height/scale;
//          w = q1.w;
//          h = q1.h;
          q4.transitionTo(x, y, w, h);
      } else
        if (mode==4) {

          // Recalculate x, y; height and height
          float x = 0;
          float y = 0;
          float w = width/(scale*2);
          float h = height/(scale*2);
          q1.transitionTo(x, y, w, h);

          // Recalculate x, y; height and height
          x = 0 + w;
          y = 0;
//          w = q1.w;
//          h = q1.h;
          q2.transitionTo(x, y, w, h);

          // Recalculate x, y; height and height
          x = 0;
          y = 0 + h;
//          w = q1.w;
//          h = q1.h;
          q3.transitionTo(x, y, w, h);      

          // Recalculate x, y; height and height
          x = 0 + w;
          y = 0 + h;
//          w = q1.w;
//          h = q1.h;
          q4.transitionTo(x, y, w, h);
        }
  }
}