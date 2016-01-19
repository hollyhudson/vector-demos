// vim: set ts=2 expandtab:
// Please don't move or delete the line above!  Thx, Holly

/** \file
 * Qix-like demo of drawing vectors with Processing.
 */

Vst v;
ArrayList<Flower> bouquet = new ArrayList<Flower>();

void setup() {
  size(600, 512, P2D);

  v = new Vst(this, createSerial());

  blendMode(ADD);   // lines brighter where they overlap
  noFill();   // don't fill in shapes
  stroke(212, 128, 32, 128);  // (r,g,b,alpha) for lines

  // globals for the test functions:
  xTop = 20;
  xBot = width - 20;
  dir = 1;

  xCenter = width/2;
  yCenter = height/2;

  for (int i = 0; i < 9; i++) {
    // (xpos, ypos, num_petals, scale_size[0.5, 1.5], rotation_rate[-0.2, 0.2])
    bouquet.add(new Flower(
                  random(100, 450), 
                  random(100, 300), 
                  (int)ceil(random(5.1,8.9)), 
                  random(0.5, 1.5),
                  random(-0.2, 0.2))); 
  }

  frameRate(25);  
}

void draw() {
  background(0);  // clears the screen and fills it with black

  stroke(100);
  line(100, 0, 150, 0); // prevents spot remover from removing the art

  for (int i = 0; i < bouquet.size(); i++) {
    Flower blossom = bouquet.get(i);
    blossom.display();
  }

  v.display();  // send the vectors to the board to be drawn
}

void line(PVector p0, PVector p1)
{
  if (p0 == null || p1 == null)
    return;

  line(p0.x, p0.y, p1.x, p1.y);
}

void line(float x0, float y0, float x1, float y1)
{
        if (v.send_to_display)
  {
    super.line(x0, y0, x1, y1);
    return;
  }

  int s = g.strokeColor;
  boolean bright = red(s) == 255 && green(s) == 255 && blue(s) == 255;
  v.line(bright, x0, y0, x1, y1);
}


void ellipse(float x, float y, float rx, float ry)
{
  // Deduce how long r is in real pixels
        float r = abs(modelX(0,0,0) - modelX((rx+ry),0,0));
  int steps = 30; //(int)(r / 5);
  float dtheta = 2 * PI / steps;
  float theta = dtheta;
  float x0 = rx;
  float y0 = 0;

  for(int i = 0 ; i < steps ; i++, theta += dtheta)
  {
    float x1 = rx * cos(theta);
    float y1 = ry * sin(theta);
    line(x + x0, y + y0, x + x1, y + y1);
    x0 = x1;
    y0 = y1;
  }
}
