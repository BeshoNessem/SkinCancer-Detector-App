import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Appointmnets/SaveAppointmnet.dart';
import 'package:flutter_app/Awareness/First.dart';
import 'package:flutter_app/ChatBot/Chat.dart';
import 'package:flutter_app/Doctor/Doctorlist.dart';
import 'package:flutter_app/Doctor2/home_page.dart';
import 'package:flutter_app/Questionnaire/main.dart';
import 'package:flutter_app/view/auth/About.dart';
import 'package:flutter_app/view/auth/Profile.dart';
import 'package:flutter_app/view/auth/Save.dart';
import 'package:flutter_app/view/auth/Splash_screen.dart';
import 'package:flutter_app/view/auth/google_sign_in.dart';
import 'package:flutter_app/view/auth/login_screen.dart';
import 'package:flutter_app/widgets/sign_in_email.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'register_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String name = "Name loading ....";
  String email = 'email loading ......';
  var  _url='';
  void getData() async {
    User result = await FirebaseAuth.instance.currentUser!;
    var vari = await FirebaseFirestore.instance
        .collection('users')
        .doc(result.uid)
        .get();
    setState(() {
      name = vari.data()!['name'];
      email = vari.data()!['email'];
      _url=vari.data()!['profileImage'];
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(accountName:Text(name,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black),), accountEmail: null,decoration: BoxDecoration(color: Colors.grey,image:DecorationImage(image:AssetImage("assets/images/istockphoto-1310759347-612x612.jpg"),fit: BoxFit.cover)),
            currentAccountPicture: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(_url),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Profile",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text(
              "Detection",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>First()));
            },
          ),
          ListTile(
            leading: Icon(Icons.history_rounded),
            title: Text(
              "History",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Save()));
            },
          ),
          ListTile(
            leading: Icon(Icons.medical_services),
            title: Text(
              "Doctor",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.home_repair_service_rounded),
            title: Text(
              "Appointments",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SaveAppointment()));
            },
          ),

          ListTile(
            leading: Icon(Icons.chat_bubble_outlined),
            title: Text(
              "ChatBot",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Chat()));
            },
          ),

          ListTile(
            leading: Icon(Icons.info),
            title: Text(
              "About us",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>About()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              final provider =
                  Provider.of<AuthServices>(context, listen: false);
              provider.logoutEmail();
              Timer(
                  Duration(seconds: 5),
                  () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SplashScreen())));
            },
          ),
        ],
      ),
    );
  }
}
