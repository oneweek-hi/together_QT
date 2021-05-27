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

import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AlarmPage extends StatefulWidget{
  AlarmPageSate createState()=> AlarmPageSate();
}



class AlarmPageSate extends State<AlarmPage>{
  int _currentIndex=2;


  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
//    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
//        leading: IconButton(
//
//          icon: Icon(
//            Icons.person ,
//            semanticLabel: 'profile',
//          ),
//          onPressed: () {
//            Navigator.pushNamed(context, '/mypage');
//          },
//        ),
        title: Text('함께묵상'),
        actions: <Widget>[

          IconButton(
            icon: Icon(
              Icons.person,
              semanticLabel: 'profile',
            ),
            onPressed: () async {
//              await FirebaseAuth.instance.signOut().then((value) => Navigator.pushNamed(context, '/login'));
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 90.0),
            Column(
              children: <Widget>[
                Icon(Icons.account_balance, color:Colors.amber),
                Text('묵상의 기록',
                    style:TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                    )),
                Text('매일 동행 하는 기',
                    style:TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    )),
              ],
            ),
            SizedBox(height: 50.0),



          ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
//        type: BottomNavigationBarType.shifting,
//        backgroundColor: Color(0xFFF8F7F5),
        iconSize: 25,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.import_contacts, color:Color(0xFFE0BD32)), title: Text('home', style: TextStyle(color:Color(0xFFE0BD32))),backgroundColor: Color(0xFFF8F7F5),),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_sharp,color:Color(0xFFE0BD32)), title: Text('list', style: TextStyle(color:Color(0xFFE0BD32))),backgroundColor: Color(0xFFF8F7F5),),
          BottomNavigationBarItem(icon: Icon(Icons.access_alarm,color:Color(0xFFE0BD32)), title: Text('alarm', style: TextStyle(color:Color(0xFFE0BD32))),backgroundColor: Color(0xFFF8F7F5),),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded,color:Color(0xFFE0BD32)), title: Text('partner', style: TextStyle(color:Color(0xFFE0BD32))),backgroundColor: Color(0xFFF8F7F5),),
        ],
        onTap:(index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
//description_rounded
      //grade_outlined group
//      resizeToAvoidBottomInset: false,
    );

  }
}
