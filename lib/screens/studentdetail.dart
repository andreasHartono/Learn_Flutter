// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StudentDetail extends StatelessWidget {
  final int id;
  StudentDetail(this.id);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student with ID $id'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Center(
        child: Image.network('https://i.pravatar.cc/300?img=$id'),
      ),
    );
  }
}
