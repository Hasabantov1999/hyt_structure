import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/base_widgets/loading_widget.dart';

extension ContextExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  void setAppBusy(bool value) {
    if (appBusy.value["busy"] != value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        appBusy.value = {"busy": value};
      });
    }
  }

  void setAppBusyWithMessage(bool value, {String? message}) {
    if (appBusy.value["busy"] != value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        appBusy.value = {
          "busy": value,
          "message": message,
        };
      });
    }
  }

  void setAppBusyWithLottie(bool value, {String? message, String? icon}) {
    if (appBusy.value["busy"] != value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        appBusy.value = {
          "busy": value,
          "message": message,
          "icon": icon,
        };
      });
    }
  }

  Future<void> get delay => Future.delayed(const Duration(milliseconds: 350));
  Future<void> setDelay(int milliseconds) =>
      Future.delayed(Duration(milliseconds: milliseconds));

  List<BoxShadow> get boxShadow => [
        const BoxShadow(
          color: Color.fromRGBO(255, 103, 29, 0.55),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ];
  List<BoxShadow> get textfieldShadow => const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 1,
          spreadRadius: 0,
        ),
      ];
  ThemeData get appTheme => Theme.of(this);

  EdgeInsetsGeometry get initialHorizantalPadding => EdgeInsets.symmetric(
        horizontal: 28.w,
      );

  BorderRadiusGeometry get appModalRadius => const BorderRadius.vertical(
        top: Radius.circular(8),
      );
  BorderRadiusGeometry get radius => const BorderRadius.vertical(
        top: Radius.circular(8),
        bottom: Radius.circular(8),
      );

  go(Widget page) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => page), (route) => false);
  }

  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }

  Future<T?> push<T>(Widget page) async {
    return navigatorKey.currentState!.push(
      CupertinoPageRoute(
        builder: (context) => page,
      ),
    );
  }

  Future<T?> modalPush<T>(Widget page) async {
    return showCupertinoModalPopup(
      context: navigatorKey.currentContext!,
      builder: (context) => page,
    );
  }

  Future<T?> dialogPush<T>(Widget page,
      {bool barrierDismissible = true}) async {
    return showCupertinoDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (context) => page,
    );
  }
}
