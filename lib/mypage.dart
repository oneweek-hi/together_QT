import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  Widget build(BuildContext context) {
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
                height: 130,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFEF5),
                ),
                padding: EdgeInsets.all(10.0),
                child: new ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150.0,
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
                                Text('좋아요'), // icon-1
                                Icon(Icons.star,color:Colors.amber), // icon-2
                              ],
                            ),
                          ),
                          ListTile(
                            trailing: Text('개인 정보 수정'),
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
