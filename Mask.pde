void setMask() {
  imgMask = createGraphics(width, height);
  imgMask.beginDraw();
  imgMask.background(0);
  imgMask.fill(255);
  imgMask.noStroke();
  //imgMask.rectMode(CORNERS);
  //imgMask.rect(100, 100, 700, 700);
  imgMask.circle(width / 2, height / 2, width / 1.1);
  imgMask.fill(0);
  //imgMask.stroke(0);
  //imgMask.strokeWeight(40);
  //imgMask.circle(width / 2, height / 2, width / 1.7);
  int border = 300;
  imgMask.triangle(width / 2, border,
                   border, height - border,
                   width - border, height - border);
  imgMask.endDraw();
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
