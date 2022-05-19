import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/to_image.dart';
class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ToImage()));
        },
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/images/Thyroid-Cancer-Awareness-black-580x386.jpg"),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("We are Developer team we make this app to help the patient if he has skin cancer and classify it's type"),
            )
          ],
        ),
      ),
    );

  }
}
