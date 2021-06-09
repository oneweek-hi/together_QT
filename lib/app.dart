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


import 'package:flutter/material.dart';
import 'package:togetherqt/partner.dart';
import 'package:togetherqt/userInfo.dart';
import 'package:togetherqt/write.dart';

import 'alarm.dart';
import 'detail.dart';
import 'edit.dart';
import 'home.dart';
import 'mypage.dart';
import 'nav.dart';
import 'list.dart';
import 'login.dart';

// TODO: Convert ShrineApp to stateful widget (104)
class TogetherQtApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'together QT',
      // TODO: Change home: to a Backdrop with a HomePage frontLayer (104)
      home: NavPage(),
      // TODO: Make currentCategory field take _currentCategory (104)
      // TODO: Pass _currentCategory for frontLayer (104)
      // TODO: Change backLayer field value to CategoryMenuPage (104)
      initialRoute: '/login',
      routes:{
        '/nav' : (BuildContext context) => NavPage(),
        '/home' :(BuildContext context) => HomePage(),
        '/write' : (BuildContext context) => WritePage(),
        '/list' : (BuildContext context) => ListPage(),
        '/detail' : (BuildContext context) => DetailPage(),
        '/alarm' : (BuildContext context) => AlarmPage(),
        '/partner' : (BuildContext context) => PartnerPage(),
        '/mypage' : (BuildContext context) => MyPage(),
        '/userInfo' : (BuildContext context) => UserInfoPage(),
        '/edit' : (BuildContext context) => EditPage(),



      },
      onGenerateRoute: _getRoute,
      // TODO: Add a theme (103)
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}

// TODO: Build a Shrine Theme (103)
// TODO: Build a Shrine Text Theme (103)
