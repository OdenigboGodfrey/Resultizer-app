import 'dart:math';
import 'dart:ui';

Color generateRandomDarkColor() {
  // Generate random values for the red, green, and blue channels.
  int r = Random().nextInt(128);
  int g = Random().nextInt(128);
  int b = Random().nextInt(128);

  // Return a Color object with the generated values.
  return Color.fromRGBO(r, g, b, 1.0);
}