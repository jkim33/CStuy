Mover movers[];
Mover player;
PImage ball;

void setup() {
  size(1000, 800);
  frameRate(60);
  noStroke();
  imageMode(CENTER);
  ball = loadImage("poke256.png");
  ball.resize(60, 60);
  player = new Mover(width/2, height - 100);
  player.c = color(255, 255, 0);
  player.topSpeed = 5;
  movers = new Mover[10];
  for (int i = 0; i <movers.length; i++) {
    movers[i] = new Mover(ball);
    movers[i].c = color(200, 40, 40);
  }
}

void draw() {
  background(0);
  fill(255);
  textSize(20);
  text("Use 'WASD' to control the yellow mover!", 10, 20);
  for (int i = 0; i <movers.length; i++) {
    Mover a = movers[i];

    /**requirement 2:
     things can look at their surroundings and decide what to do.
     */

    a.changeBehavior(player);
    /**requirement 3:
     When a player touches or does something to another Mover, trigger an event 
     */
    player.catchEm(a);

    //old update and display code
    a.update();
    a.display();
  }
  player.update();
  player.friction();
  player.display();
}

/**Key concept 1:
 player can control one thing.
 */
void keyPressed() {
  println(keyCode);

  if (keyCode == 65) { //a = left
    player.velocity.add( new PVector(-5, 0));
  }

  if (keyCode == 68) { //d = right
    player.velocity.add(new PVector(5, 0));
  }

  if (keyCode == 87) { //w = up
    player.velocity.add(new PVector(0, -5));
  }

  if (keyCode == 83) { //s = down
    player.velocity.add(new PVector(0, 5));
  }
}

void mouseClicked() {
  for (int i = 0; i <movers.length; i++) {
    //Mover a = movers[i];
    //a.applyAcceleration(new PVector(-10, 0));
  }
}

class Mover {
  PImage ball;
  PVector position, velocity, acceleration;
  float size;
  float mass;
  float topSpeed;  
  color c;
  int framesTillChange;
  boolean caught;
  
  Mover(float x, float y, float dx, float dy, float ax, float ay) {
    c = color(random(100)+155, random(100)+155, random(100)+155);
    mass = 10.0;
    caught = false;
    topSpeed = 8.0;
    size = 60.0;
    position = new PVector(x, y);
    velocity = new PVector(dx, dy);
    acceleration = new PVector(ax, ay);
  }

  Mover(float x, float y) {
    this(x, y, 0.0, 0.0, 0.0, 0.0);
  }

  Mover(PImage p) {
    this();
    ball = p;
  }

  Mover(PVector position) {
    this(position.x, position.y, 0.0, 0.0, 0.0, 0.0);
  }

  Mover() {
    this(random(width), random(height), random(5.0)-2.5, random(5.0)-2.5, 0.0, 0.0);
    constrainInView();
  }



  //Note on acceleration:
  //acceleration should be reset after every move. 
  //new forces are then applied at each frame of the animation

  //effects of forces are reduced by higher masses
  void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }

  //effects of acceleration are not affected by mass
  void applyAcceleration(PVector acc) {
    acceleration.add(acc);
  }

  void update() {
    position.add(velocity);
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    acceleration.mult(0);
    bounce();
  }

  void friction() {
    float coef = 1.0;
    PVector fric = PVector.mult(velocity, -1.0) ;
    fric.normalize();
    fric.mult(.01*mass);
    velocity.add(fric);
  }

  void display() {
    if (caught && ball != null) {
      image(ball, position.x, position.y, size, size);
    } else {
      fill(c);
      ellipse(position.x, position.y, size, size);
      /**display the time till change
       fill(255);
       text(framesTillChange, position.x, position.y);
       */
    }
  }

  void bounce() {

    if (position.x < size/2) {
      velocity.x *= -1;
    }
    if (position.x > width - size/2) {
      velocity.x *= -1;
    }
    if (position.y < size/2) {
      velocity.y *= -1;
    }
    if (position.y > height - size/2) {
      velocity.y *= -1;
    }

    constrainInView();
  }

  //Constrain is a really cool function. You should check it out!
  void constrainInView() {
    position.x = constrain(position.x, size/2, width-size/2);
    position.y = constrain(position.y, size/2, height-size/2);
  }


  boolean isNearby(Mover other) {

    return dist(position.x, position.y, other.position.x, other.position.y) < (size+other.size)/2 + 20;
  }

  boolean isTouching(Mover other) {
    return dist(position.x, position.y, other.position.x, other.position.y) < (size+other.size)/2;
  }

  void catchEm(Mover other) {
    if ( isTouching(other) ) {
      other.caught = true;
      other.velocity.mult(0);
    }
  }

  void changeBehavior(Mover other) {
    //look at what you are doing, decide if you need to change 
    if (isNearby(other)) {
      //do something like run away from the player!
      PVector away = PVector.sub(position, other.position);
      away.normalize();
      away.mult(velocity.mag()*2);
      velocity = away;
    } else {
      //undo speed boost
      velocity.normalize();
      velocity.mult(3);

      //do something else, but don't change your actions every fram, that seems terrible.


      if (!caught) {
        //do other stuff when you aren't caught

        //change the direction every  
        if (framesTillChange == 0) {
          framesTillChange = 30+(int)random(90);
          velocity = PVector.random2D();
          velocity.normalize();
          velocity.mult(3);
        }
        framesTillChange--;
      }
    }
  }
}
