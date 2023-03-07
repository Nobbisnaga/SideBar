import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart'; 
import 'dart:async';
import 'sidebar.dart';

class SideBar extends StatefulWidget {

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {

late AnimationController _animationController;
late StreamController<bool> isSideBarOpenedStreamController;
late Stream<bool> isSideBarOpenedStream;
late StreamSink<bool> isSideBarOpenedSink;
final bool isSidebarOpened = true;
final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSideBarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSideBarOpenedStreamController.stream;
    isSideBarOpenedSink = isSideBarOpenedStreamController.sink;
  }


  @override
  void dispose(){
    _animationController.dispose();
    isSideBarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if(isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
    }else{
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;


    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSideBarOpenedAsync){
        return AnimatedPositioned(
      duration: _animationDuration,
      top: 0,
      bottom: 0,
      left: isSidebarOpened ? 0 : 0,
      right: isSidebarOpened ? 0 : screenWidth - 45,
      child: Row(
      children: <Widget>[
      Expanded(
        child: Container(
          color: Color(0xFF262AAA),
          child: Column(
            children: <Widget>[
              SizedBox(height: 100,),
              ListTile(
                title: Text(
                "SEA",
                style: TextStyle(color:Colors.white, fontSize:30, fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  "SeaAtlantis.com",
                  style: TextStyle(color:Color(0xFF1BB5FD), 
                  fontSize:20,
                  ),
                ),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.perm_identity,
                    color: Colors.white,
                  ),
                    radius: 40,
                ),
              ),
            ],
          ),
        ),
      ),
       Align(
        alignment: Alignment(0, -0.9),
        child: GestureDetector(
        onTap: () {
          onIconPressed();
        },
        child:Container(
        width: 35,
        height: 110,
        color: Color(0xFF262AAA),
        alignment: Alignment.centerLeft,
          child: AnimatedIcon(
          progress: _animationController.view,
          icon: AnimatedIcons.menu_close,
          color: Color(0xFF1BB5FD),
          size: 25,
          ),
         ),
        ),
       ),
      ],
     ),
    );
      },
   );


    
   }
  }



