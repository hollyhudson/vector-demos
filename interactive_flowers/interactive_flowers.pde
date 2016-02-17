// vim: set ts=2 expandtab:
// Please don't move or delete the line above!  Thx, Holly

Vst vst;
ArrayList<Flower> bouquet = new ArrayList<Flower>();

void setup() {
  size(512, 600, P2D);

  vst = new Vst(this, createSerial());
//  vst.colorStroke = color(220,220,255);

  blendMode(ADD);   // lines brighter where they overlap
  noFill();   // don't fill in shapes
  
  frameRate(25);  
}

void draw() {
  background(0);  // clears the screen and fills it with black

  stroke(100);
  line(0, 0, 0, 100); // prevents spot remover from removing the art

  // draw a cursor
  pushMatrix();
  translate(mouseX, mouseY);
  for (int i = 0; i < 3; i++) {
    rotate(PI/3);
    line(-5, 0, 5, 0);
  }
  popMatrix();

  //int test = random(9);
  if (floor(random(40)) == 0) {
    // (xpos, ypos, num_petals, scale_size[0.5, 1.5], rotation_rate[-0.2, 0.2])
    bouquet.add(new Flower(
                  random(50, 500), 
                  random(50, 550), 
                  (int)ceil(random(5.1,8.9)), 
                  random(0.5, 1.5))); 
  }

  for (int i = 0; i < bouquet.size(); i++) {
    Flower blossom = bouquet.get(i);
    if (blossom.age > 140) {
      bouquet.remove(blossom);
    } else {
      blossom.display();
    }
  }

  vst.display();  // send the vectors to the board to be drawn
}

