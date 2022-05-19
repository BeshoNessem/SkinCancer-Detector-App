import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/login_screen.dart';
import 'package:liquid_swipe/Clippers/CircularWave.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 130),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 100, bottom: 20, top: 100),
                child: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Text(
                  "enter your email for reset password",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: TextFormField(
                        onChanged: (value) => _email = value,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            labelText: "Enter Email",
                            prefixIcon: Icon(Icons.email),
                            labelStyle: TextStyle(color: Colors.black54)),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text("Check your email messeges"),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                  },
                                  child: Text("ok"))
                            ],
                          ));
                },
                child: Text(
                  "Send request",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
