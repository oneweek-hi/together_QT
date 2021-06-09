import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class HomePage extends StatefulWidget{
  HomePageSate createState()=> HomePageSate();
}



class HomePageSate extends State<HomePage> {

  CollectionReference dayBible = FirebaseFirestore.instance.collection('bible');
  String content;
  String contentAddr;
//  var userInfoDoc =  FirebaseFirestore.instance.collection('userInfo').doc(FirebaseAuth.instance.currentUser.uid).get();
//
//  var doc =  FirebaseFirestore.instance.collection('userInfo').doc(FirebaseAuth.instance.currentUser.uid).get();

//  int bibleindex = userInfoDoc.data()['bibleIndex'];
//  doc bibleIndex = userInfo.doc(FirebaseAuth.instance.currentUser.uid).get();

//  String bibleIndex;
//  void getBibleIndex() async {
//    CollectionReference collectionRef = FirebaseFirestore.instance.collection('userInfo');
//    var doc = await collectionRef.doc(FirebaseAuth.instance.currentUser.uid).get();
//    print("function checker");
//    print(doc.data()['bibleIndex']);
//    bibleIndex = doc.data()['bibleIndex'].toString();
//    print(bibleIndex);
//  }
//  Future<int> bibleIndex;
//  dayBible.doc().snapshots(),
  @override
  Widget build(BuildContext context) {
    AppState bible = Provider.of<AppState>(context);

    return StreamBuilder(

      stream: dayBible.doc(bible.bibleIndex).snapshots(),
      builder:(context, snapshot) {

        if (snapshot.hasError) {

          return Text("has error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("connetion error");
        }

        if(snapshot.connectionState == ConnectionState.active){
          print(bible.bibleIndex);
          Map<String, dynamic> data = snapshot.data.data();
          content = data['content'].toString();
          contentAddr = data['contentAddr'].toString();

        }
        return Center(
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 90.0),
                Column(
                  children: <Widget>[
                    Icon(Icons.account_balance, color:Colors.amber),
                    Text('오늘의 말씀',
                        style:TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                        )),
                    Text('D + 365',
                        style:TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        )),
                  ],
                ),
                SizedBox(height: 50.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('\“ \n',
                          style:TextStyle(
                            fontSize: 25,
                            color: Colors.grey,
                          )),
                      Container(
                        width: 280,
                        child: Text(
                          content,
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15),
                        ),
                      ),

                      Text(' \” \n',
                          style:TextStyle(
                            fontSize: 25,
                            color: Colors.grey,
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

                SizedBox(height: 60.0),

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
                          child: Text('함께 묵상하기 ♫', style: TextStyle(
                            fontSize: 15,
                          ),
                          ),

                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/write');
                        }, //
                      ),
                    )
                )

//            ElevatedButton.icon(
//              icon: Icon(
//                Icons.account_circle,
//                color: Colors.white,
//                size: 24.0,
//              ),
//              label: Padding(
//                padding:EdgeInsets.fromLTRB(18,13, 18,13),
//                child: Text('함께 묵상하기 ♫',style: TextStyle(
//                  fontSize: 15,
//                ),),
//              ),
//              onPressed: () async {
////                  Navigator.pushNamed(context, '/home');
//              },
////              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amberAccent )),
//
//              style: ElevatedButton.styleFrom(
//                shape: new RoundedRectangleBorder(
//                  borderRadius: new BorderRadius.circular(50.0),
//                ),
//
//              ),
//            )




              ]),

        );
      },
    );


  }

}