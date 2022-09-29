// ignore_for_file: sort_child_properties_last, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class Week3 extends StatelessWidget {
  List<Widget> cats() {
    List<Widget> temp = [];
    int i = 0;
    while (i < 16) {
      Widget w = Image.network(
          "https://placekitten.com/120/120?image=" + i.toString());
      temp.add(w);
      i++;
    }
    return temp;
  }

  List<Widget> mapel() {
    List<Widget> temp = [];

    Widget w = ElevatedButton(
      onPressed: null,
      child: Text('Emerging Technology'),
    );
    temp.add(w);

    w = ElevatedButton(
      onPressed: null,
      child: Text('Research Methodology'),
    );
    temp.add(w);

    w = ElevatedButton(
      onPressed: null,
      child: Text('Leadership Professional Ethics'),
    );
    temp.add(w);

    w = ElevatedButton(
      onPressed: null,
      child: Text('Big Data Analytics'),
    );
    temp.add(w);

    w = ElevatedButton(
      onPressed: null,
      child: Text('AI For Game'),
    );
    temp.add(w);

    return temp;
  }

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
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            color: Colors.yellow,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: AspectRatio(
              aspectRatio: 3 / 3,
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          Container(
            color: Colors.cyan,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
            height: 300,
            width: 300,
            child: Card(child: Text('Hello World!')),
          ),
          Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              // ignore: prefer_const_constructors
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                  topRight: Radius.circular(200)),
              // ignore: prefer_const_constructors
              image: DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/400?img=60'),
                fit: BoxFit.fill,
              ),
              border: Border.all(
                color: Color.fromARGB(255, 181, 83, 63),
                width: 20,
              ),
            ),
          ),
          Divider(height: 20),
          Row(
            children: [
              Image.network('https://i.pravatar.cc/100?img=1'),
              Image.network('https://i.pravatar.cc/100?img=2'),
              Image.network('https://i.pravatar.cc/100?img=3'),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network('https://i.pravatar.cc/100?img=4'),
                  Image.network('https://i.pravatar.cc/100?img=5'),
                  Image.network('https://i.pravatar.cc/100?img=6'),
                  Image.network('https://i.pravatar.cc/100?img=7'),
                  Image.network('https://i.pravatar.cc/100?img=8'),
                  Image.network('https://i.pravatar.cc/100?img=9'),
                ],
              )),
          Stack(
            children: [
              Image.network("https://placekitten.com/420/320?image=12"),
              Container(
                  height: 320,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset("assets/images/missing.png")))
            ],
          ),
          Container(
            height: 500,
            child: GridView.count(crossAxisCount: 3, children: cats()),
          ),
          // ignore: sized_box_for_whitespace
          Container(
            height: 100,
            child: GridView.count(crossAxisCount: 1, children: mapel()),
          ),
          // ignore: prefer_const_constructors
          Divider(
            height: 200,
          )
        ])));
  }
}
