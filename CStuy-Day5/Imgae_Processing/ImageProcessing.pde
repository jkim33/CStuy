PImage start, modified;


void setup() {
  start = loadImage("thing.jpg");
  //print the width/height of your image
  println(start.width+" ,"+start.height);
  
  //matched size to the dimensions of the image, but double the height.
  //You MUST put in numerical values, not use variables (like start.width)
  size(1280,1712);
  
  //display the original
  image(start, 0, 0);
  
  //make a new image using a function 
  modified = randomNoise(start);
  
  //display the modified image.
  image(modified,0,height/2);
}


//Now that everyone has a better grasp of what the main points of edge detection 
//are, we need to take a more organized approach to how we write our code.

//GENERAL THINGS YOU MUST DO:
//1. Create an outline, then comment your code

//2. Use good indentation and style. 
//   Using control-T will auto format your program, this is insanely helpful. Do not forget about this!

//3. Break things up into functions. 

//4. Think about when you need to keep / modify the original data 
//Sometimes we want to modify the original data 
//(sorting a list of numbers, removing duplicates from a list, cropping an image)
//However, some image filters required the original image to be in tact while 
//calculating the new image (edge detection) and this is a good practice unless 
//we are specifically told to modify the original data.

//We will now make functions that take any PImage, make a new image to store the 
//modifications, and return that new image. 
PImage randomNoise(PImage original) {
  //NEW STEP!!!!!!
  //We want to stop modifying the original image, instead make a
  //separate PImage with the same dimensions.
  PImage result = new PImage(original.width, original.height);
  
  //use nested loops to touch every x,y of the image. 
  for (int x = 0; x < original.width; x ++) {
    for (int y = 0; y < original.height; y++) {
      //NOTE:
      //This section is the part that makes changes! 
      //It is the only thing you do differently in different filters.

      //get the original image's pixel color
      color pixelColor = original.get(x, y);

      //decide what to do with it. Sometimes you do the same thing to all (like grayscale)
      //othertimes you do 2 or more different things using conditionals (like edge detection)
      if(random(3) < 2){
        //copy over the original color (66.6% of the time)
        result.set(x, y, pixelColor);
      }else{
        //copy over a random color 
        result.set(x,y, color(random(255),random(255),random(255)));
      }
    }
  }
  return result;
}
