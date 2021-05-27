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

class WritePage extends StatefulWidget{
  WritePageSate createState()=> WritePageSate();
}



class WritePageSate extends State<WritePage>{
  int _currentIndex=0;


  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
//    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Widget titleSection = Container(
      padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 50.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Form(
//          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 350,
                decoration: BoxDecoration(
                  color: Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 25,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10.0),
                child: new ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 350.0,
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
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
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );

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
                      '우리가 알거니와 하나님을 사랑하는 자 곧 그 뜻대로 부르심을 입은 자들에게는 모든 것이 합력하여 선을 이루느니라',
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
                '로마서 8장 28절 말씀',
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


//        TextField(
//          decoration: InputDecoration(
//              border: OutlineInputBorder(),
//              hintText: 'Enter a search term',
//            keyboardType: TextInputType.multiline,
//            maxLines: null,
//          ),
//        ),
            titleSection,

            TextFormField(
              minLines: 3,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: '오늘의 묵상을 적어주세요.',
                hintStyle: TextStyle(
                    color: Colors.grey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              alignment: Alignment(0.0, 0.0),
              child:Text('오늘의 감사일기',
                  style:TextStyle(
                    fontSize: 23,
                    color: Colors.black,

                  )),),

            SizedBox(height: 10.0),

//            TextFormField(
//              minLines: 3,
//              maxLines: 5,
//              keyboardType: TextInputType.multiline,
//              decoration: InputDecoration(
//                hintText: '감사했던 일 3가지를 적어주세요!',
//                hintStyle: TextStyle(
//                    color: Colors.grey
//                ),
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                ),
//              ),
//            ),


            SizedBox(height: 30.0),

            Container(
                alignment: Alignment(0.0, 0.0),
                child: Text('* 한번 등록된 묵상을 수정할 수가 없습니다 *',
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
                      Navigator.pushNamed(context, '/home');}, //
                  ),
                )
            ),

            SizedBox(height: 40.0),





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
