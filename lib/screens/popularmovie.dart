// ignore_for_file: unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/detailpop.dart';
import 'package:flutter_application_1/screens/newpopmovie.dart';
import 'package:http/http.dart' as http;

import '../class/popmovie.dart';

class PopularMovie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopularMovieState();
  }
}

class _PopularMovieState extends State<PopularMovie> {
  String _temp = 'waiting API respond…';
  List<PopMovie> PMs = [];
  String _txtcari = "";

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419047/movielist.php"),
        body: {'cari': _txtcari});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    PMs.clear();
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var mov in json['data']) {
        PopMovie pm = PopMovie.fromJson(mov);
        PMs.add(pm);
      }
      setState(() {
        //_temp = PMs[61].title;
      });
    });
  }

  Color getButtonColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.blueAccent;
    } else {
      return Colors.orangeAccent;
    }
  }

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
                  title: GestureDetector(
                      child: Text(PopMovs[index].title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPop(movieID: PMs[index].id),
                          ),
                        );
                      }),
                  subtitle: Text(PMs[index].overview),
                ),
              ],
            ));
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bacaData();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Popular Movie')),
        body: ListView(children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.search),
              labelText: 'Judul mengandung kata:',
            ),
            onFieldSubmitted: (value) {
              _txtcari = value;
              bacaData();
            },
          ),
          ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                backgroundColor:
                    MaterialStateProperty.resolveWith(getButtonColor),
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewPopMovie()));
                });
              },
              child: Text('ADD NEW MOVIE')),
          Padding(padding: EdgeInsets.all(10.0)),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: DaftarPopMovie(PMs),
          ),
          // Container(
          //     height: MediaQuery.of(context).size.height / 2,
          //     child: FutureBuilder(
          //         future: fetchData(),
          //         builder: (context, snapshot) {
          //           if (snapshot.hasData) {
          //             return DaftarPopMovie2(snapshot.data);
          //           } else {
          //             return Center(child: CircularProgressIndicator());
          //           }
          //         }))
        ]));
  }
}
