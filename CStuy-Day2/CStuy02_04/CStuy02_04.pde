import processing.video.*;
//DAY 2 - IMAGE PROCESSING w/ WEBCAM

Capture cam;
String[] cameras;
PImage photo;
float[][] kernel;
int kernelSum;
int[][] pixels2d;
int[][] newPixels2d;
int PH;
int PW; 

void setup() {
  size(900, 360);
  cameras = Capture.list();
  kernel = new float[][] { {0, 0, 0}, {0, 1, 0}, {0, 0, 0} };
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    //cam = new Capture(this, cameras[0]);
    cam = new Capture(this, 640, 360);
    cam.start();
  }
  textSize(36);
  text("1) Identity", 655, 100);
  text("2) Blur", 655, 140);
  text("3) Edge", 655, 180);
  text("    Detection", 655, 220);
  text("4) Sharpen", 655, 260);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  PH = cam.height;
  PW = cam.width;
  pixels2d = new int[PH][PW];
  newPixels2d = new int[PH][PW];
  if (PH > height) {
    PH = height;
  }
  if (PW > width) {
    PW = width;
  }
  loadPixels();
  setPixels();
  useKernel();
  changePixels();
  updatePixels();
}

void setPixels() {
  int counter = 0;
  for (int i = 0; i < PH; i++) {
    for (int k = 0; k < PW; k++) {
      pixels2d[i][k] = pixels[counter];
      counter++;
    }
    if (width - PW > 0) {
      counter += width-PW;
    }
  }
}

void useKernel() {
  for (int i = 1; i < PH-1; i++) {
    for (int k = 1; k < PW-1; k++) {
      newPixels2d[i][k] = convulate(i, k);
    }
  }
}

int convulate(int x, int y) {
  float red = 0;
  float green = 0;
  float blue = 0;
  for (int i = -1; i < 2; i++) {
    for (int k = -1; k < 2; k++) {
      red += kernel[i+1][k+1] * red(pixels2d[x+i][y+k]);
      green += kernel[i+1][k+1] * green(pixels2d[x+i][y+k]);
      blue += kernel[i+1][k+1] * blue(pixels2d[x+i][y+k]);
    }
  }
  return color(red, green, blue);
}

void changePixels() {
  int counter = 0;
  for (int i = 0; i < PH; i++) {
    for (int k = 0; k < PW; k++) {
      pixels[counter] = newPixels2d[i][k];
      counter++;
    }
    if (width - PW > 0) {
      counter += width-PW;
    }
  }
}

void keyPressed() {
  if (key == '1') {
    kernel = new float[][] { {0, 0, 0}, {0, 1, 0}, {0, 0, 0} };
  } else if (key == '2') {
    kernel = new float[][] { {1.0/9.0, 1.0/9.0, 1.0/9.0}, {1.0/9.0, 1.0/9.0, 1.0/9.0}, {1.0/9.0, 1.0/9.0, 1.0/9.0} };
  } else if (key == '3') {
    kernel = new float[][] { {-1, -1, -1}, {-1, 8, -1}, {-1, -1, -1} };
  } else if (key == '4') {
    kernel = new float[][] { {0, -1, 0}, {-1, 5, -1}, {0, -1, 0} };
  }
}
//Box Blur
//kernel = new float[][] { {1.0/9.0, 1.0/9.0 , 1.0/9.0}, {1.0/9.0, 1.0/9.0, 1.0/9.0}, {1.0/9.0, 1.0/9.0, 1.0/9.0} };

//Edge Detection
//kernel = new float[][] { {-1,-1,-1} , {-1,8,-1}, {-1,-1,-1} };

//Sharpen
//kernel = new float[][] { {0,-1,0}, {-1,5,-1} , {0,-1,0} };

//Identity
//kernel = new float[][] { {0, 0, 0}, {0, 1, 0}, {0, 0, 0} };
