import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:super_qr_reader/super_qr_reader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'Details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.index, this.list}) : super(key: key);
  List list;
  int index;

  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  String result;
  String name = '';
  String emails = '';
  String phones = '';
  String id = '';
  TextEditingController email = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name');
    return name;
  }

  Future<String> getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('id');
    return id;
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String emails = prefs.getString('email');
    return emails;
  }

  Future<String> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phones = prefs.getString('phone');
    return phones;
  }

  Future<List> getData() async {
    var url = "https://qniti.com/myqniti/apps/chgpassword..php";
    final response = await http.post(url, body: {
      "id": name,
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('QR NOT RECOGNIZE');
    }
  }

  @override
  void initState() {
    getName().then((updateName));
    getPhone().then((updatePhone));
    getEmail().then((updateEmail));

    super.initState();
    getID().then((updateID));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width / 12, vertical: size.width / 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 10.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
//                    Padding(padding: EdgeInsets.all(size.width/10),
//                      child: Image ,
//                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.width / 15, bottom: size.width / 20),
                      child: new Image(
                          height: size.height / 10,
                          fit: BoxFit.fitHeight,
                          image: new AssetImage('assets/logouum.png')),
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.width / 60,
                          left: size.width / 40,
                          right: size.width / 40),
                      child: TextField(
                        controller: phone,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Phone No",
                          hintStyle: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.width / 40,
                          left: size.width / 40,
                          right: size.width / 40),
                      child: TextField(
                        controller: email,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: emails,
                          hintStyle: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.width / 40,
                          bottom: size.width / 40,
                          left: size.width / 40,
                          right: size.width / 40),
                      child: TextField(
                        controller: pass,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "New Password",
                          hintStyle: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width / 10,
                          vertical: size.width / 50),
                      child: SizedBox(
                        height: size.width / 8,
                        child: RaisedButton(
                          elevation: 5.0,
                          color: Colors.blue,
                          onPressed: () async {
                            update();
                          },
                          child: Text(
                            'UPDATE PROFILE',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 10),
                      child: RaisedButton(
                        elevation: 5.0,
                        color: Colors.redAccent,
                        onPressed: () async {
                          logOut();
                        },
                        child: Text(
                          'LOG OUT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    Navigator.pushReplacementNamed(context, '/login');
    Toast.show("Log Out Successful", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  Future<bool> update() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('phone', phone.text);
    prefs.setString('email', email.text);
    Navigator.pushReplacementNamed(context, '/home');
    Toast.show("Profile Updated Successfully", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  void updateName(String name) {
    setState(() {
      this.name = name;
    });
  }

  void updatePhone(String phones) {
    setState(() {
      this.phones = phones;
    });
  }

  void updateEmail(String emails) {
    setState(() {
      this.emails = emails;
    });
  }

  void updateID(String id) {
    setState(() {
      this.id = id;
    });
  }
}
