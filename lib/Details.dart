import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Bottom.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget { String result;
  List list;
  int index = 1;
  Detail({this.index,this.list,this.result});



  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
String _name='';

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('id');
    return name;
  }




  Future<List> getData() async{
    var url ="https://qniti.com/myqniti/apps/test.php";
    final response = await http.post(url, body: {
      'id': widget.result
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return json.decode(response.body);
    }else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('QR NOT RECOGNIZE');
    }


  }

  void initState() {
    getName().then((updateName));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new ItemList(
              list: snapshot.data,
              result: widget.result,
              id:_name
            );
          }else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}")
            );
          }else return Center(
            child: CircularProgressIndicator(),
          );



  },
      ),
    );
  }
  void updateName(name){
    setState(() {
      this._name=name;
    });
  }
}

class ItemList extends StatelessWidget {
  final List list;
  final String result;
  final String id;


  ItemList({this.list,this.result,this.id});



  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);

    Future<List> addData() async {
      final response = await http.post("https://qniti.com/myqniti/apps/enterlog.php", body: {
        "placeID": result,
        "userID": id,
        "enterDate": formattedDate,
        "enterTime": formattedTime
      });
    }
    Size size = MediaQuery.of(context).size;


    return Center(
      child: new Container(
          child:ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list == null ? 0 : list.length,
          itemBuilder: (context, i) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width/40),
                  child: Card(
                    elevation: 10.0,
                    child:
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width/14),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.width/30, bottom:size.width/30 ),
                            child: new Image(
                                height: size.height/10,
                                fit: BoxFit.fitHeight,
                                image: new AssetImage('assets/qr_icon.png')),
                          ),
                          Divider(),

                          Text("Check In Details",textAlign: TextAlign.center,style: TextStyle(fontSize: 15.0),),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(


                              child: Column(
                                children: <Widget>[
                                  Text("Location",textAlign: TextAlign.start,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                  Text(list[i]["placename"],textAlign: TextAlign.center,style: TextStyle(fontSize: 15.0),),

                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(


                              child: Column(
                                children: <Widget>[
                                  Text("Date",textAlign: TextAlign.start,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                  Text(formattedDate,textAlign: TextAlign.center,style: TextStyle(fontSize: 15.0),),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(


                              child: Column(
                                children: <Widget>[
                                  Text("Time",textAlign: TextAlign.start,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                                  Text(formattedTime,textAlign: TextAlign.center,style: TextStyle(fontSize: 15.0),),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width/10 ),
                            child:
                            RaisedButton(
                              elevation: 5.0,
                              color: Colors.blue,
                              onPressed: () {
                                addData();
                                Toast.show("Check In Success", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyHomePage(initial: 0,)),
                                );
                              },
                              child: Text('ENTER',style: TextStyle(color: Colors.white),),
                            ),

                          ),
                        ],
                      ),
                    ),

                  ),
                ),
              ],
            );
          },
        ) ,
      ),
    ) ;
  }
}

//Center(
//child: new Card(
//
//child:
//new Column(
//children: <Widget>[
//Icon(Icons.account_balance),
//Text(list[i]["placename"]),Text(list[i]["placename"]),Text(list[i]["placename"]),
//],
//)
//
////              ListTile(
////                title: new
////                leading: new Icon(Icons.pause),
////                subtitle: new Text("Stock : ${list[i]["placeaddr"]}"),
////              ),
//),
//);