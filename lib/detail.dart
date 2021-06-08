import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

//import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail.dart';

import 'app.dart';

class DetailPage extends StatefulWidget {

  final String check;

  const DetailPage({Key key, this.check}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(check);
}

class _DetailPageState extends State<DetailPage> {
  final String check;
  _DetailPageState(this.check);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('everyPeopleQT').where("check", isEqualTo: this.check).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return MaterialApp(
          home: Scaffold(
//            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.amberAccent,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
              children: [
                SizedBox(height: 40.0),
                Container(
                    alignment: Alignment(0.0, 0.0),
                    child: Text('#150 번째 묵상 Mar 23. 2021',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ))),
                SizedBox(height: 15.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('\“ \n\n',
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                          )),
//                      Container(
//                        width: 300,
//                        child: Text(
//                          snapshot.data['bibleContent'],
//                          maxLines: 5,
//                          textAlign: TextAlign.center,
//                          style: TextStyle(fontSize: 18),
//                        ),
//                      ),
                      Text(' \” \n\n',
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                          )),
                    ]),
//                Padding(
//                  padding: EdgeInsets.fromLTRB(0, 30, 0.0, 0.0),
//                  child: Text(
//                    snapshot.data['bibleContentAddr'],
//                    maxLines: 2,
//                    textAlign: TextAlign.center,
//                    style: TextStyle(fontSize: 15),
//                  ),
//                ),
                SizedBox(height: 20.0),
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),

                Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                      return new Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                //                    <--- top side
                                color: Colors.amberAccent,
                                width: 3.0,
                              ),
                            ),
                            color: Color(0xFFFFFEF5),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: new ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 300.0,
                            ),
                            child: ListView(children: [
                              Text(
                                "주희",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    document.data()['todayQT'],
                                    style: TextStyle(fontSize: 15),
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Text('감사 일기',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54))),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  "1. " + document.data()['thanks1'],
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  "2. " + document.data()['thanks2'],
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  "3. " + document.data()['thanks3'],
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
    },
    );
  }

}
