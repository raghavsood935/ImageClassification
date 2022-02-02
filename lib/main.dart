import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TFLite Model Testing ',
        themeMode: ThemeMode.light,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: GoogleFonts.lato().fontFamily),
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            duration: 1500,
            splash: Icons.login,
            nextScreen: MyPage(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.blue));
  }
}
