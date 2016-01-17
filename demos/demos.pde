/** \file
 * Qix-like demo of drawing vectors with Processing.
 */

Vst v;

void setup() {
    size(512, 600, P2D);

    v = new Vst(this, createSerial());

    blendMode(ADD); 	// lines brighter where they overlap
    noFill(); 	// don't fill in shapes
    stroke(212, 128, 32, 128);  // (r,g,b,alpha) for lines

	// globals for the test functions:
	xTop = 20;
	xBot = width - 20;
	dir = 1;

	xCenter = width/2;
	yCenter = height/2;

    frameRate(25); 	
}

void draw() {
	background(0); 	// clears the screen and fills it with black

	//simple_line();
	//slanty_line();
	//spinning_asterisk();
	//spinning_star();
	//PVector center = new PVector(width/2, height/2);
	//vector_circle(center,150);
	//vector_ellipse(center, 150, 100);
	//vector_flower(center, 6, 50, 10);
	flower();

    v.display(); 	// send the vectors to the board to be drawn
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
	int steps = 50; //(int)(r / 5);
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
