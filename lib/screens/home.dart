import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:math_riddles/screens/levels.dart';
import 'package:math_riddles/screens/quiz.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myCurrentLevel;

  var boxInstance;
  var db;
  final _dbName = 'LevelStore';
  @override
  void initState() {
    super.initState();
    //creating box object
    db = Hive.box(this._dbName);
    this.myCurrentLevel = _getCurrentLevel();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    Future<bool> _showMyDialog() async {
      return showDialog<bool>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              title: Center(
                child: Text(
                  "Do you really want to exit the app?",
                  textScaleFactor: 1.1,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(
                        "No",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    //yes btn
                    FlatButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w300),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                )
              ]);
        },
      );
    }

    return WillPopScope(
      onWillPop: _showMyDialog,
      child: Scaffold(
          body: SingleChildScrollView(
        physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: FadeIn(
          duration: Duration(seconds: 1),
          child: Center(
            child: Container(
                width: _size.width,
                height: _size.height,
                color: Colors.deepOrange.shade50,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        child: CustomPaint(
                          size: Size(400, 400),
                          painter: MyPainter(),
                        )),
                    Positioned(
                      top: _size.height * 0.27,
                      left: _size.width * 0.10,
                      child: ZoomIn(
                        duration: Duration(seconds: 2),
                        child: Text(
                          "𝕄𝕒𝕥𝕙 ℝ𝕚𝕕𝕕𝕝𝕖𝕤",
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.deepOrange),
                        ),
                      ),
                    ),
                    Positioned(
                        top: _size.height * 0.4,
                        left: _size.width * 0.2,
                        child: Column(
                          children: [
                            //play btn
                            GestureDetector(
                              onTap: () {
                                return Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => QuizAtLevel(
                                              currLevel: _getCurrentLevel(),
                                            )));
                              },
                              child: Container(
                                width: _size.width * 0.6,
                                height: 50.0,
                                margin: EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                    color: const Color(0xffe1bee7),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: const Color(0xfff3e5f5),
                                        spreadRadius: 2.0,
                                      )
                                    ],
                                    border: Border(
                                        bottom: BorderSide(
                                      color: const Color(0xffd500f9),
                                      width: 2.0,
                                    ))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: Icon(
                                      Icons.play_arrow_outlined,
                                      size: 40.0,
                                    )),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Let's Play",
                                          style: TextStyle(
                                              fontFamily: 'PlayfairDisplay',
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            //levels btn
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LevelScreen())),
                              child: Container(
                                width: _size.width * 0.6,
                                height: 50.0,
                                margin: EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                    color: const Color(0xffe1bee7),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: const Color(0xfff3e5f5),
                                        spreadRadius: 2.0,
                                      )
                                    ],
                                    border: Border(
                                        bottom: BorderSide(
                                      color: const Color(0xffd500f9),
                                      width: 2.0,
                                    ))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: Icon(
                                      Icons.grid_view,
                                      size: 40.0,
                                    )),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Levels",
                                          style: TextStyle(
                                              fontFamily: 'PlayfairDisplay',
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            //exit btn
                            GestureDetector(
                              onTap: () async =>
                                  await _showMyDialog() ? exit(0) : null,
                              child: Container(
                                width: _size.width * 0.6,
                                height: 50.0,
                                margin: EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                    color: const Color(0xffe1bee7),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: const Color(0xfff3e5f5),
                                        spreadRadius: 2.0,
                                      )
                                    ],
                                    border: Border(
                                        bottom: BorderSide(
                                      color: const Color(0xffd500f9),
                                      width: 2.0,
                                    ))),
                                child: FlatButton(
                                  onPressed: () {
                                    print("object");
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                          child: Icon(
                                        Icons.close_outlined,
                                        size: 40.0,
                                      )),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Exit",
                                            style: TextStyle(
                                                fontFamily: 'PlayfairDisplay',
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: CustomPaint(
                          size: Size(400, 400),
                          painter: MyPainter2(),
                        )),
                  ],
                )),
          ),
        ),
      )),
    );
  }

  int _getCurrentLevel() {
    if (db.get('myCurrentLevel') == null) {
      //storing level 1 by deault
      db.put('myCurrentLevel', 1);
      //storing answers of each level
      db.put('1', 27);
      db.put('2', 16);
      db.put('3', 27);
      db.put('4', 25);
      db.put('5', 27);
      db.put('6', 36);
      db.put('7', 1111);
      db.put('8', 2);
      db.put('9', 19);
      db.put('10', 36);
    }
    return db.get('myCurrentLevel');
  }
}
// class HomeScreen extends StatelessWidget {
//   @override

//   @override
//   Widget build(BuildContext context) {
//     final _size = MediaQuery.of(context).size;
//     Future<bool> _onexit() {
//       Dialog fancyDialog = Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           height: 200.0,
//           width: 200.0,
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 width: double.infinity,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 130.00,
//                   color: Theme.of(context).primaryColor,
//                   child: Center(
//                     child: Text(
//                       "Do you really want to exit the app?",
//                       textScaleFactor: 1.1,
//                       style: TextStyle(
//                           fontSize: 22.0,
//                           fontFamily: 'PlayfairDisplay',
//                           fontWeight: FontWeight.w400,
//                           color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ),
//               //actions
//               Positioned(
//                   top: 0,
//                   right: 0,
//                   child: Container(
//                     width: 30.0,
//                     height: 30,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pop(context, false),
//                       child: Container(
//                         padding: EdgeInsets.all(5.0),
//                         height: 20.0,
//                         child: Icon(
//                           Icons.cancel,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   )),
//               Positioned(
//                 bottom: 0,
//                 // left: 0,
//                 right: 0,
//                 child: Container(
//                     color: Colors.white,
//                     height: 70.0,
//                     width: 300,
//                     child: Center(
//                       child: Container(
//                           child: GestureDetector(
//                         onTap: () => Navigator.pop(context, true),
//                         child: Container(
//                           padding: EdgeInsets.all(5.0),
//                           child: Text(
//                             "Yes",
//                             textScaleFactor: 1.6,
//                           ),
//                         ),
//                       )),
//                     )),
//               ),
//             ],
//           ),
//         ),
//       );
//       showDialog(
//           context: context, builder: (BuildContext context) => fancyDialog);
//     }

