// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_final_fields, unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class QuestionObj {
  String narration;
  String option_a;
  String option_b;
  String option_c;
  String option_d;
  String answer;

  QuestionObj(this.narration, this.option_a, this.option_b, this.option_c,
      this.option_d, this.answer);
}

Color getButtonColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.pressed)) {
    return Colors.red;
  } else {
    return Colors.blueAccent;
  }
}

String formatTime(int hitung) {
  var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (hitung % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

class _QuizState extends State<Quiz> {
  late int _hitung;
  late Timer _timer;
  late bool _isrunning;
  late int _initValue;

  List<QuestionObj> _questions = [];
  int _question_no = 0;
  int _point = 0;

  @override
  void initState() {
    super.initState();
    _initValue = 950;
    _hitung = _initValue;
    _isrunning = true;
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _hitung--;
        if (_hitung == 0) {
          _question_no++;
          if (_question_no > _questions.length - 1) finishQuiz();
          _hitung = _initValue;
        }
      });
    });
    _questions.add(QuestionObj("Not a member of Avenger ", 'Ironman',
        'Spiderman', 'Thor', 'Hulk Hogan', 'Hulk Hogan'));
    _questions.add(QuestionObj("Not a member of Teletubbies", 'Dipsy',
        'Patrick', 'Laalaa', 'Poo', 'Patrick'));
    _questions.add(QuestionObj("Not a member of justice league", 'batman',
        'superman', 'flash', 'aquades', 'aquades'));
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _timer.cancel();
    _hitung = 0;
    _isrunning = false;
    super.dispose();
  }

  void checkAnswer(String answer) {
    setState(() {
      if (answer == _questions[_question_no].answer) {
        _point += 100;
      }
      _question_no++;
      if (_question_no > _questions.length - 1) finishQuiz();
      _hitung = _initValue;
    });
  }

  finishQuiz() {
    _timer.cancel();
    _question_no = 0;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Quiz'),
              content: Text('Your point = $_point'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: Center(
            child: Column(children: <Widget>[
          // CircularPercentIndicator(
          //   radius: 120.0,
          //   lineWidth: 30.0,
          //   percent: 1 - (_hitung / _initValue),
          //   center: Text(formatTime(_hitung)),
          //   progressColor: Colors.red,
          //   backgroundColor: Colors.yellowAccent,
          // ),
          Padding(padding: EdgeInsets.all(10)),
          LinearPercentIndicator(
            center: Text(formatTime(_hitung)),
            width: MediaQuery.of(context).size.width,
            lineHeight: 20.0,
            percent: 1 - (_hitung / _initValue),
            backgroundColor: Color.fromARGB(255, 245, 245, 61),
            progressColor: Colors.red,
          ),
          Padding(padding: EdgeInsets.all(10)),
          _isrunning
              ? ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getButtonColor),
                  ),
                  onPressed: () {
                    setState(() {
                      _timer.cancel();
                      _isrunning = false;
                    });
                  },
                  child: Text('STOP'))
              : ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getButtonColor),
                  ),
                  onPressed: () {
                    setState(() {
                      _timer =
                          Timer.periodic(Duration(milliseconds: 1000), (timer) {
                        setState(() {
                          _hitung--;
                          _isrunning = true;
                        });
                      });
                    });
                  },
                  child: Text('START')),
          Padding(padding: EdgeInsets.all(10)),
          Text(_questions[_question_no].narration),
          TextButton(
              onPressed: () {
                checkAnswer(_questions[_question_no].option_a);
              },
              child: Text("A. " + _questions[_question_no].option_a)),
          TextButton(
              onPressed: () {
                checkAnswer(_questions[_question_no].option_b);
              },
              child: Text("B. " + _questions[_question_no].option_b)),
          TextButton(
              onPressed: () {
                checkAnswer(_questions[_question_no].option_c);
              },
              child: Text("C. " + _questions[_question_no].option_c)),
          TextButton(
              onPressed: () {
                checkAnswer(_questions[_question_no].option_d);
              },
              child: Text("D. " + _questions[_question_no].option_d)),
          Padding(padding: EdgeInsets.all(10)),
          Text('POINT = ' + _point.toString())
        ])));
  }
}
