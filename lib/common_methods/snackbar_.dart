import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
    required String content,
    TextStyle? textStyle,
    TextAlign? textAlign,
    Duration? duration}) {
  SnackBar snackBar = SnackBar(
    content: Text(
      content,
      textAlign: textAlign ?? TextAlign.left,
      style: textStyle ?? const TextStyle(),
    ),
    duration: duration ?? const Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
  );
}
