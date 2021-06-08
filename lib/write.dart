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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class WritePage extends StatefulWidget{
  WritePageSate createState()=> WritePageSate();
}



class WritePageSate extends State<WritePage>{
  CollectionReference dayBible = FirebaseFirestore.instance.collection('bible');
  String content;
  String contentAddr;
  final _todayQTController = TextEditingController();
  final _thanks1Controller = TextEditingController();
  final _thanks2Controller = TextEditingController();
  final _thanks3Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: dayBible.doc('2').snapshots(),
      builder:(context, snapshot) {

        if (snapshot.hasError) {

          return Text("has error");
        }

        if(snapshot.connectionState == ConnectionState.active){
          Map<String, dynamic> data = snapshot.data.data();
          content = data['content'].toString();
          contentAddr = data['contentAddr'].toString();

        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("connetion error");
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amberAccent,

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
                SizedBox(height: 40.0),

                Container(
                    alignment: Alignment(0.0, 0.0),
                    child: Text('#150 번째 묵상 Mar 23. 2021',
                        style:TextStyle(
                          fontSize: 14,
                          color: Colors.grey,

                        ))),

                SizedBox(height: 15.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('\“ \n\n',
                          style:TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                          )),
                      Container(
                        width: 300,
                        child: Text(
                          content,
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18),
                        ),
                      ),

                      Text(' \” \n\n',
                          style:TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                          )),
                    ]
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0.0, 0.0),
                  child: Text(
                    contentAddr,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15),
                  ),
                ),

                SizedBox(height: 30.0),

                Container(
                  alignment: Alignment(0.0, 0.0),
                  child:Text('오늘의 말씀 묵상',
                      style:TextStyle(
                        fontSize: 23,
                        color: Colors.black,

                      )),),

                SizedBox(height: 10.0),

                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 50.0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide( //                    <--- top side
                                  color: Colors.amberAccent,
                                  width: 3.0,
                                ),
                              ),
                              color: Color(0xFFFFFEF5),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: new ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 200.0,
                              ),
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  reverse: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextFormField(
                                      controller: _todayQTController,
                                      maxLines: 100,
//                          controller: _contentController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.only(
                                            left: 10.0, bottom: 4.0, top: 4.0),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your message to continue';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

//            TextFormField(
//              minLines: 1,
//              maxLines: 3,
//              keyboardType: TextInputType.multiline,
//              decoration: InputDecoration(
//                hintText: '오늘의 묵상을 적어주세요.',
//                hintStyle: TextStyle(
//                    color: Colors.grey
//                ),
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                ),
//              ),
//            ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment(0.0, 0.0),
                  child:Text('오늘의 감사일기',
                      style:TextStyle(
                        fontSize: 23,
                        color: Colors.black,

                      )),),

                SizedBox(height: 10.0),

                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                  child: TextFormField(
                    controller: _thanks1Controller,
                    minLines: 1,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: '1.',
                      hintStyle: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0,0),
                  child: TextFormField(
                    controller: _thanks2Controller,
                    minLines: 1,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: '2.',
                      hintStyle: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                  child: TextFormField(
                    controller: _thanks3Controller,
                    minLines: 1,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: '3.',
                      hintStyle: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  ),
                ),


                SizedBox(height: 50.0),

                Container(
                    alignment: Alignment(0.0, 0.0),
                    child: Text('* 한번 등록된 묵상은 수정할 수가 없습니다 *',
                        style:TextStyle(
                          fontSize: 12,
                          color: Colors.grey,

                        ))),
                SizedBox(height: 10.0),

                Center(
                    child: Container(
                      width: 200,
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(

                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          primary: Color(0xFFFFF3A5),
                          onPrimary: Colors.grey,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 20.0, 15),
                          child: Text('저    장', style: TextStyle(
                            fontSize: 15,
                          ),
                          ),

                        ),
                        onPressed: () {

                          if (_formKey.currentState.validate()){
                                FirebaseFirestore.instance.collection("everyPeopleQT").add({
                                  'todayQT':_todayQTController.text,
                                  'thanks1':_thanks1Controller.text,
                                  'thanks2':_thanks2Controller.text,
                                  'thanks3':_thanks3Controller.text,
                                  'userId': FirebaseAuth.instance.currentUser.uid,
                                  'CreatTime':FieldValue.serverTimestamp(),
                                  'starUIDs': [],
                                  'bibleContent':content,
                                  'bibleContentAddr': contentAddr,
                                  'userQTCounter':1,
                                });
                          }
                          Navigator.pushNamed(context, '/nav');}, //
                      ),
                    )
                ),

                SizedBox(height: 40.0),

              ]),
//      resizeToAvoidBottomInset: false,
        );
      },
    );


  }


}
