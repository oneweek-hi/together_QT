import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'main.dart';


class EditPage extends StatefulWidget {
  EditPageState createState()=> EditPageState();
}

class EditPageState extends State<EditPage> {

  TextEditingController _nameController;
  TextEditingController _stateMsgController;
  final _formKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();

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

                        _image == null ? Image.network( snapshot.data['productImage'],
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
                    padding: const EdgeInsets.fromLTRB(30, 10, 0, 20),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          // TODO: Align labels to the bottom and center (103)
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // TODO: Change innermost Column (103)
                            children: <Widget>[

                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0),
                                child:TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
//                                    labelText: 'productName',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '111';
                                    }
                                    return null;
                                  },

                                ),
                              ),


                              Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 5.0),

                                child:TextFormField(
                                  controller: _stateMsgController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
//                                    labelText: 'Price',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '2222';
                                    }
                                    return null;
                                  },
                                ),
                              ),


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

}