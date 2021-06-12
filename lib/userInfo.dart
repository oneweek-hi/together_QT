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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:togetherqt/main.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class UserInfoPage extends StatefulWidget {
  final int indexValue;
  const UserInfoPage({Key key, this.indexValue}) : super(key: key);

  @override
  UserInfoPageSate createState() => UserInfoPageSate(indexValue);
}

class UserInfoPageSate extends State<UserInfoPage> {

  int indexValue;
  UserInfoPageSate(this.indexValue);

  CollectionReference dayBible = FirebaseFirestore.instance.collection('userInfo');
  String content;
  String contentAddr;
  final _pUserController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  CollectionReference userInfo = FirebaseFirestore.instance.collection('userInfo');

  Future<void> addUser()  {
    print("UserINfo, indexvalue");
    print(indexValue);
    print((indexValue ~/ 2)+1 );


    return userInfo
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      'userId': FirebaseAuth.instance.currentUser.uid,
      'p_userID':_pUserController.text,
      'name':_nameController.text,
      'bibleIndex':1,
      'stateMsg':"",
      'alarm': DateFormat('h:mm a').format(DateTime.now()).toString(),
      'coupleIndex': (indexValue % 2)==0?(indexValue ~/ 2) :((indexValue ~/ 2)+1 ),
      'picture':'',
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateParterUID() {
    print(FirebaseAuth.instance.currentUser.uid);
    return userInfo
        .doc(_pUserController.text)
        .update({'p_userID':FirebaseAuth.instance.currentUser.uid,})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }



  @override
  Widget build(BuildContext context) {
    AppState bible = Provider.of<AppState>(context);
    return Scaffold(

      body: SafeArea(
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 150.0),
              Container(
                  alignment: Alignment(0.0, 0.0),
                  child: Text('# 함께묵상, 감사일기!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ))),
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment(0.0, 0.0),
                child: Text('사용자 정보 입력',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                    )),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
                child: TextFormField(
                  controller: _pUserController,
                  minLines: 1,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: '파트너 코드 입력',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              SizedBox(height: 15.0),
              Container(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0),
                child: TextFormField(
                  controller: _nameController,
                  minLines: 1,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: '이름 입력',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Container(
                  alignment: Alignment(0.0, 0.0),
                  child: Text('* 파트너 코드가 없으면 빈칸으로 두시면 됩니다. *',
                      style: TextStyle(
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
                    child: Text(
                      '입    력',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  onPressed: () {
//                          if (_formKey.currentState.){
                  print('1');
                            addUser();
                  print('2');
                            // ignore: prefer_is_not_empty
                            if(!(_pUserController.text.isEmpty)){
                              print('3');
                              updateParterUID();
                              print('4');
                            }
                  print('5');

                    Navigator.pushNamed(context, '/nav').then((value) => bible.something(FirebaseAuth.instance.currentUser.uid));
                  }, //
                ),
              )),
              SizedBox(height: 40.0),
            ]),
      ),
//      resizeToAvoidBottomInset: false,
    );
  }
}
