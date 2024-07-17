import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../gen/assets.gen.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.backPressed});
  final VoidCallback? backPressed;
  @override
  Widget build(BuildContext context) {
    ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    if ((parentRoute?.impliesAppBarDismissal ?? false) || backPressed != null) {
      return IconButton(
        onPressed: () {
          if (backPressed != null) {
            backPressed!();
          } else {
            Navigator.pop(context);
          }
        },
        icon: SvgPicture.asset(
          Assets.svg.leftArrow,
          fit: BoxFit.contain,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
