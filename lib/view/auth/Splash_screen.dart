import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/login_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset('assets/images/photo5891161797178799687.jpg',
                  width: 170,
                  height: 170,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: AnimatedTextKit(animatedTexts:[
                TyperAnimatedText("Skin Cancer Detector",textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
              ]),
            ),
            CircularProgressIndicator(color: Colors.black,),
          ],
        ),
      ),
    );
  }
}

