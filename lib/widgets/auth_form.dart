import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/DoctorAuth.dart';
import 'package:flutter_app/view/auth/NavBar.dart';
import 'package:flutter_app/view/auth/OnBoarding.dart';
import 'package:flutter_app/view/auth/home_page.dart';
import 'package:flutter_app/view/auth/login_screen.dart';
import 'package:flutter_app/view/auth/register_screen.dart';
import 'package:flutter_app/view/auth/to_image.dart';
import 'package:flutter_app/widgets/forgot_pass.dart';
import 'package:flutter_app/widgets/sign_in_email.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKeys = GlobalKey<FormState>();
  String _email = '', _password = '';
  var loading = false;
  bool obsecure = true;
  var _value = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKeys,
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 200, top: 10, bottom: 0),
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20, left: 10, top: 10, bottom: 15),
                    child: Text(
                      "login in to the SC Detector if you have account",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) => _email = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter valid email' : null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        labelText: "Enter your email",
                        hintText: "ex.example@gmail.com",
                        prefixIcon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) => _password = value,
                    validator: (value) =>
                        value != _password ? 'your pass error try again' : null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        labelText: "Enter your password",
                        labelStyle: TextStyle(color: Colors.black54),
                        prefixIcon: Icon(Icons.vpn_key),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obsecure = !obsecure;
                            });
                          },
                          child: Icon(obsecure
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    obscureText: obsecure,
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPass()));
                          },
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(color: Colors.black54),
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Row(
                      children: [
                        Radio(
                            activeColor: Colors.black,
                            value: 1,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = 1;
                              });
                            }),
                        Text("Patient"),
                        Radio(
                            activeColor: Colors.black,
                            value: 2,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = 2;
                              });
                            }),
                        Text("Doctor")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  Future.delayed(Duration(seconds: 3), () {
                    setState(() {
                      loading = false;
                    });
                  });
                  if (_formKeys.currentState!.validate() && _value == 1) {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _email, password: _password)
                        .then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnBoarding()));
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Incorrect password or email  "),
                      ));
                    });
                  }
                  if (_formKeys.currentState!.validate() && _value == 2) {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: _email, password: _password)
                        .then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorAuth()));
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Incorrect password or email  "),
                      ));
                    });
                  }

                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: loading
                    ? CircularProgressIndicator(
                        color: Colors.black,
                      )
                    : Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Don't have account ?"),
                FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 45),
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
