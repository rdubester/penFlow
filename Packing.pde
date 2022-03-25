ArrayList<PVector> uniform() {
  ArrayList<PVector> points = new ArrayList();
  for (int i = 0; i < numLines; i++) {
    points.add(new PVector(random(width), random(height)));
  }
  return points;
}


ArrayList<PVector> packed() {
  int num_candidates = 50;
  float r = 15; // min distance between points
  float cell_size = r / sqrt(2); // ensures each cell contains at most one sample
  int grid_rows = (int) (height / cell_size); 
  int grid_cols = (int) (width / cell_size);
  // holds the placed points
  PVector[][] cells = new PVector[grid_rows][grid_cols];
  boolean[][] occupied = new boolean[grid_rows][grid_cols];
  
  // create active and inactive arrays, and seed with a random starting point
  ArrayList<PVector> active = new ArrayList();
  ArrayList<PVector> inactive = new ArrayList();
  PVector initial = new PVector(random(width), random(height));
  active.add(initial);
  
  // while there are still active points
  while (active.size() > 0) {
    // select an active point at random
    int sample_idx = (int) random(0, active.size());
    PVector sample = active.get(sample_idx);
    // attempt to place a new point near the current sample
    // if this fails, the sample will be marked inactive
    boolean placed_new = false;
    for (int c = 0; c < num_candidates; c++){
      // generate a new candidate point within an annulus of the sample
      float theta = random(0, TAU);
      float mag = random(r, 2*r);
      PVector candidate = PVector.add(sample, PVector.fromAngle(theta).mult(mag));
      // determine where this candidate lies on the grid
      int candidate_row = (int) (candidate.y / cell_size);
      int candidate_col = (int) (candidate.x / cell_size);
      if (candidate.x < 0 || candidate.x >= width ||
          candidate.y < 0 || candidate.y >= height) continue;
      if (candidate_row < 0 || candidate_row >= grid_rows ||
          candidate_col < 0 || candidate_col >= grid_cols) continue;
      // check whether this point is too close to any already placed points 
      boolean collision = false;
      for (int i = -1; (i < 2) && !collision; i++) {
        for (int j = -1; j < 2; j++) {
          int row = candidate_row + i;
          int col = candidate_col + j;
          if (row < 0 || row >= grid_rows || col < 0 || col >= grid_cols) continue;
          if (!occupied[row][col]) continue;
          PVector neighbour = cells[row][col];
          if (candidate.dist(neighbour) < r) {
           collision = true;
           break;
          }
        }
      }
      // if collision is false we have succesfully placed a new point
      if (!collision) {
        placed_new = true;
        active.add(candidate);
        cells[candidate_row][candidate_col] = candidate;
        occupied[candidate_row][candidate_col] = true;
        break;
      }
    }
    // if no new point placed, set sample to inactive
    if (!placed_new) {
      inactive.add(sample);
      active.remove(sample_idx);
    }
  }
  // finally return all inactive points
  return inactive;
}
