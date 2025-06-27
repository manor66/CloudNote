import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget ClickableText(String label, {VoidCallback? onTap, TextStyle? style}) {
  return GestureDetector(
    onTap: onTap ?? () {},
    behavior: HitTestBehavior.opaque,
    child: Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: style ?? const TextStyle(color: Colors.blue),
      ),
    ),
  );
}
