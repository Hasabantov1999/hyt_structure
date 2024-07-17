// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../public/color_palette.dart';
import '../../services/localization_services/localization_services.dart';
import 'app_text.dart';

class AppTextfield extends StatelessWidget {
  AppTextfield(
      {super.key,
      required this.hint,
      this.passwordChar = false,
      this.textInputAction,
      this.controller,
      this.enabled = true,
      this.iconPath,
      this.example,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLines,
      this.borderColor,
      this.fillColor,
      this.width,
      this.inputFormatters,
      this.onTap,
      this.validator});
  final String hint;
  final String? example;
  final bool passwordChar;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final String? iconPath;
  final int? maxLines;
  final ValueChanged<String?>? onChanged;
  final Color? fillColor;
  final Color? borderColor;
  final double? width;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  ValueNotifier<bool> obscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hint.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: AppText(
              hint,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF677294),
                fontSize: 14,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        SizedBox(
          height: 8.h,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ValueListenableBuilder(
              valueListenable: obscure,
              builder: (context, showPassword, child) {
                return FutureBuilder(
                  future: LocalizationServices.instance.translate(hint),
                  builder: (context, snapshot) {
                    String hnt = hint;
                    if (snapshot.data != null) {
                      hnt = snapshot.data!;
                    }

                    return SizedBox(
                      width: width,
                      child: InkWell(
                        onTap: onTap,
                        child: TextFormField(
                          controller: controller,
                          maxLines: maxLines ?? 1,
                          validator: validator,
                          cursorColor: ColorPalette.mainColors.blue,
                          onChanged: onChanged,
                          inputFormatters: inputFormatters,
                          style: const TextStyle(
                            color: Color(0xFF15203D),
                            fontSize: 14,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                          ),
                          textInputAction: textInputAction,
                          enabled: onTap != null ? false : enabled,
                          obscureText: passwordChar ? showPassword : false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              bottom: 16.h,
                              top: 16.h,
                              left: 15.w,
                            ),
                            fillColor:
                                fillColor ?? ColorPalette.grayColors.bgGray,
                            prefix: prefixIcon,
                            prefixIcon: iconPath != null
                                ? Container(
                                    margin:
                                        EdgeInsets.only(left: 10.w, right: 4.w),
                                    child: SvgPicture.asset(
                                      iconPath!,
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  )
                                : null,
                            prefixIconConstraints: const BoxConstraints(
                              maxWidth: 30,
                              maxHeight: 30,
                              minWidth: 30,
                              minHeight: 30,
                            ),
                            filled: true,
                            suffixIcon: suffixIcon ??
                                (passwordChar
                                    ? InkWell(
                                        onTap: () {
                                          obscure.value = !showPassword;
                                        },
                                        child: showPassword
                                            ? const Icon(
                                                Icons.visibility_outlined,
                                                color: Color(0xFF15203D),
                                              )
                                            : const Icon(
                                                Icons.visibility_off_outlined,
                                                color: Color(0xFF15203D),
                                              ),
                                      )
                                    : null),
                            hintText: example ?? hnt,
                            hintStyle: TextStyle(
                              color: const Color(0xFF15203D).withOpacity(0.4),
                              fontSize: 14,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: borderColor ??
                                    ColorPalette.grayColors.borderGray,
                                width: 1.50,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: borderColor ??
                                    ColorPalette.grayColors.borderGray,
                                width: 1.50,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: borderColor ??
                                    ColorPalette.grayColors.borderGray,
                                width: 1.50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
