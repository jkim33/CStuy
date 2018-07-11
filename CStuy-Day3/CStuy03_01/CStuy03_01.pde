import processing.video.*;
//DAY 3 - BLUE SCREEN

int bright;
int mid;
int dark;
int counterm;
boolean useScreen;
Capture cam;
String[] cameras;
int[][] pixels2d; 
int PH;
int PW; 

PImage background;

void setup() {
  size(640, 480);
  useScreen = false;
  counterm = 0;
  cameras = Capture.list();
  background = loadImage("background.jpg");
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    //println("Available cameras:");
    //for (int i = 0; i < cameras.length; i++) {
    //  println(cameras[i]);
    //}
    //cam = new Capture(this, cameras[0]);
    cam = new Capture(this, 640, 480);
    cam.start();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    image(cam, 0, 0);
    PH = cam.height;
    PW = cam.width;
    pixels2d = new int[PH][PW];
    if (PH > height) {
      PH = height;
    }
    if (PW > width) {
      PW = width;
    }
    loadPixels();
    setPixels();
    blueScreen();
    changePixels();
    updatePixels();
  }
}

void setPixels() {
  int counter = 0;
  for (int i = 0; i < PH; i++) {
    for (int k = 0; k < PW; k++) {
      pixels2d[i][k] = pixels[counter];
      counter++;
    }
  }
}

void changePixels() {
  int counter = 0;
  for (int i = 0; i < PH; i++) {
    for (int k = 0; k < PW; k++) {
      pixels[counter] = pixels2d[i][k];
      counter++;
    }
  }
}

void mouseClicked() {
  if (counterm == 0) {
    bright = pixels2d[mouseY][mouseX];
    counterm++;
    println("Bright");
  }
  else if (counterm == 1) {
    mid = pixels2d[mouseY][mouseX];
    counterm++;
    println("Middle");
  }
  else if (counterm == 2) {
    dark = pixels2d[mouseY][mouseX];
    counterm++;
    println("Dark");
    useScreen = true;
  }
}

void blueScreen() {
  if (useScreen) {
    for (int r = 0; r < pixels2d.length; r++) {
      for (int c = 0; c < pixels2d[r].length; c++) {
        if (within(pixels2d[r][c])) {
          pixels2d[r][c] = background.get(c,r);
        }
      }
    }
  }
}

boolean within(int c) {
  float d1 = dist(red(bright), green(bright), blue(bright), red(c), green(c), blue(c));
  float d2 = dist(red(mid), green(mid), blue(mid), red(c), green(c), blue(c));
  float d3 = dist(red(dark), green(dark), blue(dark), red(c), green(c), blue(c));
  if (d1 < 35 || d2 < 35 || d3 < 35) {
    return true;
  }
  return false;
}
