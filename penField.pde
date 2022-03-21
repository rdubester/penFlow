float bgScale = 0.07;
int bgDark = #dbcfb9;
int bgLight = #e7dbc4;
float gOffset = 10;

PGraphics bg;

PVector[][] field;
int fieldRes = 5;
int rows, cols;
float fieldScale = 0.002;
float fieldMag = 20;

int numLines = 6000;
int steps = 100;

int weird = 10;

float j = 1;
float m = 0;
//float minStroke = 0.8;
//float maxStroke = 1.2;
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
  createBG();

  center = new PVector(width / 2, height / 2);
  tri_center = new PVector(width / 2, height / 1.8);
  PVector disp = PVector.fromAngle(-TAU / 4).mult(width / 2);
  v1 = PVector.add(tri_center, disp);
  v2 = PVector.add(tri_center, disp.rotate(TAU / 3));
  v3 = PVector.add(tri_center, disp.rotate(TAU / 3));
  tri = new ArrayList();
  tri.add(v1);
  tri.add(v2);
  tri.add(v3);

  rows = height / fieldRes;
  cols = width / fieldRes;


  starts = new PVector[numLines];
  for (int i = 0; i < numLines; i++) {
    starts[i] = new PVector(random(width), random(height));
  }
  oneShot();
}

void drawLines() {
  blendMode(MULTIPLY);
  for (PVector start : starts) {
    penAlong(trajectory(start, steps), false);
  }
}

void createField(float offset) {
  field = new PVector[rows][cols];
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      float theta = noise(x * fieldScale + offset, y * fieldScale + offset) * weird * TAU;
      field[y][x] = PVector.fromAngle(theta).mult(fieldMag);
    }
  }
}

void drawBG() {
  blendMode(BLEND);
  image(bg, 0, 0);
}

void setRandom() {
  seed = (int) random(100000);
  noiseSeed(seed);
}

void oneShot() {
  setRandom();
  createField(0);
}

ArrayList<PVector> trajectory(PVector start, int steps) {
  ArrayList<PVector> path = new ArrayList();
  Particle p = new Particle(start);
  for (int i = 0; i < steps; i++) {
    boolean active = p.applyField();
    if (!active) break;
    p.update();
    path.add(p.pos.copy());
  }
  return path;
}

void createBG() {
  bg = createGraphics(width, height);
  bg.beginDraw();
  bg.loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float n = noise(x * bgScale, y * bgScale);
      bg.pixels[y * width + x] = lerpColor(bgDark, bgLight, n);
    }
  }
  bg.updatePixels();
  bg.endDraw();
}

void drawField() {
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      PVector v = field[y][x];
      push();
      translate(x * fieldRes, y * fieldRes);
      stroke(0);
      strokeWeight(1.2);
      line(0, 0, v.x, v.y);
      pop();
    }
  }
}

float noise_offset = 0;
float noise_delta = 0.001;
void draw() {
  createField(noise_offset);
  drawBG();
  drawLines();
  noise_offset += noise_delta;
}

void keyPressed() {
  if (keyPressed) {
    if (key == 's') {
      println(seed);
      saveFrame(String.format("out/%d.png", seed));
    }
    if (key == 'r') {
      oneShot();
    }
  }
}
