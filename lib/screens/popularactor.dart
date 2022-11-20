// ignore_for_file: unused_import, use_key_in_widget_constructors, unnecessary_new, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/class/pop_actor.dart';
import 'package:http/http.dart' as http;

class PopularActor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopularActorState();
  }
}

class _PopularActorState extends State<PopularActor> {
  String _temp = 'waiting API respond...';

  Future<String> fetchData() async {
    final response = await http
        .get(Uri.https("ubaya.fun", "/flutter/160419047/popularactor.php"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var psn in json['data']) {
        PopActor pa = new PopActor.fromJson(psn);
        PAs.add(pa);
      }
      setState(() {
        _temp = PAs[2].name;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  // Daftar Pop Movie 2
  Widget DaftarPopActor(data) {
    List<PopActor> PAs2 = [];
    Map json = jsonDecode(data);
    for (var person in json['data']) {
      PopActor pa = PopActor.fromJson(person);
      PAs2.add(pa);
    }
    return ListView.builder(
        itemCount: PAs2.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.movie, size: 30),
                title: Text(PAs2[index].name),
              ),
            ],
          ));
        });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Actor'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height / 2,
              child: FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DaftarPopActor(snapshot.data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ],
      ),
    );
  }
}
