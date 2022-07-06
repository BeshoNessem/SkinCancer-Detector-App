import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/OnBoarding.dart';
import 'package:flutter_app/view/auth/google_sign_in.dart';
import 'package:flutter_app/view/auth/login_screen.dart';
import 'package:flutter_app/widgets/sign_in_email.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  final _formKeys = GlobalKey<FormState>();
  String _email = '', _password = '',_name='',_phonenumber='',uId='';
  var loading =false;
  var _image;
  String? _url;
  int _value=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: _image==null?null:FileImage(_image),
                  radius: 40,
                  child: IconButton(icon: Icon(Icons.add_a_photo,color: Colors.white,),onPressed: pickImage,),
                ),
              ),
            ),
            Form(
              key: _formKeys,
              child: Padding(
                padding: const EdgeInsets.only(top: 220, right: 10, left: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) => _name = value,
                        validator: (value) =>
                        value!.isEmpty ? 'Please Enter your Name' : null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            labelText: "Name",
                            prefixIcon: Icon(Icons.account_circle)),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) => _phonenumber = value,
                        validator: (value) =>
                        value!.isEmpty ? 'Please Enter your Phone ' : null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            labelText: "Phone number",
                            prefixIcon: Icon(Icons.add_ic_call_rounded)),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) => _email = value,
                        validator: (value) =>
                        value!.isEmpty ? 'Enter your Email' : null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email)),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) => _password = value,
                        validator: (value) =>
                        value!.length < 6 ? 'Enter more than 6 character' : null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            labelText: "New password",
                            prefixIcon: Icon(Icons.vpn_key),
                            suffixIcon: GestureDetector(onTap: (){
                              setState(() {
                                _obscureText=!_obscureText;
                              });
                            },child: Icon(_obscureText?Icons.visibility:Icons.visibility_off),)
                        ),
                        obscureText: _obscureText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: ()async {
                            setState(() {
                              loading=true;
                            });
                            Future.delayed(Duration(seconds: 4),(){
                              setState(() {
                                loading=false;
                              });
                            });
                            if(_formKeys.currentState!.validate()){
                              Timer(Duration(seconds: 7),(){
                                showDialog(context: context, builder:(_)=>AlertDialog(title: Text("Registeration Successfully"),actions: [FlatButton(onPressed:()async{
                                  var result=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
                                  final postID = DateTime.now().toString();
                                  Reference ref = FirebaseStorage.instance.ref().child("${result.user?.uid}/images").child("post_$postID");
                                  await ref.putFile(_image);
                                  _url = await ref.getDownloadURL();
                                  if(result!=null){
                                    FirebaseFirestore.instance.collection('users').doc(result.user?.uid).set({
                                      'email':_email,
                                      'phone':_phonenumber,
                                      'name':_name,
                                      'profileImage':_url.toString()
                                    });

                                  }
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));
                                }, child:Text("Ok"))],));
                              });

                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child:loading?CircularProgressIndicator(color: Colors.black,): Text(
                            "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),

                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have account ?",style: TextStyle(color: Colors.black54),),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: FlatButton(onPressed: (){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Home()));
                          }, child:Text("Login")),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }
  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    setState(() {
      _image=image;
    });
  }
}
