import 'package:flutter/material.dart';

class ItemBasket extends StatelessWidget {
  final int id;
  final int count;
  ItemBasket(this.id, this.count);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Basket'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Center(
        child: Text("Item $id count=$count"),
      ),
    );
  }
}
