import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/to_image.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "Name loading ....";
  String email = 'email loading ......';
  String phone='Phone  ....';
  var  _url='';
  void getData() async {
    User result = await FirebaseAuth.instance.currentUser!;
    var vari = await FirebaseFirestore.instance
        .collection('users')
        .doc(result.uid).get();
    setState(() {
      name = vari.data()!['name'];
      email = vari.data()!['email'];
      phone=vari.data()!['phone'];
      _url=vari.data()!['profileImage'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ToImage()));
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage:NetworkImage(_url) ,
                ),
              ),
              Row(
                children: [
                  Text("Name",style: TextStyle(color: Colors.grey),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 255,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Text("Email",style: TextStyle(color:Colors.grey),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 260,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(email,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16),),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Phone",style: TextStyle(color: Colors.grey),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 260,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(phone,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
