/** \file
 * Qix-like demo of drawing vectors with Processing.
 */

void setup() {
    size(512, 600);

    vector_setup();

    blendMode(ADD); 	// lines brighter where they overlap
    noFill(); 	// don't fill in shapes
    stroke(212, 128, 32, 128);  // (r,g,b,alpha) for lines

    frameRate(25); 	
}

void draw() {
	background(0); 	// clears the screen and fills it with black

	//single_line();
	//spinning_asterisk();
	//spinning_star();
	PVector center = new PVector(width/2, height/2);
	vector_circle(center,150);
	vector_ellipse(center, 150, 100);

    vector_send(); 	// send the vectors to the board to be drawn
}
