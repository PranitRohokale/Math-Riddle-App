import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:math_riddles/screens/home.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox("LevelStore");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Math Riddles',
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
        // fontFamily: 'PlayfairDisplay',
      ),
    );
  }
}

class MyAppState extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppState> {
  var boxInstance;
  var db;
  final _dbName = 'LevelStore';
  @override
  void initState() {
    super.initState();
      //creating box object
    db = Hive.box(this._dbName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Tutorial',
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // var db = Hive.box(this._dbName);
              // if (db.get('myCurrentLevel') == null) db.put('myCurrentLevel', 10);

              // print(db.values.toList());
              db.deleteFromDisk();
            }),
        body: FutureBuilder(
          future: Hive.openBox('LevelStore'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return Center(child: Text(snapshot.data.toString()));
            } else
              return Scaffold();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
