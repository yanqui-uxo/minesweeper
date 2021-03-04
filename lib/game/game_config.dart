class GameConfig {
  String title;
  int width;
  int height;
  int mines;

  GameConfig(this.title, this.width, this.height, this.mines);

  @override
  String toString() {
    return '$title (${width}x$height, $mines mines)';
  }
}