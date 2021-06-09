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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      builder: (context, _) => TogetherQtApp(),
    ),
  );
}



class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  String bibleIndex;
  int bibleIndexInt;
  String alarm;
  String coupleIndex;
  String name;
  String stateMsg;
  Future<void> init() async {
    await Firebase.initializeApp();

    await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(auth.currentUser.uid)
        .snapshots()
        .listen((snapshot) {
      bibleIndexInt= snapshot.data()['bibleIndex'];
      bibleIndex = snapshot.data()['bibleIndex'].toString();
      coupleIndex = snapshot.data()['coupleIndex'].toString();
      name = snapshot.data()['name'].toString();
      alarm = snapshot.data()['alarm'];
      stateMsg = snapshot.data()['stateMsg'];
      notifyListeners();
    });
  }

  String content = "";
  String contentAddr = "";


  Future<void> getBible(String docId) async{
    content = "";
    contentAddr = "";
    await FirebaseFirestore.instance
        .collection('bible').doc(docId)
        .snapshots()
        .listen((event) {
          content = event.data()['content'];
          contentAddr = event.data()['contentAddr'];
          notifyListeners();
    });

  }

}