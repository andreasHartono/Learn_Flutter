import 'package:flutter/material.dart';

class About extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      // ignore: prefer_const_constructors
      body: Center(
        child: Text('This is About'),
      ),
    );
  }
}
