// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class toaster {
  ToastFuture showsToast(String msg, Color color, Color tColor) {
    return showToast(
      msg,
      duration: const Duration(seconds: 2),
      position: ToastPosition.bottom,
      backgroundColor: color,
      radius: 13.0,
      textStyle: TextStyle(fontSize: 18.0, color: tColor),
    );
  }
}