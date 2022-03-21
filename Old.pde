void drawCircles() {
  for (int r = 10, d = 10; r<360; r += d, d+=1) {
    ArrayList<PVector> points = pointCircle(width / 2, height / 2, r, 200);
    penAlong(points, true);
  }
}

ArrayList<PVector> pointCircle(float x, float y, float r, int numPoints) {
  ArrayList<PVector> c = new ArrayList();
  for (int i = 0; i < numPoints; i++) {
    float theta = TAU * i / numPoints;
    c.add(new PVector(r * sin(theta) + x, r * cos(theta) + y));
  }
  return c;
}

//translate(-width/4, -height/4);
//scale(1.5);
//penAlong(tri, true);
