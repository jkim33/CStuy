float x, y, angle;//position/angle
float xspeed, yspeed, rspeed;//speed 

void setup() {
  size(800, 700);
  x = width/2.0;
  y = height/2.0;
  angle = 30.0;
  xspeed = random(4)-2;
  yspeed = random(4)-2;
  rspeed = random(4)-2;
}

void draw() {
  background(255);
  stroke(0);
  textSize(24);
  text(" dx = "+xspeed+"\n dy = "+yspeed+"\n da = "+rspeed, 20, 20);
  text("Click to randomize speeds", 20, height-20);
  avatar(x, y, angle);

  move();
}

void move() {
  //move
  //change angle and x by small amounts to get animation
  angle += rspeed;
  x+=xspeed;
  y+=yspeed;

  //collide
  checkWalls();
}


//bounce code!
void checkWalls() {
  if ( x > width || x < 0 ) {
    x -= xspeed;//undo last move
    xspeed *= -1;//reverse speed
  }
  if ( y > height || y < 0 ) {
    y -= yspeed;
    yspeed *= -1;
  }
}

//this is a function that is automatically run when
//the mouse is pressed. It doesn't need to be called 
//by the programmer, it is called by the system
void mousePressed() {
  xspeed = random(4)-2;
  yspeed = random(4)-2;
  rspeed = random(4)-2;
}



//updated avatar to cut down on extra code, uses loops and arrays.
//for advanced students to poke around and look at.
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
  fill(255, 0, 0);
  float radius = 50;
  float xcor, ycor;
  color[] c= { color(255, 0, 0), color(0, 255, 0), color(0, 0, 255) };
  for (int i = 0; i < 3; i++) {
    fill(c[i]);
    xcor = x + radius * cos( radians( angle ) );
    ycor = y + radius * sin( radians( angle ) );
    ellipse(xcor, ycor, 20, 20);
    angle = angle + 120;//increase the angle by 1/3 of a circle.
  }
}
