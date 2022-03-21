class Particle {

  float maxSpeed = 1;

  PVector pos, vel, acc;

  Particle (PVector pos) {
    this.pos = pos.copy();
    this.vel = new PVector();
    this.acc = new PVector();
  }

  void update() {
    this.vel.add(this.acc);
    this.vel.limit(maxSpeed);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }

  boolean applyField() {
    int x = (int) (this.pos.x / fieldRes);
    int y = (int) (this.pos.y / fieldRes);
    if (x < 0 || x >= cols || y < 0 || y >= rows) return false;
    PVector force = field[y][x];
    //println(this.pos, x,y,force);
    this.acc.add(force);
    return true;
  }
}
