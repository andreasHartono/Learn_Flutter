// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/addrecipe.dart';
import 'package:flutter_application_1/screens/my_courses.dart';
import 'package:flutter_application_1/screens/popularmovie.dart';
import 'package:flutter_application_1/screens/quiz.dart';
import 'package:flutter_application_1/screens/search.dart';
import 'package:flutter_application_1/screens/studentlist.dart';
import 'package:flutter_application_1/screens/week3.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/about.dart';
import 'screens/basket.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/search.dart';
import 'screens/history.dart';
import 'screens/my_courses.dart';
import 'screens/addrecipe.dart';

String active_user = "";

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_id") ?? '';
  return user_id;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    if (result == '')
      runApp(MyLogin());
    else {
      active_user = result;
      runApp(MyApp());
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Flutter App'),
      routes: {
        'about': (context) => About(),
        'basket': (context) => Basket(),
        'home': (context) => Home(),
        'search': (context) => Search(),
        'history': (context) => History(),
        'student': (context) => StudentList(),
        'week3': (context) => Week3(),
        'mycourse': (context) => MyCourse(),
        'addrecipe': (context) => AddRecipe(),
        'quiz': (context) => Quiz(),
        'popularmovie': (context) => PopularMovie(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Runes myEmoji = Runes('\u{1f607}');
  String emoji = "";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      emoji = emoji + String.fromCharCodes(myEmoji);
    });
  }

  Widget myDrawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Xyz'),
            accountEmail: Text('Xyz@gmail.com'),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/150")),
          ),
          ListTile(
            title: new Text("About"),
            leading: new Icon(Icons.help),
            onTap: () {
              Navigator.pushNamed(context, "about");
            },
          ),
          ListTile(
            title: new Text("Week 3"),
            leading: new Icon(Icons.widgets),
            onTap: () {
              Navigator.pushNamed(context, "week3");
            },
          ),
          ListTile(
            title: new Text("Inbox"),
            leading: new Icon(Icons.inbox),
          ),
          ListTile(
            title: new Text("My Basket  "),
            leading: new Icon(Icons.shopping_basket),
            onTap: (() {
              Navigator.pushNamed(context, "basket");
            }),
          ),
          ListTile(
            title: new Text("Promotions"),
            leading: new Icon(Icons.discount),
          ),
          ListTile(
            title: new Text('Student List'),
            leading: new Icon(Icons.person),
            onTap: (() {
              Navigator.pushNamed(context, "student");
            }),
          ),
          ListTile(
            title: new Text('Course'),
            leading: new Icon(Icons.cast_for_education),
            onTap: (() {
              Navigator.pushNamed(context, "mycourse");
            }),
          ),
          ListTile(
            title: new Text('Add Recipe'),
            leading: new Icon(Icons.receipt_outlined),
            onTap: (() {
              Navigator.pushNamed(context, "addrecipe");
            }),
          ),
          ListTile(
            title: new Text('Quiz'),
            leading: new Icon(Icons.circle_rounded),
            onTap: (() {
              Navigator.pushNamed(context, "quiz");
            }),
          ),
          ListTile(
            title: new Text('Popular Movie'),
            leading: new Icon(Icons.circle_rounded),
            onTap: (() {
              Navigator.pushNamed(context, "popularmovie");
            }),
          ),
        ],
      ),
    );
  }

  int _currentIndex = 0;
  final List<Widget> _screens = [Home(), Search(), History()];
  final List<String> _title = ['Home', 'Screen', 'History'];
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(_title[_currentIndex]),
        // title: new Container(
        //     margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
        //     child: row(
        //       childern
        //     )),
      ),
      drawer: myDrawer(),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      persistentFooterButtons: <Widget>[
        ElevatedButton(
          onPressed: () {},
          child: Icon(Icons.skip_previous),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Icon(Icons.skip_next),
        ),
      ],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        fixedColor: Colors.green,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "History",
            icon: Icon(Icons.history),
          ),
        ],
      ),
    );
  }
}
