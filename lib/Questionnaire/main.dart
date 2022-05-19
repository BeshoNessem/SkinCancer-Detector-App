import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/to_image.dart';
import 'quiz.dart';
import 'result.dart';
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}
bool isSwitched = false;
class _AppState extends State<App> {
  int _questionIndex = 0;
  int _totalScore = 0;

  answerQuestion(int score) {
    print('Answer Chosen!');
    setState(() {
      _questionIndex += 1;
      _totalScore += score;
    });
    print(_questionIndex);
    print(_totalScore);
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Are you exposed for long periods in the sun ?',
      'answers': [
        {'text': 'Yes', 'score':3 },
        {'text': 'No', 'score': 1},
        {'text': 'Sometimes', 'score': 2},

      ]
    },
    {
      'questionText': 'Are you puts a lot of cosmetics ?',
      'answers': [
        {'text': 'Yes', 'score': 3},
        {'text': 'No', 'score': 1},
        {'text': 'Sometimes', 'score': 2},
      ]
    },
    {
      'questionText': 'What is the evalution of the mole in terms of shape ?',
      'answers': [
        {'text': 'Raised', 'score': 3},
        {'text': 'Flat shape', 'score': 3},
        {'text': 'Irregular shape and border', 'score': 3},
        {'text': 'Asymmetry', 'score':3},
        {'text':'None of the above','score':1}
      ]
    },
    {
      'questionText': 'What is the evalution of the mole in terms of color ?',
      'answers': [
        {'text': 'Black', 'score': 3},
        {'text': 'Brown', 'score': 3},
        {'text': 'Red', 'score':2},
        {'text': 'Blue', 'score':2},
        {'text': 'White', 'score':1},
      ]
    },
    {
      'questionText': 'Does your moles become bleed ? ',
      'answers': [
        {'text': 'Yes', 'score': 3},
        {'text': 'No', 'score':2},

      ]
    },{
      'questionText': 'Is mole developing in another parts?',
      'answers': [
        {'text': 'Yes', 'score':3},
        {'text': 'No', 'score': 2},

      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Questionnaire', style: TextStyle(color: Colors.black),
        ),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ToImage()));
          },),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          color: isSwitched == false ? Colors.white : Colors.black,
          child: _questionIndex < _questions.length
              ? Quiz(_questions, _questionIndex, answerQuestion)
              : Result(_resetQuiz, _totalScore),
        ),
      ),
    );
  }
}
