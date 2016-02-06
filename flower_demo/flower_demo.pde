// vim: set ts=2 expandtab:
// Please don't move or delete the line above!  Thx, Holly

Vst vst;
ArrayList<Flower> bouquet = new ArrayList<Flower>();

void setup() {
  size(600, 512, P2D);

  vst = new Vst(this, createSerial());

  blendMode(ADD);   // lines brighter where they overlap
  noFill();   // don't fill in shapes
  //stroke(212, 128, 32, 128);  // (r,g,b,alpha) for lines
//  vst.colorStroke = color(220,220,255);

  // globals for the test functions:
  //xTop = 20;
  //xBot = width - 20;

  //xCenter = width/2;
  //yCenter = height/2;

  frameRate(25);  
}

void draw() {
  background(0);  // clears the screen and fills it with black

  stroke(100);
  line(100, 0, 150, 0); // prevents spot remover from removing the art
  
  //int test = random(9);
  if (floor(random(40)) == 0) {
    // (xpos, ypos, num_petals, scale_size[0.5, 1.5], rotation_rate[-0.2, 0.2])
    bouquet.add(new Flower(
                  random(50, 550), 
                  random(50, 450), 
                  (int)ceil(random(5.1,8.9)), 
                  random(0.5, 1.5),
                  random(-0.2, 0.2))); 
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
