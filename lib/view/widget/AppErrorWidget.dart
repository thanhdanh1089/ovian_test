import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String msg;

  const AppErrorWidget(this.msg, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
      ),
    );
  }
}
