import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NoNetworkManager {
  NoNetworkManager(
      {required this.context,
      required this.onRetry,
      this.isEnable = false,
      this.customNoNetwork});

  final BuildContext? context;
  final void Function()? onRetry;
  final bool isEnable;

  final Function(void Function()? onRetry)? customNoNetwork;

  Future<void> show() async {
    if (!isEnable) return;
    if (context == null) return;
    if (await _checkConnectivity()) return;
    return customNoNetwork!(onRetry);
  }

  Future<bool> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return false;
    return true;
  }
}

abstract class CustomNoNetworkWidget {
  Widget get child;
  Future<void> Function()? onRetry;
}

mixin CustomRetryMixin on StatelessWidget {
  VoidCallback? get onRetry;
}

class ClassName {}
