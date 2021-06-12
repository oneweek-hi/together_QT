// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//
//import 'model/products_repository.dart';
//import 'model/product.dart';
//import 'detail.dart';
//
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:togetherqt/main.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class PartnerPage extends StatefulWidget {
  PartenrPageSate createState() => PartenrPageSate();
}

class MyClipper extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    final epicenter = new Offset(size.width, size.height);
    final distanceToCorner = epicenter.dy;

    final radius = distanceToCorner;
    final diameter = radius;
    return new Rect.fromLTWH(0, 0, 170, 170);

    // Calculate distance from epicenter to the top left corner to make sure clip the image into circle.
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class PartenrPageSate extends State<PartnerPage> {
  File _image;
  String p_name;
  String p_stateMsg;
  String p_picture;

  @override
  Widget build(BuildContext context) {
    AppState bible = Provider.of<AppState>(context);
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    CollectionReference users =
        FirebaseFirestore.instance.collection('userInfo');
//    print(bible.p_userID);

    if (bible.p_userID == ""){
      return Text("파트너를 추가해주세요!");
    }else{
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('userInfo')
            .doc(bible.p_userID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("has error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("connetion error");
          }

          if (snapshot.connectionState == ConnectionState.active) {
//          print(bible.bibleIndex);
            Map<String, dynamic> data = snapshot.data.data();
            p_name = data['name'].toString();
            p_stateMsg = data['stateMsg'].toString();
            p_picture = data['picture'].toString();
          }

          return Center(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 70.0),
                Column(
                  children: <Widget>[
                    Text('함께 하는 사람',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0.0, 0.0),
                      child: Text('매일 동행 하는 기쁨',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          )),
                    )
                  ],
                ),
                SizedBox(height: 40.0),
                Center(
                  child: ClipOval(
                    clipper: MyClipper(),
                    child: Container(
                        width: 170,
                        height: 170,
                        child: p_picture == ""
                            ? Image.network(
                            "https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg",
                            fit: BoxFit.fitWidth)
                            : Image.network(
                            p_picture,
                            fit: BoxFit.fitWidth)),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 14, 10.0, 0.0),
                          child: Icon(Icons.account_circle,
                              size: 23, color: Color(0xFFE0BD32)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0.0, 0.0),
                          child: Text(p_name,
                              style: TextStyle(
                                fontSize: 23,
                              )),
                        ),
                      ]),
                ),
                p_picture == null
                    ? Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0.0, 0.0),
                    child: Text(" ",
                        style: TextStyle(
                          fontSize: 13,
                        )),
                  ),
                )
                    : Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0.0, 0.0),
                    child: Text(p_stateMsg,
                        style: TextStyle(
                          fontSize: 13,
                        )),
                  ),
                ),
                SizedBox(height: 30.0),
              ],
            ),
          );
        },
      );
    }

  }
}
