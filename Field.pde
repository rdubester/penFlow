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

void drawLines() {
  g = createGraphics(width, height);
  g.beginDraw();
  //g.blendMode(MULTIPLY);
  g.background(0, 0);
  for (PVector start : starts) {
    penAlong(trajectory(start, steps), g, false);
  }
  //g.mask(imgMask);
  subtractiveMask(g, imgMask);
  g.endDraw();
  image(g, 0, 0);
}
