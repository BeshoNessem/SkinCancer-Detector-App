import 'package:flutter/material.dart';

class page4 extends StatelessWidget {
  const page4 ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Image.asset('assets/images/4.png',fit: BoxFit.fill,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),

        ),
      ),
    );
  }
}
