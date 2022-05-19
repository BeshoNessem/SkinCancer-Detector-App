import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/OnBoarding.dart';
import 'package:flutter_app/view/auth/Splash_screen.dart';
import 'package:flutter_app/view/auth/Start.dart';
import 'package:flutter_app/view/auth/login_screen.dart';
import 'package:flutter_app/view/auth/to_image.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
           else if (snapshot.hasData) {
            return ToImage();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something Went Wrong !"),
            );
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}

