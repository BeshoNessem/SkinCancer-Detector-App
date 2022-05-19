import 'package:flutter/material.dart';
import 'main.dart';

class Result extends StatelessWidget {
  const Result(this.holder, this.resultScore, {Key? key}) : super(key: key);

  final Function() holder;
  final int resultScore;

  String get resultPhrase {
    String resultText = '';
    if (resultScore >=15) {
      resultText = 'Sorry! you have a big rate , you should contact with doctor';
    }
    else if (resultScore <=15 && resultScore>10) {
      resultText = 'It is not bad rate but you should takecare about yourself' ;
    }else{
      resultText='Best rate';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Container(
          height: 260,
          width: 330,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Done!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: isSwitched == false ? Colors.black : Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Total Score = $resultScore',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: isSwitched == false ? Colors.black : Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  resultPhrase,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: isSwitched == false ? Colors.black : Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
