import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../class/popmovie.dart';

class DetailPop extends StatefulWidget {
  int movieID;
  DetailPop({super.key, required this.movieID});
  @override
  State<StatefulWidget> createState() {
    return _DetailPopState();
  }
}

class _DetailPopState extends State<DetailPop> {
  PopMovie? _pm;
  @override
  void initState() {
    super.initState();
    bacaData();
  }

  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419047/detailmovie.php"),
        body: {'id': widget.movieID.toString()});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      _pm = PopMovie.fromJson(json['data']);
      setState(() {});
    });
  }

  Widget tampilData() {
    if (_pm == null) {
      return const CircularProgressIndicator();
    } else {
      return Card(
          elevation: 10,
          margin: const EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Text(_pm!.title, style: const TextStyle(fontSize: 25)),
            Padding(
                padding: const EdgeInsets.all(10),
                child:
                    Text(_pm!.overview, style: const TextStyle(fontSize: 15))),
            Padding(padding: EdgeInsets.all(10), child: Text("Genre:")),
            Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _pm?.genres?.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Text(_pm?.genres?[index]['genre_name']);
                    })),
            Padding(padding: EdgeInsets.all(10), child: Text("Person:")),
            Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _pm?.persons?.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Text(_pm?.persons?[index]['person_name']);
                    })),
            Padding(
                padding: EdgeInsets.all(10), child: Text("Character Cast:")),
            Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _pm?.persons?.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Text(_pm?.persons?[index]['character_name']);
                    })),
          ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail of Popular Movie'),
        ),
        body: ListView(children: <Widget>[tampilData()]));
  }
}
