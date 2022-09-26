// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../class/recipe.dart';

class AddRecipe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddRecipeState();
  }
}

Color getButtonColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.pressed)) {
    return Colors.red;
  } else {
    return Colors.blue;
  }
}

class _AddRecipeState extends State<AddRecipe> {
  final TextEditingController _recipe_name_cont = TextEditingController();
  final TextEditingController _recipe_desc_cont = TextEditingController();
  final TextEditingController _recipe_photo_cont = TextEditingController();

  late int _charleft;
  late String _recipe_category;
  @override
  void initState() {
    super.initState();
    _recipe_name_cont.text = "Makanan Bango";
    _recipe_desc_cont.text = "Makanan Pake kecap bango";
    _recipe_photo_cont.text = "https://www.bango.co.id/gfx/recipes/37.jpg";
    _charleft = 200 - _recipe_desc_cont.text.length;
    _recipe_category = "Traditional";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: Column(
        children: [
          Text('ADD NEW RECIPE'),
          TextField(
            controller: _recipe_name_cont,
            onChanged: (v) {
              // print(_recipe_name_cont.text);
            },
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: null,
          ),
          TextField(
            controller: _recipe_desc_cont,
            onChanged: (v) {
              setState(() {
                _charleft = 200 - v.length;
              });
            },
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: null,
          ),
          Text("char left : " + _charleft.toString()),
          TextField(
            controller: _recipe_photo_cont,
            onSubmitted: (v) {
              setState(() {});
            },
          ),
          Image.network(_recipe_photo_cont.text),
          Padding(padding: EdgeInsets.all(10.0)),
          DropdownButton(
              value: _recipe_category,
              items: [
                DropdownMenuItem(
                  child: Text("Traditional"),
                  value: "Traditional",
                ),
                DropdownMenuItem(
                  child: Text("Japanese"),
                  value: "Japanese",
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _recipe_category = value.toString();
                });
              }),
          Padding(padding: EdgeInsets.all(10.0)),
          ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                backgroundColor:
                    MaterialStateProperty.resolveWith(getButtonColor),
              ),
              onPressed: () {
                recipes.add(Recipe(
                  id: recipes.length + 1,
                  name: _recipe_name_cont.text,
                  desc: _recipe_desc_cont.text,
                  photo: _recipe_photo_cont.text,
                  kategori: _recipe_category,
                ));
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text('Add Recipe'),
                          content: Text('Recipe successfully added'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: Text('OK'),
                            ),
                          ],
                        ));
              },
              child: Text('SUBMIT')),
        ],
      ),
    );
  }
}
