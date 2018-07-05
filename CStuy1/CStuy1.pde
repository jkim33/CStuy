//CSTUY - DAY ONE
//NOTES BY JASON KIM

//NOTES: PROCESSING WINDOW, SHAPES & COLORS

/*
 size(800,700);
 //establishes screen size
 
 background(255);
 //colors in the background
 //covers EVERYTHING
 
 ellipse(width/2,height/2,100,50);
 //width and height are established variables after the use of the size command
 //ellipse expands from the center
 
 rect(width/2,height/2,200,100);
 //rect expands from the top left corner
 
 line(0,0,0,10,10,10);
 //creates a line using points (0,0,0) and (10,10,10)
 //can use line(x,y,x2,y2) to make a 2d line
 
 triangle(0,0,10,10,10,20);
 //creates a triangle using points (0,0), (10,10) and (10,20)
 
 quad(0,0,10,10,0,10,10,0);
 //creates a quadrilateral using points (0,0), (10,10), (0,10) and (10,0)
 
 arc(0,0,10,0,radians(0),radians(180);
 //creates an arc from (0,0) to (10,0) starting from 0 to pi
 
 fill(255,0,0,100);
 //tells you the color of the colors on the inside
 //4th parameter is optional (transparency)
 //affects all future shapes until changed again
 
 noStroke();
 //takes away the border
 //affects all future shapes until changed again
 
 stroke(0,0,255);
 //colors the border
 //affects all future shapes until changed again
 
 strokeWeight(10);
 //changes the border weight
*/



//NOTES: JAVA SYNTAX

/*
 Data Types:
 -int
 -float
 
 Variables:
 -variables within a function are called local variables
 -local variables can only be accessed and altered within the function
 -variables outside functions are called global variables
 -any function can alter and use global variables
 
 Instantiation and Initialization:
 -int num;
 -this is instantiation, we have now declared a variable named num, that will hold an int
 -num = 20;
 -this is initialization, we have given num a value
 
 Operations:
 -we use +,-,/,*,%
 -to change a variable, we muust do something like this:
 -int num = 20;
 -num = num+20;
 -if we just want to use a variation of num, we can do something like this:
 -int num = 20;
 -rect(0,num+20,40,40);
 
 Semicolon:
 -statements are separated by semicolons
 
 Function:
 -there are 3 main parts
   -return type
     -int,float,etc.
     -void means it returns nothing
   -function name
   -parameters
     -parameters are important for allowing you to input data for the function to use and manipulate
 -example: int add (int one, int two) { return one + two; }
 
 Conditionals:
 -if(condition) { body; }
 -else if(condition for when previous if or else if fails) { body; }
 -else { body ran if all previous conditions fail; }
 
 Typecasting:
 -allows you to change from one data type to another
 -example: (int)25.38 -> 25
*/



//NOTES: PROCESSING

/*
 setup() { body; }
 -runs the body once when the program is initially ran
 
 draw() { body; }
 -this function is repeatedly called and loops after setup
 
 mousePressed() { body; }
 -runs body when mouse is pressed
 
 random(0,255);
 -gives a random float between 0 and 255
 
 mouseX, mouseY
 -these are variables that will give you the current x and y coor of the mouse
*/



//DEMO - STICK FIGURE

/*
 int x = 500;
 int y = 550;
 
 size(1000,1000);
 
 fill(75,0,47);
 stroke(0,200,17);
 rect(x-100,y-200, 200,400);
 //Body
 
 fill(0,57,1);
 rect(x-75,y+200,50,100);
 rect(x+25,y+200,50,100);
 //Legs
 
 stroke(255,0,150);
 strokeWeight(20);
 line(x-100,y-100, x-200,y);
 line(x+100,y-100, x+200,y); 
 //Arms
 
 stroke(0,0,0);
 line(x,y-200,x,y-230);
 //Neck
 
 noStroke();
 triangle(x-100,y-230,x+100,y-230,x,y-450);
 fill(255,0,0);
 ellipse(x-50,y-300,25,25);
 ellipse(x+50,y-300,25,25);
 //Head
*/



//FUNCTIONS & USING PROCESSING 
//This is ran when the play button is pressed

float x;
float y;

int x1;
int y1;
int x2;
int y2;
int x3;
int y3;

int c11;
int c12;
int c13;
int c21;
int c22;
int c23;
int c31;
int c32;
int c33;

int tick;
int back;

void setup() {
  size(1000, 1000);
  back =255;
  background(back);
  x = 500;
  y = 550;
  tick = 0;
  x1 = (int)random(0, 1000);
  y1 = (int)random(0, 1000);
  x2 = (int)random(0, 1000);
  y2 = (int)random(0, 1000);
  x3 = (int)random(0, 1000);
  y3 = (int)random(0, 1000);
}

void draw() {
  if (tick%10 == 0) {
    c11 = (int)random(0, 255);
    c12 = (int)random(0, 255);
    c13 = (int)random(0, 255);
    c21 = (int)random(0, 255);
    c22 = (int)random(0, 255);
    c23 = (int)random(0, 255);
    c31 = (int)random(0, 255);
    c32 = (int)random(0, 255);
    c33 = (int)random(0, 255);
  }
  background(back);
  makeFigure(x1, y1, c11, c12, c13);
  makeFigure(x2, y2, c21, c22, c23);
  makeFigure(x3, y3, c31, c32, c33);
  makeFigure(mouseX, mouseY, (int)random(0, 255), (int)random(0, 255), (int)random(0, 255) );
  tick++;
}

void makeFigure(int coorX, int coorY, int color1, int color2, int color3) {
  x = coorX;
  y = coorY;

  strokeWeight(random(1, 10));
  fill(color1, color2, color3);
  stroke(color2, color3, color1);
  rect(x-100, y-200, 200, 400);
  //Body

  fill(color3, color1, color2);
  rect(x-75, y+200, 50, 100);
  rect(x+25, y+200, 50, 100);
  //Legs

  stroke(color1, color2, color3);
  strokeWeight(random(1, 10));
  line(x-100, y-100, x-200, y);
  line(x+100, y-100, x+200, y); 
  //Arms

  stroke(color2, color3, color1);
  line(x, y-200, x, y-230);
  //Neck

  noStroke();
  triangle(x-100, y-230, x+100, y-230, x, y-450);
  fill(color3, color2, color1);
  ellipse(x-50, y-300, 25, 25);
  ellipse(x+50, y-300, 25, 25);
  //Head
}

void mousePressed() {
  back = (int)random(0, 255);
}
