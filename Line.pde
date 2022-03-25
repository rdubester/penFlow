void penStroke(PVector a, PVector b, float p, float o, float w, PGraphics g) {
  p *= stroke_jitter;
  g.strokeCap(ROUND);
  g.strokeWeight(w * map(noise(p + o), 0, 1, minStroke, maxStroke));
  g.line(a.x, a.y, b.x, b.y);
}

void penAlong(ArrayList<PVector> points, int offset, float w, PGraphics g) {
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
    int x = 2 * (int) constrain(b.x, 0, width-1);
    int y = 2 * (int) constrain(b.y, 0, height-1);
    if (imgMask.pixels[(y * pixelWidth + x)] == color(0)) continue;
    if (i == numPoints - 2) {
      splatter(a, b, offset);
    } else {
      penStroke(a,b,p,offset,w, g);
    }
  }
}

void splatter(PVector a, PVector b, int offset) {
  if (offset % 6 == 0) {
    PVector dir = PVector.sub(b, a).mult(random(2, 5));
    PVector sp = PVector.lerp(a, b, 0.5).add(dir);
    g.strokeWeight(random(2, 3));
    g.point(sp.x, sp.y);
  }
}

void drawLines(color[] colors) {
  drawLines(colors, colors);
}

float thresh = 0.3;
void drawLines(color[] colors1, color[] colors2) {
  g = createGraphics(width, height);
  g.beginDraw();
  g.background(0, 0);
  imgMask.loadPixels();
  for (PVector start : start_points) {
    int offset = (int) (start.x * start.y);
    color c1 = colors1[offset % colors1.length];
    color c2 = colors2[offset % colors2.length];
    float a = 1 - (start.y / height) - 0.3;
    color c = lerpColor(c1, c2, 2 * a);
    g.stroke(c);
    penAlong(trajectory(start, steps), offset, 1.5,  g);
    g.stroke(255);
    penAlong(trajectory(start, steps), offset, 0.5, g);
  }
  //subtractiveMask(g, imgMask);
  g.endDraw();
  image(g, 0, 0);
}
