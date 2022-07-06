import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Awareness/First.dart';
import 'package:flutter_app/Awareness/page1.dart';
import 'package:flutter_app/Awareness/page3.dart';
import 'package:flutter_app/Awareness/page4.dart';
import 'package:flutter_app/view/auth/DoctorAppointment.dart';
import 'package:flutter_app/view/auth/DoctorProfile.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Awareness/page2.dart';
import '../../widgets/sign_in_email.dart';
import 'Splash_screen.dart';
class DoctorAuth extends StatefulWidget {
  const DoctorAuth({Key? key}) : super(key: key);

  @override
  _DoctorAuthState createState() => _DoctorAuthState();
}

class _DoctorAuthState extends State<DoctorAuth> {
  String name = "Name loading ....";
  String email = 'email loading ......';
  var _url='photo loading ....';
  void getData() async {
    User result = await FirebaseAuth.instance.currentUser!;
    var vari = await FirebaseFirestore.instance
        .collection('Doctor')
        .doc(result.uid)
        .get();
    setState(() {
      name = vari.data()!['name'];
      email = vari.data()!['email'];
      _url=vari.data()!['photoURL'];
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(accountName:Text(name,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black),), accountEmail: null,decoration: BoxDecoration(color: Colors.grey,image:DecorationImage(image:AssetImage("assets/images/SKin-Cancer-Awareness-Ribbon.png"),fit: BoxFit.cover,scale: 50)),
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DoctorProfile()));
              },
            ),
            ListTile(
              leading: Icon(Icons.home_repair_service_rounded),
              title: Text(
                "Appointments",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>DoctorAppointment()));
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
      ),
      appBar: AppBar(
        title: Text(
          "SC Detector",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 3);
              });
            },
            children: [page1(), page2(), page3(), page4()],
          ),
          Container(
              alignment: Alignment(0, 0.96),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmoothPageIndicator(controller: _controller, count: 4,effect: ExpandingDotsEffect(activeDotColor: Colors.black),)

                ],
              ))
        ],
      ),
    );
  }
}
