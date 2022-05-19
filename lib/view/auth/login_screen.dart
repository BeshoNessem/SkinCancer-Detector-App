import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/auth_form.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 90,
                right: 0,
                left: 0,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    image:DecorationImage(
                      image:AssetImage('assets/images/photo5891161797178799687.jpg')
                    )
                  ),
                  ),
                ),
              AuthForm(),
            ],
          ),
        ),
    );
  }
}
