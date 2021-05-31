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
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPage extends StatefulWidget{
  ListPageSate createState()=> ListPageSate();
}



class ListPageSate extends State<ListPage>{
  final _suggestions = <String>["test", "test2","test3", "test4", "test5"];
  final _saved = <String>{};     // NEW
  Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('everyPeopleQT').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Center (
          child:ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                leading: Text("135 번째 묵상"),
                title: new Text(document.data()['bibleContentAddr']),
                trailing: Icon(Icons.star_border, color:Colors.amber),
              );
            }).toList(),
          ),
        );
      },
    );
  }

//    return Center(
//      child: ListView(
//          padding: EdgeInsets.symmetric(horizontal: 24.0),
//          children: <Widget>[
//            SizedBox(height: 50.0),
//            Column(
//              children: <Widget>[
//                Text('묵상의 기록',
//                    style:TextStyle(
//                      fontSize: 25,
//                      color: Colors.black,
//                    )),
//                Padding(
//                  padding:EdgeInsets.fromLTRB(0, 10, 0.0, 0.0),
//                  child: Text('매일 동행 하는 기쁨',
//                      style:TextStyle(
//                        fontSize: 13,
//                        color: Colors.grey,
//                      )),
//                )
//              ],
//            ),
//            SizedBox(height: 50.0),
//          ]),
//
//
//
//    );

  }
//
//  Widget _buildSuggestions() {
////    return ListView.builder(
////        padding: const EdgeInsets.all(16.0),
////        itemBuilder: /*1*/ (context, i) {
////
////          return _buildRow(_suggestions[i]);
////        });
//       return ListView(
//           padding: EdgeInsets.all(16.0),
//           children: _buildRow(_suggestions),
//       );
//  }
//
//  Widget _buildRow(String pair) {
//    final alreadySaved = _saved.contains(pair);
//    return ListTile(
//      title: Text(
//        pair,
//      ),
//      trailing: Icon(
//        alreadySaved ? Icons.star : Icons.star_border,
//        color: alreadySaved ? Colors.yellow : null,
//      ),
//      onTap: () {      // NEW lines from here...
//        setState(() {
//          if (alreadySaved) {
//            _saved.remove(pair);
//          } else {
//            _saved.add(pair);
//          }
//        });
//      },               // ... to here.
//    );
//  }
//}
