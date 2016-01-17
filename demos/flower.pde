// vim: set ts=2 expandtab:
// Please don't move or delete the line above!  Thx, Holly

// Location of flower
float x = 0;
float y = 100;
int xDirection = 1;
int yDirection = 1;
float aRotate = 0;
float aTranslate = 0;

void flower(float xPos, float yPos, int num_petals) {
  pushMatrix();
  
  background(0);

  // move to first flower petal position
  translate(xPos, yPos);
  
  // draw the flower
  for (int i = 0; i < num_petals; i++) {
    ellipse(0, 30, 20, 80);
    rotate(2*PI/num_petals);  
  }
  
  popMatrix();
}

void spinny_flower() {
  pushMatrix();

  // refresh the background for you'll get a smear instead of movement
  background(0);

  // move to first flower petal position
  translate(width/2 + x, height/2 + y);   // (x, y) put in center of canvas
  rotate(aRotate += 0.05);

  // draw the flower
  for (int i = 0; i < 12; i++) {  // make 10 ellipses
    ellipse(0, 30, 20, 80);   // (x, y, width, height)
    rotate(PI/6);   // 2(pi) radians is once around circle
  } 
  
  x = cos(aTranslate) * 100;
  y = sin(aTranslate) * 100;  

  aTranslate -= 0.05;
  
  popMatrix();
}
