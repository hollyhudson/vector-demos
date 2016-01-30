// vim: set ts=2 expandtab:
// Please don't move or delete the line above!  Thx, Holly

class Flower {
	float xpos;
	float ypos;
	int num_petals;
	float scale_size = 1;
	int age = 0;
	float rotation_rate = 0;  // between 0.0 and 0.1 looks nice
	float rotation_state = 0;

	// Constructor
	Flower(float tempxpos, float tempypos, int tempnum_petals, float tempscale_size) {
		xpos = tempxpos;
		ypos = tempypos;
		num_petals = tempnum_petals;
		scale_size = tempscale_size;
	}

	// rotate sequence, speed up, and don't slow down until mouse has left area
	void spin(float distance) {

    // how do we judge distance?  use radius of ellipse from center of rotation
    if (distance < 50) { // if we're close
      if (rotation_rate < 0.2) { // and rotation is less than max speed
        rotation_rate+= 0.02; // increase rotation rate by 0.01
      }
    } else if (rotation_rate > 0) {
      // if we're outside the pinwheel's radius and still spinning, slow down 
      //rotation_rate-= 0.005;
      rotation_rate*= 0.97; //exponential decay
      
    }

    // never go backwards, just stop
    if (rotation_rate < 0) { 
      rotation_rate = 0;
    }
    
	}

	void display() {
    pushMatrix();
    
    background(0);
  
    // move to first flower petal position
    translate(xpos, ypos);

    // adjust rotation rate in relation to where the mouse is
    float xDistance = mouseX - xpos;
    float yDistance = mouseY - ypos;
    float radial = sqrt(xDistance * xDistance + yDistance * yDistance);
    this.spin(radial);

    // impart spin onto flower to be drawn
    rotate(rotation_state += rotation_rate);

    // scale the flower
    scale(scale_size);

    // draw the flower
    for (int i = 0; i < num_petals; i++) {
      ellipse(0, 15, 10, 40);
      rotate(2*PI/num_petals);
    }

    popMatrix();

    // age the flower for eventual destruction
    age += 1;
  }

}

