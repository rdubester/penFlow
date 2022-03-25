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
