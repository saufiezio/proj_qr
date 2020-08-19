import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:super_qr_reader/super_qr_reader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'Details.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.index,this.list }) : super(key: key);
  List list;
  int index;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result;
  String _name = '';
  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('id');
    return name;
  }

//  String name = 'HAIII';
//
//  String emails = "test10@test.com";
//  String id = '';
//
//  Future<String> getEmail(String id) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String emails = prefs.getString('email');
//    return emails;
//  }
//
//  Future<List> getData(String email) async {
//    print('THIS IS THE EMAIL: $emails');
//    var url = "https://qniti.com/myqniti/apps/load_user.php";
//    final response = await http.post(url, body: {
//      "useremail": emails
//    });
//
//
//    var datauser = json.decode(response.body);
//
//    String id = datauser[0]['userID'];
//    print(id);
//
//    Future<bool> saveNamePreference(String id) async {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      prefs.setString('id', id);
//
//
//      if (datauser[0]['userID'] == '') {
//        print('FAIL');
//      } else {
//        print("success");
//        setState(() {
//          saveNamePreference(id);
//        });
//      }
//    }
//
//    Future<String> getID() async {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      String id = prefs.getString('id');
//      return id;
//    }


  @override
  void initState() {
    getName().then((updateName));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.blue,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 10.0,
              child:
              Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
//                    Padding(padding: EdgeInsets.all(size.width/10),
//                      child: Image ,
//                    ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width / 15, bottom: size.width / 12),
                    child: new Image(
                        height: size.height / 5,
                        fit: BoxFit.fitHeight,
                        image: new AssetImage('assets/scan_logo.png')),
                  ),
                  Text(
                    "Please Scan the QR CODE at the premise before entering",
                    textAlign: TextAlign.center,),
//                  Text(
//                    'HAHA',
//                    textAlign: TextAlign.center,),


                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 10),
                    child:
                    RaisedButton(
                      elevation: 5.0,
                      color: Colors.blue,
                      onPressed: () async {
                        String results = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScanView(),
                          ),
                        );

                        if (results != null) {
                          setState(() {
                            result = results;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Detail(result: results,),
                              ),
                            );
                          }
                          );
                        }
                      },
                      child: Text('TAP TO SCAN', style: TextStyle(
                          color: Colors.white),),
                    ),

                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
  void updateName(name){
    setState(() {
      this._name=name;
    });
  }
}

