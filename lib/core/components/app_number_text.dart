import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../public/text_styles.dart';


class AppNumberText extends StatelessWidget {
  const AppNumberText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.minFontSize,
    this.maxFontSize,
    this.width,
    this.textOverflow,
  });
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final dynamic data;
  final double? minFontSize;
  final double? maxFontSize;
  final double? width;
  final TextOverflow? textOverflow;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      NumberFormat.currency(symbol: "₺", decimalDigits: 0)
          .format(double.parse(data.toString())),
      textAlign: textAlign,
      style: style ?? AppTextStyles.numberStyles,
      maxLines: maxLines,
      maxFontSize: maxFontSize ?? double.infinity,
      minFontSize: minFontSize ?? 8,
      overflow: textOverflow ?? TextOverflow.ellipsis,
    );
  }
}
