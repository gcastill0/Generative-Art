class Icon {
  PVector location;
  PImage icon;

  Icon(PVector l, PImage i) {
    this.location = l.copy();
    this.icon = i;
    // Relocation
    this.location.x -= 150;
    this.location.y -= 150;
  }

  void render() {
    this.icon.resize(300, 300);
    image(this.icon, this.location.x, this.location.y);
  }
}