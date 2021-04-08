import 'package:flutter/material.dart';
import 'package:tpc_sit/home.dart';
import 'package:tpc_sit/login.dart';
import 'package:tpc_sit/signup.dart';
import 'package:tpc_sit/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: AnimatedSplashScreen(
        backgroundColor: Color(0xFFE4382C),
        splash: Image.asset('assets/logo.png'), 
        nextScreen: Start(),
        splashTransition: SplashTransition.fadeTransition,
        ),

      routes: <String, WidgetBuilder>{
        "Login" : (BuildContext context)=> Login(),
        "Sign-Up" : (BuildContext context)=> SignUp(),
        "Start" : (BuildContext context)=> Start(),
        "Home" : (BuildContext context)=> HomePage(),
      },
    );
  }
}
    