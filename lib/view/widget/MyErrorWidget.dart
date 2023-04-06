import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String msg;

  const MyErrorWidget(this.msg, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
      ),
    );
  }
}
