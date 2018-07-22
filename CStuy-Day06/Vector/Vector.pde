ThingThatMoves allMovers[];

void setup() {
  size(1000, 800);
  frameRate(60);
  allMovers = new ThingThatMoves[10];
  for (int i = 0; i <allMovers.length; i++) {
    allMovers[i] = new ThingThatMoves();
    allMovers[i].position.x += random(200)-100;
    allMovers[i].position.y += random(200)-100;
    allMovers[i].velocity.x += random(20)-10;
  }
}

void draw() {
  PVector mouse = new PVector(mouseX, mouseY);

  background(0);
  for (ThingThatMoves a : allMovers) {

    //calculate forces like gravity or wind
    PVector dir = PVector.sub(mouse, a.position);
    dir.normalize();
    dir.div(0.5);

    //apply force

    //gravity towards mouse
    a.applyForce(dir);

    //gravity towards ground
    //a.applyForce(new PVector(0.0, 0.98));

    //air resistance
    //a.applyForce(PVector.mult(a.velocity,-0.05));

    //update the objects 
    a.update();

    //display them
    a.display();

    a.constrainToWindowWithBounces();
  }

  //gravity
  //a.applyAcceleration(new PVector(0, 0.98));
  //float dist = dist(mouseX,mouseY,a.position.x,a.position.y);
  //mouse.normalize();
  //mouse.mult(2/dist);
  //println(mouse.x+" , "+mouse.y);
}

class ThingThatMoves {
  PVector position, velocity, acceleration;
  float mass;
  float topSpeed;  

  ThingThatMoves(float x, float y, float dx, float dy, float ax, float ay) {
    mass = 2.0 + random(10);
    topSpeed = 8.0;
    position = new PVector(x, y);
    velocity = new PVector(dx, dy);
    acceleration = new PVector(ax, ay);
  }

  ThingThatMoves(float x, float y) {
    this(x, y, 0.0, 0.0, 0.0, 0.0);
  }

  ThingThatMoves() {
    this(width/2, height/2, 0.0, 0.0, 0.001, 0.01);
  }

  void applyForce(PVector force) {
    acceleration.mult(0);
    acceleration.add(PVector.div(force, mass));
  }

  void constrainToWindowWithBounces() {
    if (position.x < 10) {
      position.x = 10;
      velocity.x *= -.8;
    }
    if (position.x > width - 10) {
      position.x = width - 10;
      velocity.x *= -.8;
    }
    if (position.y < 10) {
      position.y = 10;
      velocity.y *= -.4; 
      if (abs(velocity.y) < 0.1) {
        velocity.y = 0;
      }
    }
    if (position.y > height - 10) {
      position.y = height - 10;
      velocity.y *= -.8;
    }
  }
  void update() {
    position.add(velocity);
    velocity.add(acceleration);
    velocity.limit(topSpeed);
  }
  void display() {
    ellipse(position.x, position.y, mass*8, mass*8);
    //text("x = "+round(position.x*10)/10.0+"\ny = "+round(position.y*10)/10.0, 10, 10);
    //text("Vx = "+round(velocity.x*10)/10.0+"\nVy = "+round(velocity.y*10)/10.0, 10, 50);
    //text("Ax = "+round(acceleration.x*1000)/1000.0+"\nAy = "+round(acceleration.y*1000)/1000.0, 10, 90);
  }
}
