import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/login_screen.dart';
class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Image.asset('assets/images/Thyroid-Cancer-Awareness-black-580x386.jpg'),
              Text("Skin Cancer Detector",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20,letterSpacing: 2),),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: RaisedButton(onPressed: (){
                 Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home(),maintainState: true));
                },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  child: Text("Get Started",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

