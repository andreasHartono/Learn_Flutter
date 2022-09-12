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
      ),
      body: Center(
        child: Image.network('https://i.pravatar.cc/300?img=$id'),
      ),
    );
  }
}
