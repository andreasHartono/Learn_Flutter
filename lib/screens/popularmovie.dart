// ignore_for_file: unused_import, use_key_in_widget_constructors, unnecessary_new, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/class/popMovie.dart';
import 'package:http/http.dart' as http;

class PopularMovie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopularMovieState();
  }
}

class _PopularMovieState extends State<PopularMovie> {
  String _temp = 'waiting API respond...';

  Future<String> fetchData() async {
    final response = await http
        .get(Uri.https("ubaya.fun", "/flutter/160417130/movielist.php"));
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
      for (var mov in json['data']) {
        PopMovie pm = new PopMovie.fromJson(mov);
        PMs.add(pm);
      }
      setState(() {
        _temp = PMs[2].overview;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  // Daftar Pop Movie 1
  Widget DaftarPopMovie(PopMovs) {
    if (PopMovs != null) {
      return ListView.builder(
          itemCount: PopMovs.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.movie, size: 30),
                  title: Text(PopMovs[index].title),
                  subtitle: Text(PopMovs[index].overview),
                ),
              ],
            ));
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  // Daftar Pop Movie 2
  Widget DaftarPopMovie2(data) {
    List<PopMovie> PMs2 = [];
    Map json = jsonDecode(data);
    for (var mov in json['data']) {
      PopMovie pm = PopMovie.fromJson(mov);
      PMs2.add(pm);
    }
    return ListView.builder(
        itemCount: PMs2.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.movie, size: 30),
                title: Text(PMs2[index].title),
                subtitle: Text(PMs2[index].overview),
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
        title: const Text('Popular Movie'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: DaftarPopMovie(PMs),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 2,
              child: FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DaftarPopMovie2(snapshot.data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ],
      ),
    );
  }
}
