void setField(float offset) {
  rows = height / fieldRes;
  cols = width / fieldRes;
  field = new PVector[rows][cols];
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      float theta = noise(x * fieldScale + offset, y * fieldScale + offset) * weird * TAU;
      field[y][x] = PVector.fromAngle(theta).mult(fieldMag);
    }
  }
}

void showField() {
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

void setStartPoints() {
  starts = new PVector[numLines];
  for (int i = 0; i < numLines; i++) {
    starts[i] = new PVector(random(width), random(height));
  }
}

float thresh = 0.3;

void drawLines(boolean gradient) {
  g = createGraphics(width, height);
  g.beginDraw();
  g.background(0, 0);
  for (PVector start : starts) {
    int offset = (int) (start.x * start.y);
    color s = lineColors[offset % 2];
    if (gradient) {
      float adjusted = 1 - (start.y / 800) - 0.3;
      s = lerpColor(s, #ff9d8b, 2 * adjusted);
      //s = lerpColor(s, 0, 2 * adjusted);
    }
    g.stroke(s);
    penAlong(trajectory(start, steps), offset, false, g);
  }
  //g.mask(imgMask);
  subtractiveMask(g, imgMask);
  g.endDraw();
  image(g, 0, 0);
}

void rotate90(PVector[][] field) {
  for (int i = 0; i < field.length; i++) {
    for (int j = 0; j < field[0].length; j++) {
      field[i][j].rotate(HALF_PI);
    }
  }
}

void slowTwist(PVector[][] field) {
  for (int i = 0; i < field.length; i++) {
    for (int j = 0; j < field[0].length; j++) {
      float y_dist = i / (float) field.length;
      //float thresh = 0.2059;
      float adjusted = 1 - y_dist - thresh;
      if (adjusted < 0) continue;
      if (j == 0) println(i, y_dist, adjusted, adjusted * adjusted);
      field[i][j].rotate(3 * TAU * adjusted * adjusted);
      field[i][j].mult(1 + 10 * adjusted * adjusted);
    }
  }
}
