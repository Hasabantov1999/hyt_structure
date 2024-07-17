import 'package:flutter/material.dart';

class CircleGradient extends StatelessWidget {
  const CircleGradient({super.key, required this.size, required this.gradient});
  final double size;
  final LinearGradient gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
      ),
    );
  }
}
