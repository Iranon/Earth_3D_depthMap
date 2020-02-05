PImage ref;
int cellSize = 2;  //size of the image cells (unit-like)
int cols, rows;  //columns and rows of the image (useful to scan the reference image)
int[] palette = new int[6];
color c;  //fill color
float mouseCorrection;

void setup() {
  size(1440, 720, P3D);
  ref = loadImage("EarthBump.png"); //Image from: http://www.shadedrelief.com/natural3/index.html
  cols = width/cellSize;  //number of columns (depending on the unit size)
  rows = height/cellSize;  //number of rows (depending on the unit size)
  
  assignColors();
  
}

void draw() {
  background(0,32,128);
  ref.loadPixels();  //loading pixels value of the reference image
                     //into the pixels[] monodimensional array
  
  //Scan the image through columns and rows
  for(int v = 0; v < cols; v+=1) {
    for(int u = 0; u < rows; u+=1) {
      int x = v * cellSize + cellSize/2;  //x position
      int y = u * cellSize + cellSize/2;  //y position
      
      int pos = x + (y * width);  //pixel array position
      
      //color refColor = ref.pixels[pos];  //RGB value of the reference image in the current position
      
      //Initialize depth value (z) depending on the brightness value
      float z = brightness(ref.pixels[pos]) * 0.8;
      
      //Translate in order to draw at the correct location inside 3D space
      pushMatrix();
      translate(x, y, z);
      mouseCorrection = map(mouseX, 0, width, 0, 120);
      fill(c + color(mouseCorrection));
      noStroke();
      ellipse(0, 0, cellSize, cellSize);
      popMatrix();
    }
  }
  
  if (keyPressed) {
    if (key == 's' || key == 'S') {
      save("Earth_Depth_3DMap.png");
    }
  }
  
  if (keyPressed) {
    if (key == 'r' || key == 'R') {
      assignColors();
    }
  }
  
}

void assignColors(){
  for(int pIndex = 0; pIndex < palette.length; pIndex++){
    palette[pIndex] = int(random(8,180) + random(75));
  }
  
  int r = lerpColor(palette[0], palette[1], 0.5);
  int g = lerpColor(palette[2], palette[3], 0.5);
  int b = lerpColor(palette[4], palette[5], 0.5);
  int a = int(random(220, 254));
  //Left shifting
  a = a << 24;
  r = r << 16;
  g = g << 8;
  c = a | r | g | b;
}
