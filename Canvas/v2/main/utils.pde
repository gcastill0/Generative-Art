float randomIter(float min, float max, int iter) {
  float val = 0;
  for (int i = 0; i < iter; i++) {
    val+= random(min, max);
  }
  return val/iter;
}