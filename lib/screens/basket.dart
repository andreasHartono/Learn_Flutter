// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/itemBasket.dart';
import '../class/recipe.dart';

Color getButtonColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.pressed)) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

class Basket extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BasketState();
  }
}

class _BasketState extends State<Basket> {
  //late bool isDeleted;

  // @override
  // void initState() {
  //   super.initState();
  //   isDeleted = true;
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Basket'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Text("This is Basket "),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemBasket(1, 10)));
                },
                child: Text("Item 1")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemBasket(2, 14)));
                },
                child: Text("Item 2")),
            Divider(height: 30),
            Text(
              "Your basket ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Divider(
              height: 20,
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: widRecipes(),
            ),
            Divider(
              height: 100,
            )
          ]),
        ));
  }

  List<Widget> widRecipes() {
    List<Widget> temp = [];
    int i = 0;
    while (i < recipes.length) {
      var resep = recipes[i];
      Widget w = Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Card(
              elevation: 10,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(resep.name,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(resep.photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Kategori : ' + resep.kategori,
                      style: TextStyle(
                          color: Color.fromARGB(255, 69, 212, 74),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                    child: Text(
                      recipes[i].desc,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                    padding: EdgeInsets.all(10)),
                ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getButtonColor),
                    ),
                    onPressed: () {
                      setState(() {
                        recipes
                            .removeWhere((element) => element.id == resep.id);
                      });
                    },
                    child: Text('DELETE')),
                Padding(padding: EdgeInsets.all(10.0)),
              ])));
      temp.add(w);
      i++;
    }
    return temp;
  }
}
