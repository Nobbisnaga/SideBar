import 'package:flutter/material.dart';
import 'package:flutter_application_2/sidebar/sidebar.dart';
import '../pages/homepage.dart';



class SideBarLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: <Widget>[
        HomePage(),
        SideBar(),
      ],
      ),
    );
  }
}