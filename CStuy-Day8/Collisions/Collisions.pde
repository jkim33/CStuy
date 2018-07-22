//Goals:
//1. Read through the class, see how this does some of the things that you did when detecting collisions

//2. Add code to constrain the Mover to the screen.
// constrainInView() is the code that should do this. It just makes sure that the objects aren't half off the screen and stuck in the walls!

//3 You must complete part B by writing out sentences!
//a. How does this collision detection differ from your way from friday?
//b. Discuss with a neighbor, put a comment with the differences pros/cons next to the collision code!!! 
//c. Add some collision behavior like bouncing or something other than turning red/white.

//4. Add something to the up/down keys. 
//Ideas: 
//gravity up or down
//Add or remove a mover (10 max, 0 minimum)
//adjust all mover's speeds + or -

//5. 
//a. Add an instance varible to a Mover that holds a PImage. When you construct a Mover, load a default image from a file (pokeball or something)
//b. Modify the display command - when there is an image, display the image instead of a circle. When the image == null, then display the circle.
//c. Add a new variable to the constructor for the filename that your Mover uses as an image. Use different files for different movers (player especially!)



Mover player;
Mover [] others;

void setup() {
  size(1000, 700); 

  player = new Mover();
  //set player to black 
  player.c = color(0);

  //initialize the array of movers
  others = new Mover[10];
  for (int i = 0; i < others.length; i++) {
    others[i] = new Mover();
  }
}

void draw() {
  background(255);

  player.display();
  player.update();

  //how are collisions handled?
  for (int i = 0; i < others.length; i++) {
    others[i].update();
    others[i].display();
    others[i].checkCollisions(others);
  }
  //why doin't they affect the player?
  //how can we make them affect the player?
}

/* 
 Look at the keyPressed documentation!
 */
void keyPressed() {
  //Use println to see what the keycodes are!

  println(keyCode);

  //UP
  if (keyCode == 38) {
    //run code that will modify player
  }


  //DOWN
  if (keyCode == 40) {
    //run code that will modify player
  }
}




class Mover {
  PVector position, velocity, acceleration;
  float size;
  color c;


  //CONSTRUCTORS

  //constructor that takes all the different properties, can be used by other constructors
  Mover(float x, float y, float dx, float dy, float ax, float ay) {
    c = color(random(100)+155, random(100)+155, random(100)+155);
    size = 60.0;
    position = new PVector(x, y);
    velocity = new PVector(dx, dy);
    acceleration = new PVector(ax, ay);
  }

  //Constructor that uses the other constructor, this(parameters) is how one constructor can call another. 
  Mover(float x, float y) {
    this(x, y, 0.0, 0.0, 0.0, 0.0);
  }
  //Alternate way of defining position using x,y
  Mover(PVector position) {
    this(position.x, position.y, 0.0, 0.0, 0.0, 0.0);
  }

  Mover() {
    this(random(width), random(height), random(5.0)-2.5, random(5.0)-2.5, 0.0, 0.0);
    constrainInView();
  }


  //METHODS THAT GET/SHOW INFORMATION

  void display() {

    fill(c);
    ellipse(position.x, position.y, size, size);
    /**display the time till change
     fill(255);
     text(framesTillChange, position.x, position.y);
     */
  }



  boolean isNearby(Mover other, float nearbyDistance) {
    return dist(position.x, position.y, other.position.x, other.position.y) < (size+other.size)/2 + nearbyDistance;
  }

  //use other functions if it makes sense to do so.
  boolean isTouching(Mover other) {
    return isNearby(other, 0.0);
  }



  //METHODS THAT MODIFY THE OBJECT

  //This is the main change object method that does everything you need.
  void update() {
    position.add(velocity);
    velocity.add(acceleration);

    //limit to 10 speed (can make the limit a constant or a variable
    velocity.limit(10);

    //reset acceleration to 0 so that it must be applied every frame (gravity isn't cumilative)
    acceleration.mult(0);

    //check walls
    bounce();
  }
  
  void checkCollisions(Mover[] all){
    //check for collisions against ANY of them except itself.
    //store the result in a boolean.
    boolean collided = false;
    for(int i = 0; i < all.length; i++){
     if(this != all[i]){
       if( isTouching(all[i]) ) {
          collided = true;
       }
     }
    }

    //depending on the check from above
    //run the collision code only once, or run non-collision code!
    if(collided){
     c = color(255,0,0); 
    }else{
     c = color(255,255,255); 
    }
  }

  //Note on acceleration:
  //acceleration should be reset after every move. 
  //new forces are then applied at each frame of the animation


  //effects of acceleration are not affected by mass
  void applyAcceleration(PVector acc) {
    acceleration.add(acc);
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

    //keep on the screen!
    constrainInView();
  }
  
  void constrainInView() {
    //move back into the screen if you end up off the screen, prevents getting stuck in a wall.
  }

}
