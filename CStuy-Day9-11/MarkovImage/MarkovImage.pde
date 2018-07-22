import java.util.*;

HashMap<ArrayList<Integer>, ArrayList<Integer>> hash = new HashMap();
PImage photo;
int[][] pixels2d;
int[][] newPixels2d;
int PH;
int PW; 

void setup() {
  size(500,500);
  photo = loadImage("mural.png");
  //photo.resize(600,800);
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
  //filter(GRAY);
  loadPixels();
  println("0");
  setPixels();
  setKeys();
  setValue();
  make();
  println("1");
  updatePixels();
  //println(hash);
  println("2");
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

void setKeys() {
  for(int y = 1; y < pixels2d.length; y++) {
    for(int x = 1; x < pixels2d[y].length; x++) {
      ArrayList<Integer> temp = new ArrayList();
      temp.add(modit(pixels2d[y-1][x]));
      temp.add(modit(pixels2d[y][x-1]));
      if (!hash.containsKey(temp)) {
        hash.put(temp, new ArrayList<Integer>());
      }
    }
  }
}

void setValue() {
  for(int y = 1; y < pixels2d.length; y++) {
    for(int x = 1; x < pixels2d[y].length; x++) {
      ArrayList<Integer> temp = new ArrayList();
      temp.add(modit(pixels2d[y-1][x]));
      temp.add(modit(pixels2d[y][x-1]));
      hash.get(temp).add(modit(pixels2d[y][x]));
    }
  }
}

void make() {
  for (int x = 0; x < pixels2d[0].length; x++) {
    newPixels2d[0][x] = pixels2d[0][x];
  }
  for (int y = 0; y < pixels2d.length; y++) {
    newPixels2d[y][0] = pixels2d[y][0];
  }
  for(int y2 = 1; y2 < newPixels2d.length; y2++) {
    for(int x2 = 1; x2 < newPixels2d[y2].length; x2++) {
      ArrayList<Integer> temp = new ArrayList();
      temp.add(modit(newPixels2d[y2-1][x2]));
      temp.add(modit(newPixels2d[y2][x2-1]));
      try{
        newPixels2d[y2][x2] = hash.get(temp).get(int(random(0,hash.get(temp).size())));
      }
      catch (Exception e) {
        newPixels2d[y2][x2] = newPixels2d[y2][x2-1];
      }
    }
  }
  int counter = 0;
  for(int y = 0; y < newPixels2d.length; y++) {
    for(int x = 0; x < newPixels2d[y].length; x++) {
      pixels[counter] = newPixels2d[y][x];
      counter++;
    }
  }
}

Integer modit(Integer c) {
  float red = red(c);
  float green = green(c);
  float blue = blue(c);
  red = int((int)red/10) * 10;
  green = int((int)green/10) * 10;
  blue = int((int)blue/10) * 10;
  //println(red + " " + green + " " + blue);
  return color(red, green, blue);
}
