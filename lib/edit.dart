import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'main.dart';


class EditPage extends StatefulWidget {
  EditPageState createState()=> EditPageState();
}

class EditPageState extends State<EditPage> {

  TextEditingController _nameController;
  TextEditingController _stateMsgController;
  final _formKey = GlobalKey<FormState>();

  File _image;
  String downloadURL = "";
  String reference ="";
  final picker = ImagePicker();
  String timeNow = DateFormat('yy.MM.dd kk:mm:ss').format(DateTime.now());

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    AppState bible = Provider.of<AppState>(context);

    CollectionReference userInfo = FirebaseFirestore.instance.collection('userInfo');

    return StreamBuilder(
      stream: userInfo.doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        }

        _nameController = TextEditingController(text: bible.name);
        _stateMsgController = TextEditingController(text: bible.stateMsg);

        return MaterialApp(
          home: Scaffold(
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
                    Navigator.pushNamed(context, '/mypage');
                  },
                ),
              ],
            ),
            body: ListView(
              children: [
                Container (
                  child: Column(
                      children: <Widget>[
                        _image == null ? Image.network( snapshot.data['picture']=="" ?  "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FqLRVR%2Fbtq6YnPZ8kv%2F9HdkvByH65lw7rAktC5bjK%2Fimg.png"  :snapshot.data['picture'],
                          fit: BoxFit.fitWidth,
                          width: 600,
                          height: 240,
                        ) : Image.file(_image,
                          fit: BoxFit.fitWidth,
                          width: 600,
                          height: 240,),

                      ]
                  ),
                ),

                IconButton(
                  alignment: Alignment(0.87, 0),
                  icon: Icon(
                    Icons.camera_alt,
                    semanticLabel: 'add',
                  ),
                  onPressed: (){
                    getImage();
                  },
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          // TODO: Align labels to the bottom and center (103)
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // TODO: Change innermost Column (103)
                            children: <Widget>[


                              Container(
                                padding: const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 0),
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    hintText: '이',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 0),
                                child: TextFormField(
                                  controller: _stateMsgController,
                                  decoration: InputDecoration(
                                    hintText: '상태 메세지',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),



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
                                        child: Text('수 정 하 기', style: TextStyle(
                                          fontSize: 15,
                                        ),
                                        ),

                                      ),
                                      onPressed: () {

                                        if(_image == null){
                                          print("here");
                                          userInfo.doc(FirebaseAuth.instance.currentUser.uid).update({
                                            'name':_nameController.text,
                                            'stateMsg':_stateMsgController.text,
                                          }).then((value) => Navigator.pushNamed(context, '/mypage'));

                                        }
                                        else{
                                          print("here222");
                                          uploadFile().then((value) => downloadURLExample().then((value) =>
                                              userInfo.doc(FirebaseAuth.instance.currentUser.uid).update({
                                                'name':_nameController.text,
                                                'stateMsg':_stateMsgController.text,
                                                'picture': downloadURL,
                                              }).then((value) => Navigator.pushNamed(context, '/mypage'))));
                                        }


                                      }, //
                                    ),
                                  )
                              )


                            ]
                        )
                    )

                ),


              ],
            ),
          ),
        );

      },
    );



  }

//  Future<void> uploadFile() async {
//    reference = "productImage/"+timeNow+".png";
//    await firebase_storage.FirebaseStorage.instance
//        .ref(reference)
//        .putFile(_image);
//
//  }
//
//  Future<void> downloadURLExample() async {
//    downloadURL = await firebase_storage.FirebaseStorage.instance
//        .ref(reference)
//        .getDownloadURL();
//
//    // Within your widgets:
//    // Image.network(downloadURL);
//  }

//
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadFile() async {
    reference = "userId/"+timeNow+".png";
    await firebase_storage.FirebaseStorage.instance
        .ref(reference)
        .putFile(_image);

  }

  Future<void> downloadURLExample() async {
    downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(reference)
        .getDownloadURL();

    // Within your widgets:
    // Image.network(downloadURL);
  }

}