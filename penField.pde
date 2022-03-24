int density = 2;
int width_, height_;

PGraphics bg;
float bgScale = 0.07;
//int bgDark    = #dbcfb9;
//int bgLight   = #e7dbc4;
int bgDark    = #f5eddf;
int bgLight   = #fffdf5;


PGraphics imgMask;
PGraphics g;

PVector[][] field;
int rows, cols;
float fieldScale = 0.003;
float fieldMag   = 20;
int fieldRes     = 5;
int weird        = 5;

PVector[] starts;
int numLines = 7000;
int steps    = 80;

float stroke_jitter = 5;
float angle_jitter  = 1;
float disp_jitter   = 1;
float disp_mag      = 0;
//color[] lineColors = {#4E2B21, #2C151A, #330E05};
color[] lineColors = {#0634b6, #0c33a0};

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
  noiseSeed(seed);
  //noiseSeed(71766);
  //noiseSeed(87845);
  noiseSeed(18030);
}

void restart() {

  setRandom();
  setField(0);
  setStartPoints();
  drawn = false;
}

float noise_offset = 0;
float noise_delta = 0.001;

boolean drawn = false;

void draw_() {
  drawBG();
  setMask();
  setField(0);
  drawLines(false);

  setMask2();
  //rotate90(field);
  slowTwist(field);
  drawLines(true);

  //fieldScale = 0.004;
  //slowTwist(field);
  //renderField(0);
  //noise_offset += noise_delta;
  drawn = true;
}
void draw() {
  if (!drawn) {
   draw_(); 
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
