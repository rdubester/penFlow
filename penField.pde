PGraphics bg;
float bgScale = 0.07;
int bgDark = #dbcfb9;
int bgLight = #e7dbc4;

float gOffset = 10;

PVector[][] field;
int rows, cols;
int fieldRes = 5;
float fieldScale = 0.002;
float fieldMag = 20;
int weird = 10;

int numLines = 6000;
int steps = 100;
float j = 1;
float m = 0;
float minStroke = 1.2;
float maxStroke = 2.1;

int seed = 123;
PVector center;
PVector tri_center;
ArrayList<PVector> tri;
PVector v1, v2, v3;
PVector[] starts;

void setup() {

  size(900, 900);
  smooth(8);
  center = new PVector(width / 2, height / 2);
  setTriangle();
  setBG();
  restart();
}

void setRandom() {
  seed = (int) random(100000);
  noiseSeed(seed);
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
