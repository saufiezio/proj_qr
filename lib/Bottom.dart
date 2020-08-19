import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'scanner.dart';
import 'loadplace.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.initial}) : super(key: key);
  final int initial;
  final String title;





  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  static MyHomePage a = new MyHomePage();
  MotionTabController _tabController;
String id ='';

  Future<String> getEmail(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');
    return id;
  }

  @override
  void initState() {
    getEmail(id).then((updateName));

    super.initState();
    _tabController = new MotionTabController(initialIndex:widget.initial,vsync: this);


  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue,

        bottomNavigationBar: MotionTabBar(
          tabOneName: "Home",
          tabTwoName: "Scan QR",
          tabThreeName: "Profile",
          tabOneIcon: Icons.home,
          tabTwoIcon: Icons.crop_free,
          tabThreeIcon: Icons.account_box,
          tabIconColor: Colors.black,
          tabSelectedColor: Colors.lightBlue,
          initialSelectedTab: widget.initial,
          textStyle: TextStyle(color: Colors.blueGrey),
          onTabItemSelected: (int value){
            print(widget.initial);
            setState(() {
              _tabController.index = value;
            });
          },
        ),
        body: MotionTabBarView(
          controller: _tabController,
          children: <Widget>[


            Home(result: id,),

            HomePage(),

            Profile(),
          ],
        )
    );
  }


  void updateName(id){
    setState(() {
      this.id=id;
    });
  }


}