//     return WillPopScope(
//       onWillPop: _onexit,
//       child: Scaffold(
//         body: SingleChildScrollView(
//             physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//             child: Center(
//               child: Container(
//                 width: _size.width,
//                 height: _size.height,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: _size.height * 0.35,
//                     ),
//                     //play btn
//                     GestureDetector(
//                       onTap: () => print("object"),
//                       child: Container(
//                         width: _size.width * 0.6,
//                         height: 50.0,
//                         margin: EdgeInsets.symmetric(vertical: 4.0),
//                         decoration: BoxDecoration(
//                             color: const Color(0xffe1bee7),
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 4.0,
//                                 color: const Color(0xfff3e5f5),
//                                 spreadRadius: 2.0,
//                               )
//                             ],
//                             border: Border(
//                                 bottom: BorderSide(
//                               color: const Color(0xffd500f9),
//                               width: 2.0,
//                             ))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Expanded(
//                                 child: Icon(
//                               Icons.play_arrow_outlined,
//                               size: 40.0,
//                             )),
//                             Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   "Let's Play",
//                                   style: TextStyle(
//                                     fontFamily: 'PlayfairDisplay',
//                                       fontSize: 24.0,
//                                       fontWeight: FontWeight.bold),
//                                 ))
//                           ],
//                         ),
//                       ),
//                     ),
//                     //levels btn
//                     GestureDetector(
//                       onTap: () => Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => LevelScreen())),
//                       child: Container(
//                         width: _size.width * 0.6,
//                         height: 50.0,
//                         margin: EdgeInsets.symmetric(vertical: 4.0),
//                         decoration: BoxDecoration(
//                             color: const Color(0xffe1bee7),
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 4.0,
//                                 color: const Color(0xfff3e5f5),
//                                 spreadRadius: 2.0,
//                               )
//                             ],
//                             border: Border(
//                                 bottom: BorderSide(
//                               color: const Color(0xffd500f9),
//                               width: 2.0,
//                             ))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Expanded(
//                                 child: Icon(
//                               Icons.grid_view,
//                               size: 40.0,
//                             )),
//                             Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   "Levels",
//                                   style: TextStyle(
//                                       fontSize: 24.0,
//                                       fontWeight: FontWeight.bold),
//                                 ))
//                           ],
//                         ),
//                       ),
//                     ),
//                     //exit btn
//                     GestureDetector(
//                       onTap: () async => await _onexit() ? exit(0) : null,
//                       child: Container(
//                         width: _size.width * 0.6,
//                         height: 50.0,
//                         margin: EdgeInsets.symmetric(vertical: 4.0),
//                         decoration: BoxDecoration(
//                             color: const Color(0xffe1bee7),
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 4.0,
//                                 color: const Color(0xfff3e5f5),
//                                 spreadRadius: 2.0,
//                               )
//                             ],
//                             border: Border(
//                                 bottom: BorderSide(
//                               color: const Color(0xffd500f9),
//                               width: 2.0,
//                             ))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Expanded(
//                                 child: Icon(
//                               Icons.close_outlined,
//                               size: 40.0,
//                             )),
//                             Expanded(
//                                 flex: 2,
//                                 child: Text(
//                                   "Exit",
//                                   style: TextStyle(
//                                       fontSize: 24.0,
//                                       fontWeight: FontWeight.bold),
//                                 ))
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )),
//       ),
//     );
//   }
// }

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3500000, 0);
    path_0.quadraticBezierTo(size.width * 0.2735000, size.height * 0.3185000, 0,
        size.height * 0.3500000);
    path_0.quadraticBezierTo(
        size.width * -0.0033750, size.height * 0.1485000, 0, 0);

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 140, 33, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.2710000, 0);
    path_1.quadraticBezierTo(size.width * 0.1617500, size.height * 0.0605000,
        size.width * 0.1500000, size.height * 0.1500000);
    path_1.quadraticBezierTo(size.width * 0.1375000, size.height * 0.2552500, 0,
        size.height * 0.2770000);
    path_1.quadraticBezierTo(
        size.width * -0.0040000, size.height * 0.2077500, 0, 0);
    path_1.quadraticBezierTo(size.width * 0.0752500, size.height * -0.0060000,
        size.width * 0.2710000, 0);
    path_1.close();

    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6795000, size.height);
    path_0.quadraticBezierTo(size.width * 0.7258750, size.height * 0.6997500,
        size.width, size.height * 0.6770000);
    path_0.quadraticBezierTo(
        size.width, size.height * 0.7577500, size.width, size.height);
    path_0.lineTo(size.width * 0.6795000, size.height);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 187, 33, 230)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_1 = Path();
    path_1.moveTo(size.width, size.height);
    path_1.lineTo(size.width * 0.7450000, size.height);
    path_1.quadraticBezierTo(size.width * 0.7907500, size.height * 0.8655000,
        size.width * 0.8700000, size.height * 0.8400000);
    path_1.quadraticBezierTo(size.width * 0.9560000, size.height * 0.8363750,
        size.width, size.height * 0.7135000);

    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
