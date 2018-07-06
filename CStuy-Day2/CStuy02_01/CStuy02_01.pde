//comments use double slash.

/*multi line
 comments use
 slash+star 
 and end with star+slash
 */

//since position is decimal, i am using float for x and y.
float x, y, angle;


void setup() {
  size(800, 700);
  x = 10.0;
  y = 100.0;
  angle = 30.0;
}

void draw() {
  background(255);
  
  //draw 3 different avatars. 
  avatar(x, y,angle);
  avatar(width-x, 500,angle);
  avatar(random(10)+100, random(10)+300.0,-angle);//random position
  fill(100+random(155));
  ellipse(100,200,30+random(10),30+random(10));
  
  //change angle and x by small amounts to get animation
  angle += 1.5;
  x+=0.5;
  
  //use a conditional to reset a value when it gets too big
  if( x > width){
   x = 0; 
  }
}


void avatar(float x, float y, float angle) {
  stroke(0);
  strokeWeight(2);
  fill(250, 250, 0);
  ellipse(x, y, 100, 100);
  fill(255);
  ellipse(x-25, y-20, 20, 20);//left eye
  ellipse(x+25, y-20, 20, 20);//right eye
  arc(x, y, 70.0, 70, 0.0, PI);//what do the parameters here mean? 
  line(x-35, y, x+35, y);//why is this here? How can you figure that out?

  /*
     Math is very useful in computer science. 
   If you know your trig, you can just calculate 
   3 points equidistant on that original circle!
   
   in this case, we convert angle and radius, into x and y.
   x = r * cos(angle)
   y = r * sin(angle)
   But in this case, we are changing x and y by those values, 
   so they rotate about the center point (x,y)
   */
  
  //RED CIRCLE
  fill(255, 0, 0);
  float radius = 50;
  float xcor, ycor;
  xcor = x + radius * cos( radians( angle ) );
  ycor = y + radius * sin( radians( angle ) );
  ellipse(xcor, ycor, 20, 20);

  //GREEN CIRCLE
  fill(0, 255, 0);
  angle = angle + 120;//increase the angle by 1/3 of a circle.
  xcor = x + radius * cos( radians( angle ) );
  ycor = y + radius * sin( radians( angle ) );
  ellipse(xcor, ycor, 20, 20);

  //BLUE CIRCLE
  fill(0, 0, 255);
  angle = angle + 120;
  xcor = x + radius * cos( radians( angle ) );
  ycor = y + radius * sin( radians( angle ) );
  ellipse(xcor, ycor, 20, 20);
}
