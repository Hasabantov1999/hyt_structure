import 'dart:async';

import 'package:fast_structure/core/components/app_button.dart';
import 'package:fast_structure/public/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';
import '../../public/radius_palette.dart';
import 'app_text.dart';

class GetSmsCodeWidget extends StatefulWidget {
  const GetSmsCodeWidget({super.key, this.sendAgain, this.pinCount = 4});

  final VoidCallback? sendAgain;
  final int pinCount;

  @override
  State<GetSmsCodeWidget> createState() => _GetSmsCodeWidgetState();
}

class _GetSmsCodeWidgetState extends State<GetSmsCodeWidget> with CodeAutoFill {
  late DateTime startDateTime;
  late Timer counterTimer;
  ValueNotifier<int> seconds = ValueNotifier(180);
  ValueNotifier<bool> buttonAsync = ValueNotifier(false);
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    startDateTime = DateTime.now();
    SmsAutoFill().getAppSignature.then((value) {

    });
    startTimer();
    controller.addListener(
      () {
        if (controller.text != code) {
          code = controller.text;
        }
      },
    );
    listenForCode();

    super.initState();
  }

  @override
  void codeUpdated() {
    if (controller.text != code) {
      controller.value = TextEditingValue(text: code ?? '');
      if (mounted) setState(() {});
    }
  }

  void startTimer() {
    counterTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value != 0) {
        seconds.value =
            180 - DateTime.now().difference(startDateTime).inSeconds;
      }
    });
  }

  void reset() {
    startDateTime = DateTime.now();
    seconds.value = 180;
  }

  @override
  void dispose() {
    counterTimer.cancel();
    unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: widget.pinCount > 4 ? 45.w : 60.w,
      height: widget.pinCount > 4 ? 45.w : 64.w,
      textStyle: GoogleFonts.poppins(
        fontSize: widget.pinCount > 3 ? 14 : 20,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
            offset: Offset(0, 3),
            blurRadius: 16,
          ),
        ],
      ),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    return Container(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 386.w,
          height: 400.h,
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
                    Padding(
                      padding: context.initialHorizantalPadding,
                      child: const AppText(
                        'Lütfen gelen sms şifresini girermisiniz',
                        maxLines: 2,
                        style: TextStyle(
                          color: Color(0xFF15203D),
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Form(
                      key: formKey,
                      child: Pinput(
                        controller: controller,
                        length: widget.pinCount,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 16),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.05999999865889549),
                                offset: Offset(0, 3),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                        ),
                        showCursor: true,
                        cursor: cursor,
                        validator: (value) {
                          if (value?.length != widget.pinCount) {
                            return "Lütfen ${widget.pinCount} hane giriniz";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    ValueListenableBuilder(
                      valueListenable: seconds,
                      builder: (context, remainingSeconds, child) {
                        int minutes = remainingSeconds ~/ 60;
                        int remainingSecondsInMinute = remainingSeconds % 60;
                        return Material(
                          color: Colors.transparent,
                          child: remainingSeconds != 0
                              ? Text(
                                  '$minutes:$remainingSecondsInMinute',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                              : CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  child: const Text(
                                    "Tekrar Gönder",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  onPressed: () {
                                    reset();
                                    if (widget.sendAgain != null) {
                                      widget.sendAgain!();
                                    }
                                  },
                                ),
                        );
                      },
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
                            text: "Vazgeç",
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
                              if (formKey.currentState!.validate()) {
                                buttonAsync.value = true;
                                await context.setDelay(1000);
                                buttonAsync.value = false;
                                // ignore: use_build_context_synchronously
                                context.pop(controller.text);
                              }
                            },
                            text: "Onayla",
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
                            color:
                                ColorPalette.mainColors.blue.withOpacity(0.2),
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
      ),
    );
  }
}
