void donutMask(float x, float y, float outer, float inner) {
  imgMask = createGraphics(width, height);
  imgMask.beginDraw();
  imgMask.background(0);

  imgMask.noStroke();
  imgMask.fill(255);
  imgMask.circle(x, y, width * outer);
  imgMask.fill(0);
  imgMask.circle(x, y, width * inner);
  imgMask.endDraw();
}

void circleMask(float x, float y, float rad) {
  imgMask = createGraphics(width, height);
  imgMask.beginDraw();
  imgMask.background(0);
  imgMask.noStroke();
  imgMask.fill(255);
  imgMask.circle(x, y, width * rad);
  //imgMask.fill(0);
  //imgMask.circle(width / 2, height / 5, width / 5);
}

void noMask() {
  imgMask = createGraphics(width, height);
  imgMask.beginDraw();
  imgMask.background(255);
  imgMask.endDraw();
}

void invertMask(){
  imgMask.filter(INVERT);
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
