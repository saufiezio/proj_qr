import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Bottom.dart';
import 'place_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'scanner.dart';

String _name = '';

class Home extends StatefulWidget {
  String result;
  Home({this.result});

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  String ids = '45';
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = (prefs.getString('id') ?? '');
    });
  }

  Future<List> getData() async {
    var url = "https://qniti.com/myqniti/apps/load_place.php";
    final response = await http.post(url, body: {
      "id": _name,
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var datauser = json.decode(response.body);
      print(datauser.length);
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        throw Exception('ERROR ON SERVER SIDE');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          "History",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return NoData();

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    String photo = 'photo';
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(10.0),
          child: new InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Detail(
                      list: list,
                      index: i,
                    ))),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['placename']),
                leading: Icon(
                  Icons.business,
                  color: Colors.blue,
                ),
                subtitle: new Text("Date : ${list[i]['enterDate']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 12),
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
                        top: size.width / 15,
                      ),
                      child: new Icon(
                        Icons.error,
                        color: Colors.blue,
                        size: size.width / 8,
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width / 12, bottom: size.width / 20),
                    child: Text(
                      "No Data",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.width / 12),
                    child: Text(
                      "Your visit history will appear here",
                      textAlign: TextAlign.center,
                    ),
                  ),
//                  Text(
//                    'HAHA',
//                    textAlign: TextAlign.center,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
