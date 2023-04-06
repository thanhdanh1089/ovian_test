import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextView extends StatelessWidget {
  final String label;
  final Color color;
  final double fontSize;
  const AppTextView(this.label, this.color, this.fontSize, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}
