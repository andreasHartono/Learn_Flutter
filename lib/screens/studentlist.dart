// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/studentdetail.dart';

class StudentList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Student List'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: Column(children: [
          Text("This is Student List"),
          ElevatedButton(
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudentDetail(10)));
              }),
              child: Text("Student 1")),
          ElevatedButton(
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudentDetail(37)));
              }),
              child: Text("Student 2")),
          ElevatedButton(
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudentDetail(54)));
              }),
              child: Text("Student 3")),
        ]));
  }
}
