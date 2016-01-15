// Location of flower
float x = 0;
float y = 10;
int xDirection = 1;
int yDirection = 1;
float aRotate = 0;
float aTranslate = 0;

void flower() {
	// refresh the background for you'll get a smear instead of movement
	background(0);


	// flower
	translate(width/2 + x, height/2 + y); 	// (x, y) put in center of canvas
	rotate(aRotate += 0.05);

	for (int i = 0; i < 12; i++) { 	// make 10 ellipses
		ellipse(0, 30, 10, 80); 	// (x, y, width, height)
		rotate(PI/6); 	// 2(pi) radians is once around circle
	}	
	
	// increment or decrement coordinates of flower center
	//y = y + yDirection;
	//x = x + xDirection;

	// x = cos(angle) * radius,  var a will be angle
	// y = sin(angle) * radius
	x = cos(aTranslate) * 5;
	y = sin(aTranslate) * 5;	

	aTranslate -= 0.05;
	// change direction for translating
	/*
	if (x > 200) xDirection = -1;
	if (x < -200) xDirection = 1; 
	if (y > 200) yDirection = -1;
	if (y < -200) yDirection = 1;
	*/
}
