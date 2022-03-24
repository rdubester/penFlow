void setMask() {
  imgMask = createGraphics(width, height);
  imgMask.beginDraw();
  imgMask.background(0);

  imgMask.noStroke();
  imgMask.fill(255);
  imgMask.circle(width / 2, height / 2, width / 1.1);
  imgMask.fill(0);
  imgMask.circle(width / 2, height / 2, width / 1.7);
  //imgMask.fill(255);
  //imgMask.circle(width / 2, height / 5, width / 5);

  imgMask.endDraw();
}

void setMask2() {
  imgMask = createGraphics(width, height);
  imgMask.beginDraw();
  imgMask.background(0);
  imgMask.noStroke();
  imgMask.fill(255);
  imgMask.circle(width / 2, height / 2, width / 1.7);
  //imgMask.fill(0);
  //imgMask.circle(width / 2, height / 5, width / 5);
}

void subtractiveMask(PGraphics graphics, PGraphics mask) {
  graphics.loadPixels();
  mask.loadPixels();
  for (int i = 0; i < graphics.pixels.length; i++) {
    int baseCol = graphics.pixels[i];
    float baseAlpha = alpha(baseCol);
    int maskCol = mask.pixels[i];
    float maskAlpha = blue(maskCol);
    float newAlpha = min(baseAlpha, maskAlpha);
    graphics.pixels[i] = color(red(baseCol),
      green(baseCol),
      blue(baseCol),
      newAlpha);
  }
  graphics.updatePixels();
}
