int density = 2;
int width_, height_;

PGraphics bg;
float bgScale = 0.07;
int bgDark    = #dbcfb9; // yellow-ish
int bgLight   = #e7dbc4;
//int bgDark    = #f5eddf;   // off-white
//int bgLight   = #fffdf5;

PGraphics imgMask;
PGraphics g;

PVector[][] field;
int rows, cols;
float fieldScale = 0.009;
float fieldMag   = 20;
int fieldRes     = 5;
int weird        = 3;

ArrayList<PVector> start_points;
//int numLines = 4000;
int numLines = 6950;
int steps    = 80;

float stroke_jitter = 5;
float angle_jitter  = 1;
float disp_jitter   = 1;
float disp_mag      = 0;
color[] sepia = {#4E2B21, #2C151A, #330E05}; // sepia
color[] blue = {#0634b6, #0c33a0}; // blue
color[] orange = {#ff9d8b, #ffae8b, #ffda8b}; // orange

float minStroke = 1.2;
float maxStroke = 2.4;

int seed = 123;

void setup() {

  size(800, 800);
  pixelDensity(density);
  smooth(10);
  width_ = width * density;
  height_ = height * density * 2;
  restart();
  setBG();
}

void setRandom() {
  seed = (int) random(100000);
  println(seed);
  noiseSeed(seed);
  //noiseSeed(71766); //pushing up to the surface
  //noiseSeed(87845); // flowing out of the center
  //noiseSeed(18030); // nice wave over the bottom
}

void restart() {

  setRandom();
  setField(0);
  start_points = packed();
  //start_points = uniform();
  //println(start_points.size());
  drawn = false;
}

float noise_offset = 0;
float noise_delta = 0.001;

boolean drawn = false;

void draw_() {
  
  drawBG();
  //draw_starts();
  
  //setField(0);
  //noMask();
  //donutMask(width / 2, height/2, 0.9, 0.6);
  //drawLines(sepia);
  
  setField(0);
  circleMask(width / 2, height/2, 0.9);
  //slowTwist(field);
  drawLines(sepia);
  //for (int i = 0; i < 20; i++) {
  //  strokeWeight(3);
  //  stroke(0);
  //  fill(255);
  //  circle(random(width * 0.9), random(height * 0.9), random(10, 20));
  //}
  //setField(100);
  //circleMask(width/2, height/2, 0.9);
  //invertMask();
  //drawLines(false);

  drawn = true;
}
void draw() {
  if (!drawn) {
   draw_(); 
  }
}

void draw_starts(){
  stroke(0);
  strokeWeight(3);
  for (PVector p : start_points) {
    point(p.x, p.y);
  }
}

void keyPressed() {
  if (keyPressed) {
    if (key == 's') {
      println(seed);
      saveFrame(String.format("out/%d.png", seed));
    }
    if (key == 'r') {
      println("reset");
      restart();
    }
  }
}
