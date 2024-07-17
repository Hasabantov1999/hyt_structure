import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../core/components/app_text.dart';
import '../../gen/assets.gen.dart';

late _AppLoadingWidgetState _state;
ValueNotifier<TextDirection> appDirection = ValueNotifier(TextDirection.ltr);

class AppLoadingWidget extends StatefulWidget {
  const AppLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AppLoadingWidget> createState() => _AppLoadingWidgetState();
}

class _AppLoadingWidgetState extends State<AppLoadingWidget> {
  @override
  void initState() {
    super.initState();
    _state = this;
  }

  void notifyListeners() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ValueListenableBuilder(
          valueListenable: _redirectBusy,
          builder: (context, ignoring, child) {
            return IgnorePointer(
              ignoring: ignoring,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        if (appBusy.value["barrierDismissible"] != null &&
                            appBusy.value["barrierDismissible"] is bool &&
                            appBusy.value["barrierDismissible"]) {
                          if (appBusy.value["whenDismissed"] != null) {
                            appBusy.value["whenDismissed"]!();
                          }
                          appBusy.value = appBusy.value.copyBusyWith(false);
                        }
                      },
                      child: ValueListenableBuilder(
                        valueListenable: appBusy,
                        builder: (context, opacityVal, child) {
                          return TweenAnimationBuilder<Color?>(
                            tween: ColorTween(
                              begin: opacityVal['busy']
                                  ? Colors.transparent
                                  : opacityVal["barrierColor"] ??
                                      Colors.black26,
                              end: opacityVal['busy']
                                  ? opacityVal["barrierColor"] ?? Colors.black26
                                  : Colors.transparent,
                            ),
                            onEnd: () {
                              if (!appBusy.value['busy']) {
                                _redirectBusy.value = true;
                              } else {
                                _redirectBusy.value = false;
                              }
                            },
                            duration: const Duration(milliseconds: 300),
                            builder: (context, color, child) {
                              return Container(color: color);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: appBusy,
                    builder: (context, opacityVal, child) {
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: opacityVal['busy'] ? 1 : 0,
                        child: opacityVal["widget"] ??
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Lottie.asset(
                                    Assets.lottie.dentalLoading,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                  if (opacityVal['message'] != null)
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                  if (opacityVal['message'] != null)
                                    AppText(
                                      opacityVal['message'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                ],
                              ),
                            ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}

void appAddPostFrameBack([FutureOr<dynamic> Function()? computation]) {
  Future.delayed(const Duration(milliseconds: 300), computation);
}

void setAppBusy(
  bool value, {
  String? message,
  String? icon,
  Widget? child,
  Color? barrierColor,
  bool? barrierDismissible,
  int? delayAndFalseDuration,
  VoidCallback? whenDismissed,
}) async {
  if (!value) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appBusy.value = {
        "busy": false,
        "message": message ?? appBusy.value["message"],
        "icon": icon ?? appBusy.value["icon"],
        "widget": child ?? appBusy.value["widget"],
        "barrierColor": barrierColor ?? appBusy.value["barrierColor"],
        "barrierDismissible":
            barrierDismissible ?? appBusy.value["barrierDismissible"],
        "whenDismissed": whenDismissed,
      };
    });
  } else {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appBusy.value = {
        "busy": value,
        "message": message,
        "icon": icon,
        "widget": child,
        "barrierColor": barrierColor,
        "barrierDismissible": barrierDismissible,
        "whenDismissed": whenDismissed,
      };
    });
  }

  if (delayAndFalseDuration != null) {
    Future.delayed(Duration(milliseconds: delayAndFalseDuration)).then((value) {
      setAppBusy(false);
    });
  }
  _state.notifyListeners();
}

ValueNotifier<Map<String, dynamic>> appBusy = ValueNotifier({
  "busy": false,
  "message": null,
  "icon": null,
  "widget": null,
  "barrierColor": null,
  "barrierDismissible": null
});

ValueNotifier<bool> _redirectBusy = ValueNotifier(false);
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

extension MapContextExtension on Map<String, dynamic> {
  Map<String, dynamic> copyBusyWith(
    bool value, {
    String? message,
    String? icon,
    Widget? child,
    Color? barrierColor,
    bool? barrierDismissible,
    VoidCallback? whenDismissed,
  }) {
    return {
      "busy": value,
      "message": message ?? this["message"],
      "icon": icon ?? this["icon"],
      "widget": child ?? this["child"],
      "barrierColor": barrierColor ?? this["barrierColor"],
      "barrierDismissible": barrierDismissible ?? this["barrierDismissible"],
      "whenDismissed": whenDismissed ?? this["whenDismissed"],
    };
  }
}
