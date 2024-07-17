import 'package:flutter/material.dart';

class GradientPalette {
 static LinearGradient get darkBlue => const LinearGradient(
        colors: [
          Color(0xff4069B0),
          Color(0xff2E4B7E),
        ],
      );
  static LinearGradient get activeBlueGradiant => LinearGradient(
        colors: [
          const Color(0xff5B96FC),
          const Color(0xff5B96FC).withOpacity(0),
        ],
      );
  static LinearGradient get blueGradiantLight => const LinearGradient(
        colors: [
          Color(0xff5B96FC),
          Color(0xff4978CA),
        ],
      );
  static LinearGradient get splashGradiant => const LinearGradient(
        colors: [
          Color(0xff4978CA),
          Color(0xff5B96FC),
        ],
      );
  static LinearGradient get white => LinearGradient(
        colors: [
          Colors.white,
          Colors.white.withOpacity(0),
        ],
      );
  static LinearGradient get whiteGray => const LinearGradient(
        colors: [
          Colors.white,
          Color(0xffDADADA),
        ],
      );
}
