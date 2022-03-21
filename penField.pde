PGraphics bg;
float bgScale = 0.07;
int bgDark = #dbcfb9;
int bgLight = #e7dbc4;

PGraphics imgMask;
PGraphics g;

float gOffset = 10;

PVector[][] field;
int rows, cols;
int fieldRes = 5;
float fieldScale = 0.002;
float fieldMag = 20;
int weird = 10;

PVector[] starts;
int numLines = 6000;
int steps = 100;
float j = 1;
float m = 0;
float minStroke = 1.2;
float maxStroke = 2.1;

int seed = 123;

void setup() {

  size(800, 800);
  smooth(8);
  setBG();
  setMask();
  restart();
}

void setRandom() {
  seed = (int) random(100000);
  noiseSeed(seed);
  //noiseSeed(81464);
}

void restart() {
  setRandom();
  setField(0);
  setStartPoints();
}

float noise_offset = 0;
float noise_delta = 0.001;
void draw() {
  setField(noise_offset);
  drawBG();
  drawLines();
  //noise_offset += noise_delta;
  //noLoop();
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
