float offset() {
  gOffset += 10;
  return gOffset;
}

void penStroke(PVector a, PVector b, float p, float o) {
  p*= 10;
  stroke(#532218);
  //stroke(#f8feff);
  //stroke(#202124);
  strokeCap(SQUARE);
  strokeWeight(map(noise(p + o), 0, 1, minStroke, maxStroke));
  line(a.x, a.y, b.x, b.y);
}

void penAlong(ArrayList<PVector> points, boolean closed) {
  float o = offset();
  int numPoints = points.size();
  for (int i = 0; i < numPoints; i++) {
    float a = (i + o) / (float) numPoints * TAU;
    float theta = noise(j * sin(a), j * cos(a)) * TAU;
    float d = noise(j * sin(a), j * cos(a)) * m;
    PVector v = PVector.fromAngle(theta).mult(d);
    points.get(i).add(v);
  }
  for (int i = 0; i < numPoints - 1; i++) {
    float p = i / (float) numPoints;
    PVector a = points.get(i);
    PVector b = points.get(i+1);

    //if (!pointInTriangle(b, v1, v2, v3)) break;
    if (PVector.sub(b, center).mag() > width / 2.2) break;
    penStroke(a, b, p, o);
  }
  if (closed) {
    penStroke(points.get(numPoints - 1), points.get(0), 0, o);
  }
}
