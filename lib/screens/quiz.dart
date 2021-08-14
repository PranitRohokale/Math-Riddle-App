import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:math_riddles/screens/levels.dart';

class QuizAtLevel extends StatefulWidget {
  int currLevel;
  QuizAtLevel({this.currLevel});
  @override
  _QuizAtLevelState createState() =>
      _QuizAtLevelState(currLevel: this.currLevel);
}

class _QuizAtLevelState extends State<QuizAtLevel> {
  int currLevel;
  List<int> _answers = [27, 16, 27, 25, 27];
  TextEditingController _ansController = TextEditingController();
  _QuizAtLevelState({this.currLevel});

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
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: FadeIn(
        duration: const Duration(seconds: 2),
        child: Container(
          // height: _size.height,
          // width: _size.width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: _size.width,
                    height: _size.height * 0.15,
                    color: Theme.of(context).primaryColor,
                  )),
              Positioned(
                bottom: _size.height * 0.05,
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    width: _size.width * 0.95,
                    height: 200,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                    child: _myInputBox(),
                  ),
                ),
              ),
              Positioned(
                top: _size.height * 0.25,
                child: Container(
                  width: _size.width * 0.9,
                  height: 300.0,
                  child: Image.asset("images/riddle_$currLevel.jpeg",
                      fit: BoxFit.cover, filterQuality: FilterQuality.medium),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.0,
                          spreadRadius: 3.0,
                          color: Colors.black45,
                        )
                      ]),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                    padding: EdgeInsets.only(top: 20.0),
                    width: _size.width,
                    height: _size.height * 0.2,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4.0,
                              spreadRadius: 2.0,
                              color: Colors.deepOrangeAccent.shade100)
                        ],
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(_size.width * 0.15),
                            bottomRight: Radius.circular(_size.width * 0.15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 30.0,
                          ),
                        ),
                        SizedBox(
                          width: 35.0,
                        ),
                        Row(
                          children: [
                            Text(
                              "Level",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 25.0),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              width: 40.0,
                              height: 40.0,
                              child: Center(
                                child: Text(this.currLevel.toString(),
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25.0)),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 35.0,
                        ),
                        Container(
                          child: GestureDetector(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.grid_view,
                                  size: 35.0,
                                ),
                                // Text("Levels",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 22.0)),
                              ],
                            ),
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LevelScreen())),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getNumberBtn(int number) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          setState(() {
            this._ansController.text += number.toString();
          });
        },
        child: Card(
          elevation: 2,
          child: Container(
            color: Colors.orangeAccent.shade200,
            height: 50.0,
            width: 18.0,
            child: Center(
              child: Text(
                "$number",
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _myInputBox() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  readOnly: true,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
                  controller: _ansController,
                  decoration: InputDecoration(
                      hintText: "Enter",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                      filled: true,
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffix: GestureDetector(
                        //clear the input
                        onTap: () {
                          setState(() {
                            _ansController.text = '';
                          });
                        },
                        child: Container(
                          child: Icon(
                            Icons.cancel,
                            color: Theme.of(context).primaryColor,
                            size: 25.0,
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 2,
                  child: FlatButton(
                    colorBrightness: Brightness.light,
                    color: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Enter..",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      //ans validation
                      if (!_ansController.text.isEmpty) {
                        int inputAns = int.parse(_ansController.text);
                        int actualAns = db.get('$currLevel');
                        print("currlevel : $currLevel");
                        print("input : $inputAns");
                        print("actualans : $actualAns");
                        if (inputAns == actualAns) {
                          _updateLevel(currLevel);
                          _alertBox('Correct...\n\t\t Excellent!!',
                              Icons.trending_up);
                          Timer(Duration(seconds: 1),
                              () => Navigator.pop(context));

                          Future.delayed(
                              Duration(seconds: 1),
                              () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => QuizAtLevel(
                                            currLevel: this.currLevel + 1,
                                          ))));
                        } else {
                          // _alertBox();
                          _alertBox('Wrong answer!!\n\t\tTry again...',
                              Icons.cancel_outlined);

                          Timer(Duration(seconds: 1),
                              () => Navigator.pop(context));

                          setState(() {
                            _ansController.text = "";
                          });
                        }
                      }
                    },
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getNumberBtn(1),
              getNumberBtn(2),
              getNumberBtn(3),
              getNumberBtn(4),
              getNumberBtn(5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getNumberBtn(6),
              getNumberBtn(7),
              getNumberBtn(8),
              getNumberBtn(9),
              getNumberBtn(0),
            ],
          ),
        ],
      );

  _updateLevel(int n) {
    int curr = db.get('myCurrentLevel');
    if (n == curr) db.put('myCurrentLevel', n + 1);
  }

  _alertBox(String str, IconData icon) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              str,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
            ),
            content: SingleChildScrollView(
              child: Icon(
                icon,
                size: 55.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        });
  }
}

