final int DIST = 60;
Ball b;
Paddle left_p;
Paddle right_p;
int left_score;
int right_score;
boolean done;

void setup() {
  size(1920,1080);
  background(0);
  done = false;
  b = new Ball(width/2, height/2);
  left_p = new Paddle(DIST, height/2);  
  right_p = new Paddle(width-DIST, height/2);
  stroke(255);
  strokeWeight(10);
  line(width/2,0,width/2,height);
  line(0,0,width,0);
  line(0,height,width,height);
  ellipse(b.x_cor, b.y_cor, b.RADIUS*2, b.RADIUS*2);
  rectMode(CENTER);
  rect(left_p.x_cor, left_p.y_cor, left_p.WIDTH, left_p.HEIGHT);
  rect(right_p.x_cor, right_p.y_cor, right_p.WIDTH, right_p.HEIGHT);
  textSize(64);
}

void draw() {
  if (done) {
    end();
    return;
  }
  background(0);
  line(width/2,0,width/2,height);
  line(0,0,width,0);
  line(0,height,width,height);
  ellipse(b.x_cor, b.y_cor, b.RADIUS*2, b.RADIUS*2);
  rectMode(CENTER);
  rect(left_p.x_cor, left_p.y_cor, left_p.WIDTH, left_p.HEIGHT);
  rect(right_p.x_cor, right_p.y_cor, right_p.WIDTH, right_p.HEIGHT);
  b.check(left_p, right_p);
  b.move();
  if (isDead()) {
    respawn();
  }
  win();
  text(left_score, width/2 - 135, 60);
  text(right_score, width/2 + 100, 60);
}

void keyPressed() {
  if (done) {
    if (keyCode == ENTER) {
      left_score = 0;
      right_score = 0;
      done = false;
      return;
    }
  }
  if (keyCode == ENTER) {
    b.go();
  }
  if (key == 'w') {
    left_p.moveUp();
  }
  if (key == 's') {
    left_p.moveDown();
  }
  if (keyCode == UP) {
    right_p.moveUp();
  }
  if (keyCode == DOWN) {
    right_p.moveDown();
  }
}

boolean isDead() {
  if (b.x_cor <= 0) {
    right_score++;
    return true;
  } else if (b.x_cor >= width) {
    left_score++;
    return true;
  }
  return false;
}

void respawn() {
  b = new Ball(width/2, height/2);
}

void win() {
  if (left_score >= 7 || right_score >= 7) {
    done = true;
  }
}

void end() {
  if (left_score >= 7) {
    text("Player 1 Wins!", width/2 - 200, height/2 - 40);
    text("Press ENTER to Play Again!", width/2 - 390, height/2 + 40);
  }
  else if (right_score >= 7) {
    text("Player 2 Wins!", width/2 - 200, height/2 - 40);
    text("Press ENTER to Play Again!", width/2 - 390, height/2 + 40);
  }
}

public class Ball {
  final int MIN = 15;
  final int MAX = 20;
  final int RADIUS = 30;
  private int x_speed;
  private int y_speed;
  private float x_cor;
  private float y_cor;

  public Ball(int x, int y) {
    x_cor = x;
    y_cor = y;
  }

  public void go() {
    if (x_speed == 0 && y_speed == 0) {
      x_speed = int(random(MIN, MAX));
      y_speed = int(random(MIN, MAX));
      if (int(random(0, 2)) == 0) {
        x_speed *= -1;
      }
      if (int(random(0, 2)) == 0) {
        y_speed *= -1;
      }
    }
  }

  public void move() {
    x_cor += x_speed;
    y_cor += y_speed;
  }

