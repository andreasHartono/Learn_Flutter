// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/course_detail.dart';

class MyCourse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Course'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/200?img=59'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Divider(height: 20),
          Container(
            width: 423,
            height: 100,
            color: Colors.transparent,
            child: Card(
              child: Text(
                'Andreas Hartono K \nInformatika \nGasal 2022/2023',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(height: 30),
          Container(
            width: 400,
            height: 400,
            child: GridView.count(
              crossAxisCount: 1,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <Widget>[
                ElevatedButton(
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CourseDetail('Emerging Technology')));
                  }),
                  child: Text(
                    'Emerging Technology',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseDetail(
                                'Leadership & Professional Ethics')));
                  }),
                  child: Text(
                    'Leadership & Professional Ethics',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CourseDetail('Big Data Analytics')));
                  }),
                  child: Text(
                    'Big Data Analytics',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseDetail('AI For Game')));
                  }),
                  child: Text(
                    'AI For Game',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 200,
          )
        ]),
      ),
    );
  }
}
