import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/Doctor2/doctor_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Doctor2/doctor_details_page2.dart';
import 'package:flutter_app/Doctor2/doctor_details_page_3.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../view/auth/to_image.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String name1 = "Name loading ....";
  String name2 = "Name loading ....";
  String name3 = "Name loading ....";
  String phone1 = "phone loading ....";
  String phone2 = "phone loading ....";
  String phone3 = "phone loading ....";
  void getData() async {
    var vari = await FirebaseFirestore.instance
        .collection('Doctor').doc("HKJdNh1tIVMrIJWjJJu9QdKjqSg1").get();
    setState(() {
      name1 = vari.data()!['name'];
      phone1=vari.data()!['phone'];
    });
  }
  void getname() async {
    var vari = await FirebaseFirestore.instance
        .collection('Doctor').doc("cCo81M4jBnXRJ1KZso0tgBnr6YJ2").get();
    setState(() {
      name2 = vari.data()!['name'];
      phone2=vari.data()!['phone'];
    });
  }
  void getname2() async {
    var vari = await FirebaseFirestore.instance
        .collection('Doctor').doc("RMUvSVFMUgg7MN8rcCQ11i8JJcA2").get();
    setState(() {
      name3 = vari.data()!['name'];
      phone3=vari.data()!['phone'];
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    getname();
    getname2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        title: Text(
          "Doctor",
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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                width: 320,
                child: ListView(
                  children: [
                    demoTopRatedDr(
                      "assets/images/dr_1.png",
                      name1,phone1,
                      "4.5",
                      "",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: IconButton(onPressed: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>DoctorDetailPage()));
                      }, icon:Icon(Icons.arrow_forward,color: Colors.transparent,)),
                    ),
                    demoTopRatedDr(
                      "assets/images/doctor-2.jpg",
                      name2,phone2,
                      "4.3",
                      "",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: IconButton(onPressed: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>DoctorDetailPage2()));
                      }, icon:Icon(Icons.arrow_forward,color: Colors.transparent,)),
                    ),
                    demoTopRatedDr(
                      "assets/images/download2.jpg",
                      name3,phone3,
                      "4.1",
                      "",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: IconButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DoctorDetailsPage3()));
                      }, icon:Icon(Icons.arrow_forward,color: Colors.transparent,)),
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

  Widget demoCategories(String img, String name, String drCount) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Color(0xff107163),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(img),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Color(0xffd9fffa).withOpacity(0.07),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              drCount,
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget demoTopRatedDr(String img, String name,
  String phone,
      String rating, String distance, [Icon? icon]) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 90,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 90,
                width: 50,
                child: CircleAvatar(
                  backgroundImage: AssetImage(img),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 17,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            phone,
                            style: TextStyle(
                              color:Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3, left: 45),
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    "Rating: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    rating,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
