import 'package:corona_dashboard/MyMainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Center(
          child: Text(
            'COVID-19 DASHBOARD',
            style: GoogleFonts.nunito(
              fontSize: 20.0,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.autorenew,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
