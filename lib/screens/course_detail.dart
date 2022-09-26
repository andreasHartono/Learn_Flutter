// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  final String course;
  CourseDetail(this.course);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course $course'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: 423,
            height: 100,
            color: Colors.transparent,
            child: Card(
              child: Text(
                // ignore: unnecessary_string_interpolations
                '$course',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Card(
                  child: Text(
                    'KP A',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Card(
                  child: Text(
                    'Senin \n07.00',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Card(
                  child: Text(
                    'TC4A',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Card(
                  child: Text(
                    '3sks',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
