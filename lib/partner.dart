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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class PartnerPage extends StatefulWidget{
  PartenrPageSate createState()=> PartenrPageSate();
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

class PartenrPageSate extends State<PartnerPage>{
  File _image;


  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
//    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Center(
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 70.0),
            Column(
              children: <Widget>[
                Text('함께 하는 사람',
                    style:TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    )),
                Padding(
                  padding:EdgeInsets.fromLTRB(0, 10, 0.0, 0.0),
                  child: Text('매일 동행 하는 기쁨',
                      style:TextStyle(
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
                  child:_image == null ? Image.network( "https://cdn.9oodnews.com/news/photo/202102/2965_3351_058.jpg",
                      fit: BoxFit.fitWidth
                  ) : Image.file(_image,
                      fit: BoxFit.fitWidth
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),

            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding:EdgeInsets.fromLTRB(0, 14, 10.0, 0.0),
                      child:Icon(Icons.account_circle , size: 23, color:Color(0xFFE0BD32)),),

                    Padding(
                      padding:EdgeInsets.fromLTRB(0, 10, 0.0, 0.0),
                      child: Text('오 앵 무',
                          style:TextStyle(
                            fontSize: 23,
                          )),
                    ),
                  ]

              ),
            ),

            Center(
              child:Padding(
                padding:EdgeInsets.fromLTRB(0, 10, 0.0, 0.0),
                child: Text('매일 매일 꾸준히 묵상 하자!',
                    style:TextStyle(
                      fontSize: 13,
                    )),
              ),
            ),
            SizedBox(height: 30.0),


//            Center(
//                child: Container(
//                  width: 200,
//                  child: ElevatedButton(
//
//                    style: ElevatedButton.styleFrom(
//
//                      shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(50.0),
//                      ),
//                      primary: Color(0xFFFFF3A5),
//                      onPrimary: Colors.grey,
//                    ),
//                    child: Padding(
//                      padding: EdgeInsets.fromLTRB(20, 15, 20.0, 15),
//                      child: Text('응원 하기 ♫', style: TextStyle(
//                        fontSize: 15,
//                      ),
//                      ),
//
//                    ),
//                    onPressed: () {
//                      Navigator.pushNamed(context, '/write');
//                    }, //
//                  ),
//                )
//            )

    ],
    ),
    );
  }
}
