//DAY 2 - IMAGE PROCESSING

PImage photo;
float[][] kernel;
int kernelSum;
int[][] pixels2d;
int[][] newPixels2d;
int PH;
int PW; 

void setup() {
  size(2160,1440);
  
  //Box Blur
  //kernel = new float[][] { {1.0/9.0, 1.0/9.0 , 1.0/9.0}, {1.0/9.0, 1.0/9.0, 1.0/9.0}, {1.0/9.0, 1.0/9.0, 1.0/9.0} };
  
  //Edge Detection
  //kernel = new float[][] { {-1,-1,-1} , {-1,8,-1}, {-1,-1,-1} };
  
  //Sharpen
  //kernel = new float[][] { {0,-1,0}, {-1,5,-1} , {0,-1,0} };
  
  //Identity
  kernel = new float[][] { {0,0,0}, {0,1,0}, {0,0,0} };
  
  photo = loadImage("goat.png");
  PH = photo.height;
  PW = photo.width;
  pixels2d = new int[PH][PW];
  newPixels2d = new int[PH][PW];
  if (PH > height) {
    PH = height;
  }
  if (PW > width){
    PW = width;
  }
  image(photo,0,0);
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
      newPixels2d[i][k] = convulate(i,k);
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
  return color(red,green,blue);
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
