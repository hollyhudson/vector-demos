// vim: set ts=2 expandtab:
// Please don't move or delete the line above!  Thx, Holly

class Flower {
  float xpos;
  float ypos;
  int num_petals;
  float scale_size = 1;
  float rotation_rate; // 0.0 - 0.1 looks nice
  float rotation_state = 0;

  // The constructor (which I assume is this) should take:
  // xpos, ypos, num_petals
  // scale, rotation_rate, rotation_dir
  //Flower(float tempxpos, float tempypos, int tempnum_petals, float tempscale_size, float rotation_rate, int rotation_dir) {
  Flower(float tempxpos, float tempypos, int tempnum_petals, float tempscale_size, float temprotation_rate) {
    xpos = tempxpos;
    ypos = tempypos;
    num_petals = tempnum_petals;
    scale_size = tempscale_size;
    rotation_rate = temprotation_rate;
  }
  
  void display() {
    pushMatrix();
    
    background(0);
  
    // move to first flower petal position
    translate(xpos, ypos);
    // Rotate state so next flower drawn will be spun slightly
    rotate(rotation_state += rotation_rate);
    // Scale the flower
    scale(scale_size);

    // draw the flower
    for (int i = 0; i < num_petals; i++) {
      ellipse(0, 15, 10, 40);
      rotate(2*PI/num_petals);  
    }
    
    popMatrix();
  }
}
  
/*
  void spin() {
    pushMatrix();
  
    // refresh the background or you'll get a smear instead of movement
    background(0);
  
    // move to first flower petal position
    translate(width/2 + xSpinRadius, height/2 + ySpinRadius);   // (x, y) put in center of canvas
    rotate(flowerRotate += 0.05);
  
    // draw the flower
    for (int i = 0; i < 12; i++) {  // make 10 ellipses
      ellipse(0, 30, 20, 80);   // (x, y, width, height)
      rotate(PI/6);   // 2(pi) radians is once around circle
    } 
    
    popMatrix();
  }

    /* for spinning in a circle rather than in place:
    float xSpinRadius = 0;
    float ySpinRadius = 100;
    xSpinRadius = cos(flowerTranslate) * 100;
    ySpinRadius = sin(flowerTranslate) * 100;  
    flowerTranslate -= 0.05;
    */
