// ignore_for_file: unused_catch_stack, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';


import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';

enum ButtonOverload { overload, standart }

class DentalIconButton extends StatefulWidget {
  const DentalIconButton({
    Key? key,
    required this.onPressed,
    this.buttonModel = NlButtonModel.RectangleModel,
    this.borderRadius = 17.0,
    this.focusNode,
    this.backgroundColor,
    this.width,
    this.height,
    this.textStyle,
    this.indicatorColor,
    this.redirectWhenPressed,
    this.textAlign,
    required this.icon,
    this.shadow,
    this.border,
  }) : super(key: key);
  final Future<void> Function()? onPressed;

  final NlButtonModel? buttonModel;
  final double? borderRadius;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? indicatorColor;
  final Widget icon;
  final BoxBorder? border;

  final Future<void> Function()? redirectWhenPressed;
  final TextAlign? textAlign;
  final List<BoxShadow>? shadow;

  @override
  State<DentalIconButton> createState() => _TripyButtonState();
}

class _TripyButtonState extends State<DentalIconButton>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> asyncButton = ValueNotifier(false);

  bool catchError = false;
  String assetPath = 'packages/hyt_utils/assets/images/tripy_button.json';

  setButtonAsync(bool value) {
    asyncButton.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: asyncButton,
      builder: (context, progress, child) {
        return AbsorbPointer(
          absorbing: progress,
          child: Container(
            width: widget.width,
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
            child: MaterialButton(
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: widget.buttonModel == NlButtonModel.RectangleModel
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? 14.r,
                      ),
                    )
                  : const CircleBorder(),
              onPressed: widget.onPressed == null
                  ? null
                  : () async {
                      try {
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
              child: !progress
                  ? widget.icon
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
