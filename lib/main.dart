import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/pages/home_screen.dart';
import 'package:notes/pages/login_screen.dart';

import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initUIOverlay();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: FirebaseAuth.instance.currentUser == null? LoginScreen(): HomeScreen(),
      theme: ThemeData(
          fontFamily: 'ProductSans',
          accentColor: primaryColor,
          primaryColorDark: primaryColor),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }

}

void initUIOverlay() {
  //dark theme
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.dark.copyWith(
  //       statusBarIconBrightness: Brightness.light,
  //       statusBarBrightness: Brightness.light,
  //       statusBarColor: Colors.transparent),
  // );

  // //light theme
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
  );
}
