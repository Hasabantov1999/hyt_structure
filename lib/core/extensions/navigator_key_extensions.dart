import 'package:flutter/cupertino.dart';


extension TabsNavigatorExtensions on GlobalKey<NavigatorState> {
  void go(Widget page) {
    if (currentState!.canPop()) {
      currentState!.pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => page), (route) => false);
    } else {
      currentState!.push(
        CupertinoPageRoute(
          builder: (context) => page,
        ),
      );
    }
  }

  void pop<T extends Object?>([T? result]) {
    currentState!.pop(result);
  }

  bool canPop() {
    return currentState!.canPop();
  }

  void setRouter(int index) {
    // tabIndex.value = index;
  }

  Future<T?> push<T extends Object?>(Widget page) async {
    return currentState!.push(
      CupertinoPageRoute(
        builder: (context) => page,
      ),
    );
  }

  Future<T?> modalPush<T>(Widget page) async {
    return showCupertinoModalPopup(
      context: currentContext!,
      builder: (context) => page,
    );
  }

  void navigate(int index) {
    currentState!.popUntil((route) {
      if (route.settings.name != '/') {
        return false;
      }
      return true;
    });
    setRouter(index);
  }

  Future<dynamic> navigateRoute(Widget route) async {
    currentState!.popUntil((route) {
      if (route.settings.name != '/') {
        return false;
      }
      return true;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    return currentState!.push(
      CupertinoPageRoute(
        builder: (context) => route,
      ),
    );
  }

  Future<T?> dialogPush<T>(Widget page,
      {bool barrierDismissible = true}) async {
    return showCupertinoDialog(
      context: currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (context) => page,
    );
  }
}
