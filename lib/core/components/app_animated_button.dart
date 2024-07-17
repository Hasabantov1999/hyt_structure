import 'package:fast_structure/public/color_palette.dart';
import 'package:flutter/material.dart';



class MaterialIconButton extends StatelessWidget {
  const MaterialIconButton({
    required this.child,
    super.key,
    this.color,
    this.onPressed,
    this.onTapDown,
  });

  final Color? color;
  final Widget child;

  final void Function()? onPressed;

  final void Function(TapDownDetails details)? onTapDown;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onPressed,
      onTapDown: onTapDown,
      child: Container(
        width: kMinInteractiveDimension / 2,
        height: kMinInteractiveDimension / 2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorPalette.mainColors.blue,
        ),
        child: child,
      ),
    );
  }
}
