// ignore_for_file: use_build_context_synchronously

import 'package:fast_structure/core/components/app_button.dart';

import 'package:fast_structure/gen/assets.gen.dart';
import 'package:fast_structure/public/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/base_widgets/loading_widget.dart';
import '../../public/color_palette.dart';
import '../../public/radius_palette.dart';
import 'app_text.dart';

class AppAlert {
  static Future<T> show<T>({
    required String description,
    String? title,
    String? descrutiveCancelText,
    String? activeText,
    VoidCallback? whenCancelPressed,
    dynamic whenActivePressed,
    bool descrutiveEnabled = false,
  }) async {
    return await navigatorKey.currentContext?.modalPush(_AppAlertWidget(
      description: description,
      title: title,
      descrutiveCancelText: descrutiveCancelText,
      activeText: activeText,
      whenCancelPressed: whenCancelPressed,
      whenActivePressed: whenActivePressed,
      descrutiveEnabled: descrutiveEnabled,
    ));
  }
}

class _AppAlertWidget extends StatelessWidget {
  const _AppAlertWidget({
    required this.description,
    this.title,
    this.descrutiveCancelText,
    this.activeText,
    this.whenCancelPressed,
    this.whenActivePressed,
    this.descrutiveEnabled = false,
  });
  final String description;
  final String? title;
  final String? descrutiveCancelText;
  final String? activeText;
  final VoidCallback? whenCancelPressed;
  final dynamic whenActivePressed;
  final bool descrutiveEnabled;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 386.w,
        height: 300.h,
        margin: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + 20.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: RadiusPalette.radius40,
        ),
        child: Material(
          borderRadius: RadiusPalette.radius40,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    Assets.svg.confetti,
                  ),
                  if (title != null)
                    Padding(
                      padding: context.initialHorizantalPadding,
                      child: AppText(
                        title ?? "",
                        style: const TextStyle(
                          color: Color(0xFF15203D),
                          fontSize: 22,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  AppText(
                    description,
                    textAlign: TextAlign.center,
                    width: 306.w,
                    maxLines: 7,
                    style: const TextStyle(
                      color: Color(0xFF677294),
                      fontSize: 14,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: context.initialHorizantalPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (descrutiveEnabled)
                          AppButton(
                            onPressed: () async {
                              if (whenCancelPressed != null) {
                                whenCancelPressed!();
                              }
                              context.pop(false);
                            },
                            text: descrutiveCancelText ?? "Vazgeç",
                            width: 162.w,
                            height: 39.h,
                            border:
                                Border.all(color: ColorPalette.mainColors.blue),
                            overload: ButtonOverload.standart,
                            backgroundColor: Colors.white,
                            textStyle: const TextStyle(
                              color: Color(0xFF5B96FC),
                              fontSize: 12,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        if (descrutiveEnabled) const Spacer(),
                        AppButton(
                          onPressed: () async {
                            if (whenActivePressed != null) {
                              await whenActivePressed!();
                            }
                            context.pop(true);
                          },
                          text: activeText ?? "Onayla",
                          width: 162.w,
                          height: 39.h,
                          overload: ButtonOverload.standart,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
              Positioned(
                top: -56.h,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.mainColors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: ColorPalette.mainColors.blue.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 10,
                        )
                      ]),
                  padding: EdgeInsets.all(20.w),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    Assets.svg.profile.infoSquare,
                    width: 82.w,
                    height: 82.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
