import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/itemBasket.dart';

class Basket extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basket'),
      ),
      body: Column(children: [
        Text("This is Basket"),
        ElevatedButton(
            onPressed: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemBasket(1, 10)));
            }),
            child: Text("Item 1")),
        ElevatedButton(
            onPressed: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemBasket(2, 14)));
            }),
            child: Text("Item 2")),
        ]
      )
    );
  }
}
