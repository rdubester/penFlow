void setBG() {
  bg = createGraphics(width, height);
  bg.beginDraw();
  bg.loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float n = noise(x * bgScale, y * bgScale);
      bg.pixels[y * width + x] = lerpColor(bgDark, bgLight, n);
    }
  }
  bg.updatePixels();
  bg.endDraw();
}

void drawBG() {
  blendMode(BLEND);
  image(bg, 0, 0);
}
