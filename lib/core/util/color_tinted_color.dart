import 'dart:ui';

Color createTintedColor(Color originalColor, double factor) {
  int red = (originalColor.red * factor).round();
  int green = (originalColor.green * factor).round();
  int blue = (originalColor.blue * factor).round();

  // Renk değerlerini sınırlayın (0 ile 255 arasında)
  red = red.clamp(0, 255);
  green = green.clamp(0, 255);
  blue = blue.clamp(0, 255);

  return Color.fromARGB(originalColor.alpha, red, green, blue);
}