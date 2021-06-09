import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:togetherqt/main.dart';

class MyPage extends StatefulWidget {
  MyPageSate createState() => MyPageSate();
}

class MyClipper extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    final epicenter = new Offset(size.width, size.height);
    final distanceToCorner = epicenter.dy;

    final radius = distanceToCorner;
    final diameter = radius;
    return new Rect.fromLTWH(0, 0, 150, 150);

    // Calculate distance from epicenter to the top left corner to make sure clip the image into circle.
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class MyPageSate extends State<MyPage> {
//  CollectionReference dayBible = FirebaseFirestore.instance.collection('bible');
  String content;
  String contentAddr;
  File _image;


  void FlutterDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            //Dialog Main Title
            title:  DecoratedBox(

              decoration: const BoxDecoration(color: Colors.amberAccent),
              child: Align(
                alignment: Alignment.center,
                child:Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10.0),
                    child: Text(
                      "나의 코드 확인",
                      style: TextStyle(
                          color: Colors.white),
                    )
                ),
              ),
            ),
            titlePadding: const EdgeInsets.all(0),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 10.0, 10.0),
                      child: Icon(Icons.star, size:20, color:Colors.amberAccent),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 10.0, 10.0),

                      child: Container(
                        width: 200,
                        child: Text(
                          FirebaseAuth.instance.currentUser.uid,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 1, 0, 0),

                  child: Container(
                    width: 200,
                    child: Text(
                      "* 파트너에게 해당 코드를 알려주시면, 함께 묵상 할 수 있습니다!",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13),
                    ),
                  ),
                ),


              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amberAccent,
//                  onPrimary: Colors.grey,
                ),
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    AppState bible = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('My Page'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      //                    <--- top side
                      color: Colors.amberAccent,
                      width: 3.0,
                    ),
                  ),
                  color: Color(0xFFFFFEF5),
                ),
                padding: EdgeInsets.all(10.0),
                child: new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 300.0,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0.0, 0.0),
                          child: ClipOval(
                            clipper: MyClipper(),
                            child: Container(
                              width: 150,
                              height: 150,
                              child: _image == null
                                  ? Image.network(
                                      "https://cdn.9oodnews.com/news/photo/202102/2965_3351_058.jpg",
                                      fit: BoxFit.fitWidth)
                                  : Image.file(_image, fit: BoxFit.fitWidth),
                            ),
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 10, 0.0, 0.0),
                                child: Text('한주희',
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 10, 0.0, 0.0),
                                child: Text('365일째 동행 중!',
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                              )
                            ])
                      ],
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child:Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFEF5),
                ),
                padding: EdgeInsets.all(10.0),
                child: new ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150
                  ),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: ListTile.divideTiles(
                      //          <-- ListTile.divideTiles
                        context: context,
                        tiles: [
                          ListTile(
                            trailing:Wrap(
                              spacing: 12, // space between two icons
                              children: <Widget>[
                                Text('나의 코드 확인 하기'), // icon-1
                                Icon(Icons.star,color:Colors.amber), // icon-2
                              ],
                            ),
                              onTap: () => FlutterDialog(),


                          ),
                          ListTile(
                            trailing: Text('개인 정보 수정'),
                            onTap: () => Navigator.pushNamed(context, '/edit'),
                          ),
                          ListTile(
                            trailing: Text('로그 아웃'),
                          ),
                        ]).toList(),
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
