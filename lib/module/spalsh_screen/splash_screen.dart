import 'package:admin/module/homescreen/home_screen.dart';
import 'package:admin/module/login_screen/login_screen.dart';
import 'package:admin/module/stores_screen/stores_screen.dart';
import 'package:admin/shared/Styles/colors.dart';
import 'package:admin/shared/components/constant.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String id ='splash-screen';
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: double.infinity,
        splashTransition: SplashTransition.fadeTransition,
        splash: Container(
          height: double.infinity,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/png1.png',
                  width: 90,
                  height: 90,
                ),
                const Text(
                  'Shoppy App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                )
              ],
            ),
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              MyColors.deepOrange,
              MyColors.lightOrange,
              Colors.orange,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        nextScreen: uId != null ?uId=='mainAdmin'?StoresScreen(): HomeScreen() : LoginScreen(),
        duration: 4,
        backgroundColor: Colors.orange,
      ),
    );
  }
}
