void penStroke(PVector a, PVector b, float p, float o, PGraphics g) {
  p *= stroke_jitter;
  //g.stroke(#532218);
  //int color_idx = (int) (noise(p + 0) * 10) % 3;
  //g.blendMode(MULTIPLY);
  g.strokeCap(ROUND);
  g.strokeWeight(map(noise(p + o), 0, 1, minStroke, maxStroke));
  g.line(a.x, a.y, b.x, b.y);
}

void penAlong(ArrayList<PVector> points, int offset, boolean closed, PGraphics g) {
  int numPoints = points.size();
  for (int i = 0; i < numPoints; i++) {
    // noise coordinate
    float a = i / (float) numPoints;
    float t = (a + offset) * TAU;
    float theta = TAU * noise(
      angle_jitter * sin(t),
      angle_jitter * cos(t));
    float d =  disp_mag * noise(
      disp_jitter * sin(a),
      disp_jitter * cos(a));
    PVector v = PVector.fromAngle(theta).mult(d);
    points.get(i).add(v);
  }
  for (int i = 0; i < numPoints - 1; i++) {
    float p = i / (float) numPoints;
    PVector a = points.get(i);
    PVector b = points.get(i+1);
    penStroke(a, b, p, offset, g);
  }
  if (closed) {
    penStroke(points.get(numPoints - 1), points.get(0), offset, 0, g);
  }
}
