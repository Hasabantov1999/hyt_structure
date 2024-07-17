import 'package:fast_structure/core/components/app_button.dart';
import 'package:fast_structure/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/base_widgets/loading_widget.dart';
import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';
import '../../public/radius_palette.dart';
import '../../services/hive_services/hive_services.dart';
import 'app_text.dart';


class AppDeleteItemDialog extends StatelessWidget {
  const AppDeleteItemDialog({
    super.key, required this.message, required this.title,
  });
  final String message;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 386.w,
        height: 295.h,
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
                    height: 100.h,
                    width: context.width,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: context.initialHorizantalPadding,
                    child:  AppText(
                      title,
                      style:const TextStyle(
                        color: Color(0xFF15203D),
                        fontSize: 22,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AppText(
                    message,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppButton(
                          onPressed: () async {
                            context.pop();
                          },
                          text: "Hayır, Geri Dön",
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
                        const Spacer(),
                        AppButton(
                          onPressed: () async {
                            setAppBusy(
                              true,
                              message: "Çıkış Yapılıyor",
                              delayAndFalseDuration: 2000,
                            );
                            LocalCacheService.instance.model()
                              ..accessToken = null
                              ..refreshToken = null
                              ..userModel = null
                              ..save();
                            context.pop();
                            Future.delayed(const Duration(milliseconds: 2000),
                                () {
                                  //TODO
                              // context.go(
                              //   const LoginView(),
                              // );
                            });
                          },
                          text: "Evet, Çıkış Yap",
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
