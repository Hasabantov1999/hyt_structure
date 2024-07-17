// ignore_for_file: unused_element, library_private_types_in_public_api

import 'package:flutter/material.dart';

class ColorPalette {
  static _MainColors mainColors = _MainColors();
  static _GrayColors grayColors = _GrayColors();
}

class _GrayColors {
  Color get borderGray => const Color(0xffD2D2D2);
  Color get softBlue => const Color(0xffE9EEF1);
  Color get blueDarkGray => const Color(0xff959CB4);
  Color get blueGray => const Color(0xff677294);
  Color get bgGray => const Color(0xffF8F8F9);
  Color get white => Colors.white;
  Color get grayBg => const Color(0xFFF2F3F5);
}

class _MainColors {
  Color get blue => const Color(0xff5B96FC);
  Color get darkBlue => const Color(0xff15203D);
  Color get yellow => const Color(0xffFCCF5B);
  Color get red => const Color(0xffFC5B5B);
  Color get green => const Color(0xff67CE67);
}
