class Ball {

  final static int MOVING = 0;
  final static int GROWING = 1;
  final static int SHRINKING = 2;
  final static int DEAD = 3;
  final static int FROZEN = 4;
  final float CHANGE_FACTOR = 5;
  final float MAX_RADIUS = 75;

  float x, y;
  float xVel, yVel;
  float radius;
  color c;
  int state;
  int counter;
  int chain_level;

  Ball() {
    xVel = random(2,6);
    yVel = random(2,6);
    
    if (int(random(0,2)) == 1) {
      xVel *= -1;
    }
    if (int(random(0,2)) == 1) {
      yVel *= -1;
    }

    c = color((int) (Math.random() * 266), (int) (Math.random() * 266), (int) (Math.random() * 266), 170);

    x = random(radius,width-radius);
    y = random(radius+100,height-radius);

    radius = 15;

    state = 0;
    
    counter = 0;
    
    chain_level = 0;
  }
  
  Ball(int s, float _x, float _y) {
    x = _x;
    y = _y;
    xVel = 0;
    yVel = 0;
    state = s;
    radius = 0;
    c = color((int) (Math.random() * 266), (int) (Math.random() * 266), (int) (Math.random() * 266), 170);
    
    counter = 0;
    
    chain_level = 0;
  }

  void act() {
    if (state == MOVING) {
      x += xVel; 
      y += yVel;
    } 
    else if (state == GROWING) {
      radius += CHANGE_FACTOR;
    } 
    else if (state == SHRINKING) {
      radius -= CHANGE_FACTOR;
    } 
    else if (state == DEAD) {
      return;
    }
    else if (state == FROZEN) {
      counter++;
    }
  }

  void deflect() {
    if (x > width-radius) {
      x = x - 10;
      xVel = -1 * xVel;
    } else if (x < radius) {
      x = x + 10;
      xVel = -1 * xVel;
    } else if (y > height-radius) {
      y = y - 10;
      yVel = -1 * yVel;
    } else if (y < radius+100) {
      y = y + 10;
      yVel = -1 * yVel;
    }
  }
}
