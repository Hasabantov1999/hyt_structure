import 'package:another_flushbar/flushbar.dart';
import 'package:fast_structure/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/base_widgets/loading_widget.dart';
import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';
import '../../public/radius_palette.dart';
import 'app_text.dart';

class AppTopAlert {
  static Future<void> show({
    required String description,
    String? title,
  }) async {
    final bar = Flushbar(
      backgroundColor: ColorPalette.mainColors.blue,
      borderRadius: RadiusPalette.radius10,
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.only(top: 20.h),
      boxShadows: kElevationToShadow[1],
      messageText: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.svg.splashLogo,
              width: 54,
              height: 41,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  AppText(
                    title,
                    width: 250.w,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                AppText(
                  description,
                  width: 250.w,
                  maxLines: 5,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      messageSize: navigatorKey.currentContext!.width - 40,
      flushbarPosition: FlushbarPosition.TOP,
      maxWidth: navigatorKey.currentContext!.width - 40,
      duration: const Duration(seconds: 3),
    );
    bar.show(
      navigatorKey.currentState!.context,
    );
  }
}
