// ignore_for_file: unused_element

import 'package:fast_structure/core/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../app/base_widgets/loading_widget.dart';
import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';
import '../../public/radius_palette.dart';
import 'app_button.dart';
import 'app_textfield.dart';

class AppBirthDayField extends StatefulWidget {
  const AppBirthDayField({
    super.key,
    this.onChanged,
    this.initialDateTime,
    this.hint,
    this.suffixIcon,
    this.example,
    this.fillColor,
    this.borderColor,
    this.iconPath,
  });
  final String? hint;
  final Widget? suffixIcon;
  final ValueChanged<DateTime>? onChanged;
  final DateTime? initialDateTime;
  final String? example;
  final Color? fillColor;
  final Color? borderColor;
  final String? iconPath;
  @override
  State<AppBirthDayField> createState() => _AppBirthDayFieldState();
}

class _AppBirthDayFieldState extends State<AppBirthDayField> {
  ValueNotifier<String?> examples = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: examples,
        builder: (context, example, child) {
          return AppTextfield(
            hint: widget.hint ?? "Doğum Tarihi",
            iconPath: widget.iconPath,
            example: example ?? widget.example,
            suffixIcon: widget.suffixIcon,
            fillColor: widget.fillColor,
            borderColor: widget.borderColor,
            enabled: false,
            onTap: () async {
              final time = await navigatorKey.currentContext!.modalPush(
                _AppBirthDay(
                  initialDateTime: widget.initialDateTime,
                ),
              );
              if (time != null && time is DateTime) {
                if (widget.onChanged != null) {
                  widget.onChanged!(time);
                  examples.value =
                      DateFormat("dd MMMM yyyy", "tr").format(time);
                }
              }
            },
          );
        });
  }
}

class _AppBirthDay extends StatelessWidget {
  const _AppBirthDay({this.initialDateTime});
  final DateTime? initialDateTime;
  @override
  Widget build(BuildContext context) {
    DateTime? dateTime = initialDateTime ?? DateTime.now();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 386.w,
        height: 500.h,
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
                  Expanded(
                    child: CupertinoDatePicker(
                      initialDateTime: initialDateTime,
                      onDateTimeChanged: (dt) {
                        dateTime = dt;
                      },
                      dateOrder: DatePickerDateOrder.dmy,
                      mode: CupertinoDatePickerMode.date,
                    ),
                  ),
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
                            context.pop(dateTime);
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
                        color: ColorPalette.mainColors.blue.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 10,
                      )
                    ],
                  ),
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
