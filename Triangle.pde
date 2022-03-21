void setTriangle() {
  tri_center = new PVector(width / 2, height / 1.8);
  PVector disp = PVector.fromAngle(-TAU / 4).mult(width / 2);
  v1 = PVector.add(tri_center, disp);
  v2 = PVector.add(tri_center, disp.rotate(TAU / 3));
  v3 = PVector.add(tri_center, disp.rotate(TAU / 3));
  tri = new ArrayList();
  tri.add(v1);
  tri.add(v2);
  tri.add(v3);
}


float sign (PVector p1, PVector p2, PVector p3)
{
  return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}

boolean pointInTriangle (PVector pt, PVector v1, PVector v2, PVector v3)
{
  float d1, d2, d3;
  boolean has_neg, has_pos;

  d1 = sign(pt, v1, v2);
  d2 = sign(pt, v2, v3);
  d3 = sign(pt, v3, v1);

  has_neg = (d1 < 0) || (d2 < 0) || (d3 < 0);
  has_pos = (d1 > 0) || (d2 > 0) || (d3 > 0);

  return !(has_neg && has_pos);
}
