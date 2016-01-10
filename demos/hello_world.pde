float xpos;

// draw slanted line whose top and bottom points move along the x-axis
void single_line()
{
    vector_line(false, xpos, 100, width-xpos, 200); //(bright?, x1, y1, x2, y2)
    xpos++;
    if (xpos > width) {
        xpos = 0;
    }
}

PVector endpoint = new PVector(100,0);
PVector center = new PVector(250, 300); // width & height not defined yet

void spinning_asterisk()
{
	// vector_line(false, width/2-100, height/2-200, width/2+100, height/2-200);	
	// rotate

	PVector p = endpoint.copy();
	vector_line(false, PVector.add(center,p), PVector.sub(center,p));

	p.rotate(60*PI/180); 	
	vector_line(false, PVector.add(center,p), PVector.sub(center,p));

	p.rotate(60*PI/180); 
	vector_line(false, PVector.add(center,p), PVector.sub(center,p));

	// convert degrees to radians: degrees * PI/180
	endpoint.rotate(2*PI/180); 	// rotate 2 degrees
}

int splines = 5; // number of lines the star is made of
float degrees = 180/splines;
// make a star of splines lines and rotate it
void spinning_star()
{
	PVector p = endpoint.copy();
	vector_line(false, PVector.add(center,p), PVector.sub(center,p));
	
	for (int i=1; i < splines; i++)
	{
		p.rotate(degrees*PI/180);
		vector_line(false, PVector.add(center,p), PVector.sub(center,p));
	}
	
	endpoint.rotate(2*PI/180);
}

// draw a circle of r radius
void vector_circle(PVector center, float r)
{
	int num_edges = (int)r/2;
	float edge_distance = 360.0/num_edges;
	PVector radius1 = new PVector(0,r); // first pt, north on circle
	
	// draw the edges
	for (int i = 0; i < num_edges; i++)
	{
		PVector radius2 = radius1.copy();
		radius2.rotate(edge_distance*PI/180);
		vector_line(false, PVector.add(center,radius1), PVector.add(center,radius2));			
		radius1 = radius2;
	}
}

// draw an ellipse
void vector_ellipse(PVector center, float x_radius, float y_radius)
{
	int num_steps = (int)(x_radius + y_radius)/4;
	float dtheta = 2*PI/num_steps; // step for incrementing the angle
	PVector current_radius = new PVector(x_radius,0);
	
	// draw the edges
	for (float theta = dtheta; theta <= (2*PI + dtheta); theta += dtheta)
	{
		PVector next_radius = new PVector(x_radius * cos(theta), y_radius * sin(theta));
		vector_line(false, PVector.add(center,current_radius), PVector.add(center,next_radius));
		current_radius = next_radius;
	}
		
}
