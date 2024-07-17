// ignore_for_file: unused_element

import 'package:fast_structure/core/components/app_button.dart';
import 'package:fast_structure/core/extensions/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/base_widgets/loading_widget.dart';
import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';
import '../../public/radius_palette.dart';
import 'app_text.dart';
import 'app_textfield.dart';



class AppGenderField extends StatefulWidget {
  const AppGenderField({
    super.key,
    this.onChanged,
    this.initialGender,
  });

  final ValueChanged<GenderModel>? onChanged;
  final GenderModel? initialGender;

  @override
  State<AppGenderField> createState() => _AppGenderFieldState();
}

class _AppGenderFieldState extends State<AppGenderField> {
  ValueNotifier<String?> examples = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: examples,
        builder: (context, example, child) {
          return AppTextfield(
            hint: "Cinsiyet",
            iconPath: Assets.svg.inputUser,
            example: example,
            enabled: false,
            onTap: () async {
              final gender = await navigatorKey.currentContext!.modalPush(
                _AppGender(
                  initialGender: widget.initialGender,
                ),
              );

              if (gender != null && gender is GenderModel) {
                if (widget.onChanged != null) {
                  widget.onChanged!(gender);
                  examples.value = gender.text;
                }
              }
            },
          );
        });
  }
}

class _AppGender extends StatelessWidget {
  const _AppGender({this.initialGender});
  final GenderModel? initialGender;
  @override
  Widget build(BuildContext context) {
    GenderModel? gender = initialGender ?? GenderModel.male;
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
                    height: 40.h,
                    fit: BoxFit.fitWidth,
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: gender.index),
                      itemExtent: 40,
                      onSelectedItemChanged: (val) {
                        gender = GenderModel.values[val];
                      },
                      children: [
                        for (var element in GenderModel.values)
                          Align(
                            alignment: Alignment.center,
                            child: AppText(
                              element.text,
                            ),
                          )
                      ],
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
                            context.pop(gender);
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

enum GenderModel {
  male(text: "Erkek", value: "M"),
  female(text: "Kadın", value: "W");

  final String text;
  final String value;
  const GenderModel({required this.text, required this.value});
}