  public void check(Paddle left, Paddle right) {
    if (y_cor <= 0 || y_cor >= height) { //hits the wall;
      y_speed *= -1;
      y_cor += y_speed;
    }
    if ( (x_cor <= DIST+RADIUS+left.WIDTH/2 && x_cor >= DIST+left.WIDTH/2) ) { //left paddle
      if (y_cor >= left.y_cor - left.HEIGHT/2.0 && y_cor <= left.y_cor - left.HEIGHT/2.0 + left.HEIGHT/3.0) {
        y_speed -= 1;
        x_speed *= -1;
        x_cor += RADIUS/2;
      } else if (y_cor >= left.y_cor - left.HEIGHT/2.0 + 2*left.HEIGHT/3. && y_cor <= left.y_cor + left.HEIGHT/2.0) {
        y_speed += 1;
        x_speed *= -1;
        x_cor += RADIUS/2;
      } else if (y_cor <= left.y_cor - left.HEIGHT/2.0 + 2*left.HEIGHT/3. && y_cor >= left.y_cor - left.HEIGHT/2.0 + left.HEIGHT/3.0) {
        x_speed *= -1;
        x_cor += RADIUS/2;
      } else if (y_cor <= left.y_cor - left.HEIGHT/2.0 && y_cor >= left.y_cor - left.HEIGHT/2.0 - RADIUS) {
        if (dist(x_cor, y_cor, left.x_cor + left.WIDTH/2, left.y_cor - left.HEIGHT/2.0) <= RADIUS) {
          x_speed *= -1;
          y_speed *= -1;
          x_cor += RADIUS/2;
          y_speed -= 1;
        }
      } else if (y_cor >= left.y_cor + left.HEIGHT/2.0 && y_cor <= left.y_cor + left.HEIGHT/2.0 + RADIUS) {
        if (dist(x_cor, y_cor, left.x_cor + left.WIDTH/2, left.y_cor + left.HEIGHT/2.0) <= RADIUS) {
          x_speed *= -1;
          y_speed *= -1;
          x_cor += RADIUS/2;
          y_speed += 1;
        }
      }
    }
    if (x_cor >= width-RADIUS-DIST-right.WIDTH/2 && x_cor <= width-DIST+right.WIDTH/2) { //right paddle
      if (y_cor >= right.y_cor - right.HEIGHT/2.0 && y_cor <= right.y_cor - right.HEIGHT/2.0 + right.HEIGHT/3.0) {
        y_speed -= 1;
        x_speed *= -1;
        x_cor -= RADIUS/2;
      } else if (y_cor >= right.y_cor - right.HEIGHT/2.0 + 2*right.HEIGHT/3. && y_cor <= right.y_cor + right.HEIGHT/2.0) {
        y_speed += 1;
        x_speed *= -1;
        x_cor -= RADIUS/2;
      } else if (y_cor <= right.y_cor - right.HEIGHT/2.0 + 2*right.HEIGHT/3. && y_cor >= right.y_cor - right.HEIGHT/2.0 + right.HEIGHT/3.0) {
        x_speed *= -1;
        x_cor -= RADIUS/2;
      } else if (y_cor <= right.y_cor - right.HEIGHT/2.0 && y_cor >= right.y_cor - right.HEIGHT/2.0 - RADIUS) {
        if (dist(x_cor, y_cor, right.x_cor - right.WIDTH/2, right.y_cor - right.HEIGHT/2.0) <= RADIUS) {
          x_speed *= -1;
          y_speed *= -1;
          x_cor -= RADIUS/2;
          y_speed -= 1;
        }
      } else if (y_cor >= right.y_cor + right.HEIGHT/2.0 && y_cor <= right.y_cor + right.HEIGHT/2.0 + RADIUS) {
        if (dist(x_cor, y_cor, right.x_cor + right.WIDTH/2, right.y_cor + right.HEIGHT/2.0) <= RADIUS) {
          x_speed *= -1;
          y_speed *= -1;
          x_cor += RADIUS/2;
          y_speed += 1;
        }
      }
    }
  }
}

public class Paddle {
  final int WIDTH = 60;
  final int HEIGHT = 400;
  final int MOVEMENT = 85;
  private float x_cor;
  private float y_cor;

  public Paddle(float x, float y) {
    x_cor = x;
    y_cor = y;
  }

  public void moveUp() {
    if (y_cor >= HEIGHT/2 + MOVEMENT) {
      y_cor -= MOVEMENT;
    }
  }

  public void moveDown() {
    if (y_cor <= height - HEIGHT/2 - MOVEMENT) {
      y_cor += MOVEMENT;
    }
  }
}
