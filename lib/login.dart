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
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:togetherqt/userInfo.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
//
//  Future<UserCredential> signInWithAnonymous() async {
//    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
//    return userCredential;
//  }

  Future<bool> checkIfDocExists(String docId) async {
    try {
      CollectionReference collectionRef = FirebaseFirestore.instance.collection('userInfo');
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: ListView(

          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 150.0),
            Column(
              children: <Widget>[
                Image.asset('assets/logo.png'),
//                Text('감사일기',
//                    style:TextStyle(
//                      fontSize: 18,
//                      color: Colors.grey,
//                    )),
              ],
            ),
            SizedBox(height: 120.0),

            // TODO: Wrap Password with AccentColorOverride (103)

          Center(
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.account_circle  ,
                  color: Colors.white,
                  size: 24.0,
                ),
                label: Padding(
                  padding:EdgeInsets.fromLTRB(18,13, 18,13),
                  child: Text('Google Login',style: TextStyle(
                    fontSize: 15,
                  ),),
                ),
                onPressed: () async {

//                  int indexValue = await FirebaseFirestore.instance.collection('userInfo').snapshots.data.length;
                  print("check");
                  QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('userInfo').get();
                  List<DocumentSnapshot> _myDocCount = _myDoc.docs;
                  print(_myDocCount.length);


                  signInWithGoogle().then((value) => checkIfDocExists(FirebaseAuth.instance.currentUser.uid) != null? Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserInfoPage(indexValue: _myDocCount.length+1)))
                      : Navigator.pushNamed(context, '/userInfo'));




//                  Navigator.pushNamed(context, '/home');
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amberAccent )),

              )),

            SizedBox(height: 18.0),


        Container(
            alignment: Alignment(0.0, 0.0),
            child: Text('* Only Google Login is available *',
                style:TextStyle(
                  fontSize: 12,
                  color: Colors.grey,

                ))),

//            Padding(
//              padding: EdgeInsets.fromLTRB(20,15, 20.0,15),
//                 child:
//            )

          ],
        ),
      ),
    );
  }
}



// TODO: Add AccentColorOverride (103)
