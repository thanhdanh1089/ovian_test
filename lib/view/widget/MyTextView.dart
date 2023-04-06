import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextView extends StatelessWidget {
  final label;
  final Color color;
  final double fontSize;
  const MyTextView(this.label, this.color, this.fontSize, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}
