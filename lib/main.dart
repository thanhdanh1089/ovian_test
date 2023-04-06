import 'package:flutter/material.dart';
import 'package:ovian_test/domain/entities/SOFUsersMain.dart';
import 'package:ovian_test/view/detail/SOFUserDetailScreen.dart';
import 'package:ovian_test/view/home/HomeScreen.dart';
import 'package:ovian_test/res/AppContextExtension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: context.resources.color.colorPrimary).copyWith(secondary: context.resources.color.colorAccent),
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        SOFUserDetailsScreen.id: (context) => SOFUserDetailsScreen(
            ModalRoute.of(context)!.settings.arguments as SOFUser),
      },
    );
  }
}
