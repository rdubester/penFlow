void setBG() {
  bg = createGraphics(width_, height_);
  bg.beginDraw();
  bg.loadPixels();
  for (int x = 0; x < width_; x++) {
    for (int y = 0; y < height_; y++) {
      float n = noise(x * bgScale, y * bgScale);
      bg.pixels[y * width_ + x] = lerpColor(bgDark, bgLight, n);
    }
  }
  bg.updatePixels();
  bg.endDraw();
}

void drawBG() {
  blendMode(BLEND);
  image(bg, 0, 0);
}
