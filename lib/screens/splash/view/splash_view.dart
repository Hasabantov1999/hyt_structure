import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:stacked/stacked.dart';

import '../../../gen/assets.gen.dart';
import '../../../public/gradient_palette.dart';
import '../controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => SplashController(context: context),
      onViewModelReady: (controller)=>controller.init(),
      builder: (context, controller, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: GradientPalette.splashGradiant,
                  ),
                ),
              ),
              FadeInUp(
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    Assets.svg.splashLogo,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
