// vim: set ts=2 expandtab:
// Please don't move or delete the line above!  Thx, Holly

class Pinwheel {
	float xpos;
	float ypos;
	int num_petals;
	float scale_size = 1;
	int age = 0;
	float rotation_rate = 0;
	float rotation_state = 0;

	// Constructor
	Pinwheel(float tempxpos, tempypos, int tempnum_petals, float tempscale_size) {
		xpos = tempxpos;
		ypos = tempypos;
		num_petals = tempnum_petals;
		scale_size = tempscale_size;
	}

	// rotate sequence, speed up, and don't slow down until mouse has left area
	void spin(float distance) {

    if distance < x
      if spin not started
        start spin
      else if spin > y
        spin = spin;
      else spin++
    else if spin > 0
      spin--
    else if spin === 0
      done
    

    else if 
		if distance < x increase rate of spin
		
		// if you're moving towards the flower, speed up, if away, slow down
		rotation_rate += distance;
		rotate(rotation_state += rotation_rate);	
	}

	void display() {
	}
}

