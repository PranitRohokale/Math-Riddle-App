import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:math_riddles/screens/quiz.dart';

class LevelScreen extends StatefulWidget {
  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int myCurrentLevel;
  var db;
  final _dbName = 'LevelStore';
  @override
  void initState() {
    super.initState();
    //creating box object
    db = Hive.box(this._dbName);
    this.myCurrentLevel = _getCurrentLevel();
  }

  final int _totalLevels = 100;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FadeIn(
        duration: Duration(seconds: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.25,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(75.0))),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 40.0,
                          color: Colors.white,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 90.0, top: 5.0),
                    child: ElasticIn(
                      delay: Duration(seconds: 1),
                      child: Text(
                        "Levels",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.3,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 0),
                height: size.height * 0.75,
                width: size.width,
                child: ListView(
                  physics:
                      ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: 5.0, left: 5.0, top: 5.0, bottom: 15.0),
                      width: size.width * 0.85,
                      height: size.height * 0.75,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(23),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black12,
                              spreadRadius: 3.0,
                              offset: Offset.zero,
                            )
                          ]),

                      //list
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15.0),
                        child: GridView.builder(
                            itemCount: this._totalLevels,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10.0,
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 10.0),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  child: Container(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              index + 1 <= _getCurrentLevel()
                                                  ? Icons.lock_open_rounded
                                                  : Icons.lock_outline_rounded,
                                              color: index + 1 <=
                                                      _getCurrentLevel()
                                                  ? Colors.green
                                                  : Colors.black,
                                              size: 30.0,
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "${index + 1}",
                                              textScaleFactor: 1.5,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0),
                                            ),
                                          ],
                                        )),
                                    decoration: BoxDecoration(
                                        color: index + 1 <= _getCurrentLevel()
                                            ? Colors.grey.shade100
                                            : Colors.grey.shade200,
                                        // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blueGrey.shade100,
                                            blurRadius: 3.0,
                                          )
                                        ],
                                        border: Border(
                                            bottom: BorderSide(
                                                color: index + 1 <=
                                                        _getCurrentLevel()
                                                    ? Colors.green
                                                    : Colors.red,
                                                width: 2.5,
                                                style: BorderStyle.solid))),
                                  ),
                                  onTap: () {
                                    if (index + 1 <= _getCurrentLevel())
                                      return Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => QuizAtLevel(
                                                    currLevel: index + 1,
                                                  )));
                                    else
                                      null;
                                  });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int _getCurrentLevel() {
    if (db.get('myCurrentLevel') == null) db.put('myCurrentLevel', 1);
    return db.get('myCurrentLevel');
  }
}
