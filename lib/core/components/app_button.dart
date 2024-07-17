// ignore_for_file: unused_catch_stack, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';
import 'app_text.dart';

enum ButtonOverload { overload, standart }

class AppButton extends StatefulWidget {
  const AppButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.buttonModel = NlButtonModel.RectangleModel,
      this.borderRadius = 17.0,
      this.focusNode,
      this.backgroundColor,
      this.width,
      this.height,
      this.textStyle,
      this.indicatorColor,
      this.overload = ButtonOverload.overload,
      this.redirectWhenPressed,
      this.textAlign,
      this.suffix,
      this.shadow,
      this.border,
      this.icon = false})
      : super(key: key);
  final Future<void> Function()? onPressed;
  final String text;
  final NlButtonModel? buttonModel;
  final double? borderRadius;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? indicatorColor;
  final Widget? suffix;
  final BoxBorder? border;
  final ButtonOverload? overload;
  final bool icon;

  final Future<void> Function()? redirectWhenPressed;
  final TextAlign? textAlign;
  final List<BoxShadow>? shadow;

  @override
  State<AppButton> createState() => _TripyButtonState();
}

class _TripyButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> asyncButton = ValueNotifier(false);

  bool catchError = false;
  String assetPath = 'packages/hyt_utils/assets/images/tripy_button.json';

  setButtonAsync(bool value) {
    asyncButton.value = value;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = 357.w;
    return ValueListenableBuilder(
      valueListenable: asyncButton,
      builder: (context, progress, child) {
        return AbsorbPointer(
          absorbing: progress,
          child: Container(
            width: widget.overload == ButtonOverload.overload
                ? deviceWidth
                : widget.width,
            height: widget.height ?? 57.h,
            decoration: BoxDecoration(
              border: widget.border,
              color: widget.onPressed == null
                  ? Colors.grey
                  : (widget.backgroundColor ?? ColorPalette.mainColors.blue),
              borderRadius: widget.buttonModel == NlButtonModel.StatiumModel
                  ? BorderRadius.circular(
                      100.w,
                    )
                  : BorderRadius.circular(widget.borderRadius ?? 14.r),
              boxShadow: widget.shadow,
            ),
            child: ElevatedButton(
              onPressed: widget.onPressed == null
                  ? null
                  : () async {
                      try {
                        FocusScope.of(context).unfocus();
                        setButtonAsync(true);

                        await widget.onPressed!();

                        catchError = false;
                      } catch (e, stackTrace) {
                        if (NlAsenkronButtonManager().crasher != null) {
                          NlAsenkronButtonManager().crasher!(e, stackTrace);
                        }
                        catchError = true;

                        rethrow;
                      } finally {
                        setButtonAsync(false);
                        if (!catchError) {
                          if (widget.redirectWhenPressed != null) {
                            widget.redirectWhenPressed!();
                          }
                        }
                      }
                    },
              focusNode: widget.focusNode,
              style: ElevatedButton.styleFrom(
                shape: widget.buttonModel == NlButtonModel.StatiumModel
                    ? const StadiumBorder()
                    : RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius!,
                        ),
                      ),
                elevation: 0,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: Colors.transparent,
              ),
              child: !progress
                  ? widget.suffix == null
                      ? AppText(
                          widget.text,
                          maxLines: 1,
                          width: widget.width ?? 280.w,
                          textAlign: widget.textAlign ?? TextAlign.center,
                          style: widget.textStyle ??
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                                height: 0.07,
                              ),
                        )
                      : widget.icon
                          ? Center(child: widget.suffix)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.suffix!,
                                if (widget.suffix != null)
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                if (widget.text != '')
                                  AppText(
                                    widget.text,
                                    maxLines: 1,
                                    style: widget.textStyle ??
                                        const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w400,
                                          height: 0.07,
                                        ),
                                    textAlign:
                                        widget.textAlign ?? TextAlign.center,
                                  ),
                              ],
                            )
                  : Lottie.asset(
                      Assets.lottie.dentalButonLoading,
                    ),
            ),
          ),
        );
      },
    );
  }
}

enum NlButtonModel {
  StatiumModel,
  RectangleModel,
}

class NlAsenkronButtonManager {
  static final NlAsenkronButtonManager _singleton =
      NlAsenkronButtonManager._internal();

  factory NlAsenkronButtonManager() {
    return _singleton;
  }

  NlAsenkronButtonManager._internal();

  Future Function(dynamic exception, StackTrace stackTrace)? crasher;
  Future Function()? timeOut;
  TextDirection? textDirection;
}
