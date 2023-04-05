import 'package:flutter/material.dart';
import 'package:ovian_test/models/SOFUserDetail/SOFUsersDetailMain.dart';
import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/view/detail/SOFUserDetailScreen.dart';
import 'package:ovian_test/view/home/HomeScreen.dart';
import 'package:ovian_test/res/AppContextExtension.dart';
import 'package:ovian_test/view_model/detail/SOFUserDetailVM.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: context.resources.color.colorPrimary,
        accentColor: context.resources.color.colorAccent,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SOFUserDetailsScreen.id: (context) => SOFUserDetailsScreen(
            ModalRoute.of(context)!.settings.arguments as SOFUser),
        // SOFUserDetailScreen.id: (context) => SOFUserDetailScreen(
        //     ModalRoute.of(context)!.settings.arguments as SOFUser),
        // HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
