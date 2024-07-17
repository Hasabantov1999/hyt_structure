import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fast_structure/core/components/app_button.dart';
import 'package:fast_structure/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';

import 'package:typewritertext/typewritertext.dart';

import '../../app/base_widgets/loading_widget.dart';
import '../../gen/assets.gen.dart';

Future showCase({required String message, VoidCallback? onPressed}) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return Navigator.of(navigatorKey.currentContext!).push(
    PageRouteBuilder(
      opaque: false, // set to false
      pageBuilder: (_, __, ___) => _AppShowCase(
        message: message,
        onPressed: onPressed,
      ),
    ),
  );
}

class _AppShowCase extends StatelessWidget {
  const _AppShowCase({
    required this.message,
    this.onPressed,
  });

  final String message;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> onPlay = ValueNotifier(true);
    Future.delayed(
      Duration(milliseconds: message.length * 30),
      () async {
        onPlay.value = false;
      },
    );
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Positioned.fill(
            child: TweenAnimationBuilder<Color?>(
              tween: ColorTween(begin: Colors.transparent, end: Colors.black87),
              curve: Curves.linear,
              duration: const Duration(milliseconds: 300),
              builder: (context, color, child) {
                return Container(
                  color: color,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: onPlay,
                        builder: (context, animate, child) {
                          return Lottie.asset(
                            Assets.json.aiSpeaking,
                            width: 100.w,
                            height: 120.h,
                            animate: animate,
                            fit: BoxFit.fill,
                          );
                        }),
                    Container(
                      padding: EdgeInsets.all(10.w),
                      width: 240.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: context.radius,
                      ),
                      child: TypeWriterText.builder(
                        message,
                        duration: const Duration(milliseconds: 30),
                        builder: (context, value) {
                          return AutoSizeText(
                            value,
                            maxLines: 5,
                            minFontSize: 2.0,
                          );
                        },
                      ),
                    )
                  ],
                ),
                FadeInRightBig(
                  delay: Duration(milliseconds: message.length * 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        width: 100.w,
                        onPressed: () async {
                          context.pop();
                        },
                        text: "Sonraki",
                        overload: ButtonOverload.standart,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      if (onPressed != null)
                        AppButton(
                          width: 100.w,
                          onPressed: () async {
                            context.pop();
                            if (onPressed != null) {
                              onPressed!();
                            }
                          },
                          text: "Devam Et",
                          overload: ButtonOverload.standart,
                        ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
