import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(color: Color.fromARGB(255, 26, 27, 29)),
            SizedBox(
              height: 8,
            ),
            Text(
              'Loading...',
            )
          ],
        ));
  }
}