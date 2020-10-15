import 'package:corona_dashboard/MyMainScreen.dart';
import 'package:corona_dashboard/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyAppBar.dart';
import 'MyDrawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: MyMainScreen(),
    );
  }
}
