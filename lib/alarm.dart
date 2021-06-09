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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherqt/main.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AlarmPage extends StatefulWidget{
  AlarmPageSate createState()=> AlarmPageSate();
}



class AlarmPageSate extends State<AlarmPage>{
  String _sletectedTime;
  CollectionReference userInfo = FirebaseFirestore.instance.collection('userInfo');

  Future<void> updateAlarmTime() {
    return userInfo
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'alarm':_sletectedTime,})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
//    CollectionReference users = FirebaseFirestore.instance.collection('users');

    AppState bible = Provider.of<AppState>(context);
    if(_sletectedTime == null){
      _sletectedTime = bible.alarm;
      print("hellow heelow ");
      print(_sletectedTime);

    }


    return Center(

      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 50.0),
            Column(
              children: <Widget>[
                Icon(Icons.alarm , size: 30, color:Color(0xFFE0BD32)),
                Padding(
                  padding:EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text('알림 설정',
                      style:TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      )),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text('알림 설정을 하시면,',
                      style:TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text('꾸준히 묵상 할 수 있도록 매일 같은 시간에 알람이 갑니다.',
                      style:TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      )),
                ),
              ],
            ),
            SizedBox(height: 50.0),
            Center(child: Text('$_sletectedTime', style: TextStyle(fontSize: 30),)),
            SizedBox(height: 40.0),

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
                      child: Text('다시 설정', style: TextStyle(
                        fontSize: 15,
                      ),
                      ),

                    ),
                    onPressed: () {
                     Future<TimeOfDay> selected =showTimePicker(
                       context: context,
                         initialTime: TimeOfDay.now(),
                       builder: (context, child) {
                         return Theme(
                           data: ThemeData.light().copyWith(
                             colorScheme: ColorScheme.light(
                               // change the border color
                               primary: Colors.amber,
                               // change the text color
                               onSurface: Colors.grey,
                             ),
                             // button colors
                             buttonTheme: ButtonThemeData(
                               colorScheme: ColorScheme.light(
                                 primary: Colors.grey,
                               ),
                             ),
                           ),
                           child: child,
                         );
                       },
                     );

                     selected.then((time){setState((){ _sletectedTime = '${time.format(context)}';});
                     updateAlarmTime();
                     });
                    }, //
//                      '${time.hour} :${time.minute}'
                  ),

                )
            )


          ]),
    );

  }
}
