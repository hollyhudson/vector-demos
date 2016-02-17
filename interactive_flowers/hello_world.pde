// vim: set ts=2 expandtab:
// Please don't move or delete the line above!  Thx, Holly

int xTop;
int xBot;
int dir;

/*
// Draw a slanty line that moves
void slanty_line()
{
  stroke(1);  
  
  line(xTop, 100, xBot, 400); // (x1, x2, y1, y2)
  
  if ( xTop < 20 || xTop > (width - 20) )
  {
    dir *= -1;
  }
  
  xTop += dir;
  xBot += (dir * -1);
  
  println(xTop);
}
*/

float xCenter;
float yCenter;
float asterixRotate = 0;
float steps = 0.05;

void spinning_asterisk(int num_splines, int speed)
{
  pushMatrix(); 
  translate(xCenter, yCenter); // put it in the center

  // select speed of rotation
  if (speed == 0) {
    steps = 0.03;
  } else if (speed == 1) {
    steps = 0.07;
  } else steps = 0.1;

  rotate(asterixRotate += steps); // rotate the frame for the asterix

  // draw the asterix
  for (int i = 0; i < num_splines; i++)
  {
    rotate(PI/num_splines);
    line(0, 100, 0, -100); 
  }
  
  popMatrix();
  //endpoint.rotate(2*PI/180);  // rotate 2 degrees
}

/*
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
  int num_steps = (int)r/2;
  float dtheta = 360.0/num_steps;
  PVector radius1 = new PVector(0,r); // first pt, north on circle
  
  // draw the edges
  for (int i = 0; i < num_steps; i++)
  {
    PVector radius2 = radius1.copy();
    radius2.rotate(dtheta*PI/180);
    vector_line(false, PVector.add(center,radius1), PVector.add(center,radius2));     
    radius1 = radius2;
  }
}

// draw an ellipse based on a x and a y radius
void vector_ellipse(PVector center, float x_radius, float y_radius)
{
  int num_steps = (int)(x_radius + y_radius)/4;
  float dtheta = 2*PI/num_steps; // step for incrementing the angle
  PVector radius1 = new PVector(x_radius,0);
  
  // draw the edges
  for (float theta = dtheta; theta <= (2*PI + dtheta); theta += dtheta)
  {
    PVector radius2 = new PVector(x_radius * cos(theta), y_radius * sin(theta));
    vector_line(false, PVector.add(center,radius1), PVector.add(center,radius2));
    radius1 = radius2;
  }
}

// draw a flower where the petals are ellipses
void vector_flower(PVector center, int num_petals, float x_radius, float y_radius)
{
  float dtheta = 2*PI/num_petals;
  println(dtheta);
  PVector petal_center = new PVector(x_radius, 0);
  println(petal_center.x,petal_center.y);

  for (int i = 0; i < num_petals; i++)  
  {
    vector_ellipse(PVector.add(center,petal_center), x_radius, y_radius);
    petal_center.rotate(dtheta);        
    println(i);
    println(petal_center.x,petal_center.y);
  }
}
*/
