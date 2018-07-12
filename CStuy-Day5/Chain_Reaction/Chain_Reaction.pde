Ball[] balls;
int score;
boolean stop;
int level;
boolean playing;
int pass;
int current_level_score;
boolean finished;
boolean paused;

void setup() {
  size(1000, 1000);
  score = 0;
  level=1;
  stop = false;
  finished = false;
  paused = true;
  balls = new Ball[10];
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
  background(0);
  stroke(255);
  strokeWeight(5);
  line(0,0,width,0);
  line(0,0,0,height);
  line(width,0,width,height);
  line(0,height,width,height);
  line(0,100,width,100);
}

void draw() {
  if(level>10) {
    finishedGame();
  }
  background(0);
  strokeWeight(5);
  line(0,0,width,0);
  line(0,0,0,height);
  line(width,0,width,height);
  line(0,height,width,height);
  line(0,100,width,100);
  textSize(36);
  textAlign(LEFT);
  text("TOTAL SCORE: " + score, 5, 45 );
  text("LEVEL SCORE: " + current_level_score, 5, 90);
  textAlign(RIGHT);
  text("LEVEL: " + level, width-5, 45);
  text("LEVEL GOAL: " + pass, width-5, 90);
  if (paused) {
    pause();
    return;
  }
  resetLevel();
  setPass();
  for (Ball b : balls) {
    changeState(b);
    fill(b.c);
    b.deflect();
    b.act();
    strokeWeight(1);
    ellipse(b.x, b.y, b.radius * 2, b.radius * 2);
    updateText(b);
  }
  check();
}

void changeState(Ball b) {
  if (b.state == 0) {
    for (Ball ba : balls) {
      if (ba.state == 1 || ba.state == 4) {
        if (dist(ba.x, ba.y, b.x, b.y) < (ba.radius + b.radius)) {
          b.state = 1;
          b.chain_level = ba.chain_level + 1;
          current_level_score += 100*Math.pow(b.chain_level, 3);
          return;
        }
      }
    }
  }
  if (b.radius == b.MAX_RADIUS && b.state == 1) {
    b.state = 4;
  } else if (b.state == 4 && b.counter > 60) {
    b.state = 2;
  } else if (b.state == 2 && b.radius == 0) {
    b.state = 3;
  }
}

void mouseClicked() {
  if (finished) {
    finished = false;
    return;
  }
  if (stop) {
    return;
  }
  if (paused) {
    paused = false;
    return;
  }
  Ball[] temp = new Ball[balls.length + 1];
  int counter = 0;
  for (Ball b : balls) {
    temp[counter] = b;
    counter++;
  }
  temp[temp.length - 1] = new Ball(1, mouseX, mouseY);
  balls = temp;
  stop = true;
}

void updateText(Ball b) {
  textSize(22);
  fill(255);
  textAlign(CENTER);
  if (b.state == 1 || b.state == 2 || b.state == 4) {
    text("+" + 100*Math.pow(b.chain_level, 3), b.x, b.y);
  }
  textSize(36);
  textAlign(LEFT);
  text("TOTAL SCORE: " + score, 5, 45 );
  text("LEVEL SCORE: " + current_level_score, 5, 90);
  textAlign(RIGHT);
  text("LEVEL: " + level, width-5, 45);
  text("LEVEL GOAL: " + pass, width-5, 90);
}

void check() {
  for (Ball b : balls) {
    if (b.state == 1 || b.state == 2 || b.state == 4) {
      return;
    }
  }
  if (stop) {  
    if (current_level_score >= pass) {
      level++;
      score+=current_level_score;
      if(level > 10) {
        level = 1;
        score = 0;
      }
    }
  }
}

void setPass() {
  if (level == 1) {
    pass = 1000;
  } else if (level == 2) {
    pass = 50000;
  } else if (level == 3) {
    pass = 500000;
  } else if (level == 4) {
    pass = 1000000;
  } else if (level == 5) {
    pass = 1500000;
  } else if (level == 6) {
    pass = 2500000;
  } else if (level == 7) {
    pass = 10000000;
  } else if (level == 8) {
    pass = 15000000;
  } else if (level == 9) {
    pass = 20000000;
  } else if (level == 10) {
    pass = 30000000;
  }
}

void resetLevel() {
  for (Ball b : balls) {
    if (b.state == 1 || b.state == 2 || b.state == 4) {
      return;
    }
  }
  if (stop) {
    paused = true;
    current_level_score = 0;
    balls = new Ball[level*10];
    for (int i = 0; i < balls.length; i++) {
      balls[i] = new Ball();
    }
    stop = false;
  }
}

void pause() {
  textSize(52);
  textAlign(CENTER);
  text("Level: " + level, width/2, height/2);
}

void finishedGame() {
  if (level > 10) {
    textSize(52);
  textAlign(CENTER);
  text("Done!",width/2,height/2);
  }
}
