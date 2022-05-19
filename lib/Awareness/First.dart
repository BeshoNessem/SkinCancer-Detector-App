import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Awareness/page1.dart';
import 'package:flutter_app/Awareness/page2.dart';
import 'package:flutter_app/Awareness/page3.dart';
import 'package:flutter_app/Awareness/page4.dart';
import 'package:flutter_app/view/auth/to_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text('Types of Skin Cancer ',
              style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white70,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ToImage()));
          },),
          iconTheme: IconThemeData(color: Colors.black),
        ) ,
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
        ));
  }
}
