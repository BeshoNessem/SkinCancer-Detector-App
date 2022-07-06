
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Awareness/page1.dart';
import 'package:flutter_app/Awareness/page2.dart';
import 'package:flutter_app/Awareness/page4.dart';
import 'package:flutter_app/view/auth/NavBar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite/tflite.dart';

import '../../Awareness/page3.dart';

class ToImage extends StatefulWidget {
  const ToImage({Key? key}) : super(key: key);

  @override
  _ToImageState createState() => _ToImageState();
}

class _ToImageState extends State<ToImage> {
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
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
