import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFlushbar {
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      message: message,
      icon: const Icon(Icons.check_circle, size: 24, color: Colors.white),
      leftBarIndicatorColor: Colors.white.withValues(alpha: .7),
      duration: duration,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12.r),
      backgroundColor: Colors.green.shade600,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .3),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, .5),
        ),
      ],
    ).show(context);
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      message: message,
      icon: const Icon(Icons.cancel_outlined, size: 24, color: Colors.white),
      leftBarIndicatorColor: Colors.white.withValues(alpha: .7),
      duration: duration,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12.r),
      backgroundColor: Colors.red.shade600,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .3),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, .5),
        ),
      ],
    ).show(context);
  }
}
