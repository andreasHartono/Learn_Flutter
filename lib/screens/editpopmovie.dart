import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:numberpicker/numberpicker.dart';

import '../class/genre.dart';
import '../class/popmovie.dart';

class EditPopMovie extends StatefulWidget {
  int movie_id;
  EditPopMovie({Key? key, required this.movie_id}) : super(key: key);
  @override
  EditPopMovieState createState() {
    return EditPopMovieState();
  }
}

class EditPopMovieState extends State<EditPopMovie> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleCont = new TextEditingController();
  TextEditingController _homepageCont = new TextEditingController();
  TextEditingController _overviewCont = new TextEditingController();
  TextEditingController _releaseDate = new TextEditingController();
  int _runtime = 100;

  PopMovie pm = PopMovie(
      id: 0,
      title: "",
      homepage: "",
      overview: "",
      release_date: "2000-01-02",
      runtime: 0);
  Future<String> fetchData() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419047/detailmovie.php"),
        body: {'id': widget.movie_id.toString()});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  Color getButtonColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.redAccent;
    } else {
      return Colors.red;
    }
  }

  bacaData() {
    fetchData().then((value) {
      Map json = jsonDecode(value);
      pm = PopMovie.fromJson(json['data']);
      setState(() {
        _titleCont.text = pm.title;
        _homepageCont.text = pm.homepage;
        _overviewCont.text = pm.overview;
        _releaseDate.text = pm.release_date;
        _runtime = pm.runtime;
      });
    });
  }

  void submit() async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun./flutter/160419047/updatemovie.php"),
        body: {
          'title': pm.title,
          'overview': pm.overview,
          'homepage': pm.homepage,
          'release_date': pm.release_date,
          'runtime': pm.runtime.toString(),
          'movie_id': widget.movie_id.toString()
        });
    if (response.statusCode == 200) {
      print(response.body);
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses mengubah Data')));
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  Future<List> daftarGenre() async {
    Map json;
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419047/genrelist.php"),
        body: {'movie_id': widget.movie_id.toString()});
    if (response.statusCode == 200) {
      print(response.body);
      json = jsonDecode(response.body);
      return json['data'];
    } else {
      throw Exception('Failed to read API');
    }
  }

  Widget comboGenre = Text("Tambah Genre");

  void generateComboGenre() {
    //widget function for city list
    List<Genre> genres;
    var data = daftarGenre();
    data.then((value) {
      genres = List<Genre>.from(value.map((i) {
        return Genre.fromJSON(i);
      }));
      comboGenre = DropdownButton(
          dropdownColor: Colors.grey[100],
          hint: Text("tambah genre"),
          isDense: false,
          items: genres.map((gen) {
            print(gen.genre_id.toString() + " " + gen.genre_name);
            return DropdownMenuItem(
              value: gen.genre_id.toString(),
              child: Column(children: <Widget>[
                Text(gen.genre_name, overflow: TextOverflow.visible),
              ]),
            );
          }).toList(),
          onChanged: (value) {
            //memnaggil fungsi menambah genre disini
            addGenre(value);
          });
    });
  }

  // void DeleteGenre() {
  //   //widget function for city list
  //   List<Genre> genres;
  //   var data = daftarGenre();
  //   data.then((value) {
  //     genres = List<Genre>.from(value.map((i) {
  //       return Genre.fromJSON(i);
  //     }));
  //     comboGenre = ElevatedButton(
  //         style: ButtonStyle(
  //           elevation: MaterialStateProperty.all(5),
  //           backgroundColor: MaterialStateProperty.resolveWith(getButtonColor),
  //         ),
  //         onPressed: () {
  //           deletechild(genres['genre_id']);
  //         },
  //         child: Text('X'));
  //   });
  // }

  void addGenre(genre_id) async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419047/addmoviegenre.php"),
        body: {
          'genre_id': genre_id.toString(),
          'movie_id': widget.movie_id.toString()
        });
    if (response.statusCode == 200) {
      print(response.body);
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses menambah genre')));
        setState(() {
          bacaData();
        });
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  void deletechild(genre_id) async {
    final response = await http.post(
        Uri.parse("https://ubaya.fun/flutter/160419047/deletemoviechild.php"),
        body: {
          'movie_id': widget.movie_id.toString(),
          'genre_id': genre_id.toString()
        });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Delete genre success')));
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bacaData();

    setState(() {
      generateComboGenre();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Popular Movie"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    onChanged: (value) {
                      pm.title = value;
                    },
                    controller: _titleCont,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'judul harus diisi';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Website',
                    ),
                    onChanged: (value) {
                      pm.homepage = value;
                    },
                    controller: _homepageCont,
                    validator: (value) {
                      if (!Uri.parse(value!).isAbsolute) {
                        return 'alamat website salah';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Overview',
                    ),
                    onChanged: (value) {
                      pm.overview = value;
                    },
                    controller: _overviewCont,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 6,
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Release Date',
                        ),
                        controller: _releaseDate,
                      )),
                      ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2200))
                                .then((value) {
                              setState(() {
                                _releaseDate.text =
                                    value.toString().substring(0, 10);
                              });
                            });
                          },
                          child: Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.white,
                            size: 24.0,
                          ))
                    ],
                  )),
              NumberPicker(
                value: _runtime,
                axis: Axis.horizontal,
                minValue: 50,
                maxValue: 300,
                itemHeight: 30,
                itemWidth: 60,
                step: 1,
                onChanged: (value) => setState(() => _runtime = value),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Harap Isian diperbaiki')));
                    } else {
                      submit();
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              Padding(padding: EdgeInsets.all(10), child: Text('Genre:')),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pm.genres!.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return ListTile(
                          title: Text(pm.genres![index]['genre_name']),
                          trailing: IconButton(
                              onPressed: () {
                                deletechild(pm.genres![index]['genre_id']);
                              },
                              icon: Icon(Icons.delete)),
                        );
                      })),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: comboGenre),
            ],
          ),
        ));
  }
}
