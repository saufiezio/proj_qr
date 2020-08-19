import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';


class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    var url = "http://gmartbox.cvmall.my/dash-apps/complete.php";
    http.post(url, body: {'id': widget.list[widget.index]['orderID']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content:
          new Text("Complete '${widget.list[widget.index]['nameID']}' Order?"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "YES",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.blueAccent,
          onPressed: () {
            deleteData();
            Navigator.push(
                context,new MaterialPageRoute(
              builder: (context) => Detail(),
            ));
          },
        ),
        new RaisedButton(
          child: new Text("CANCEL", style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.orangeAccent, //change your color here
        ),
        elevation: 0.3,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Order Details",
          style: TextStyle(color: Colors.grey[700]),),
      ),
      body: 
      SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Container(

              child: new Container(
                color: Colors.white,
                child: new Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text('Customer Info',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey[500]
                        ),),
                    )),
                    new Container(
                      padding: EdgeInsets.only(left: 30.0,top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text("NAME", style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 10.0,
                            color: Colors.grey[700],
                          ),),
                          Wrap(
                            children: <Widget>[
                              Text("${widget.list[widget.index]['nameID']}",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15.0,
                                    color: Colors.blue[800]
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(
                      padding: EdgeInsets.only(left: 30.0,top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("PHONE NO", style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 10.0,
                            color: Colors.grey[700],
                          ),),
                          Text("${widget.list[widget.index]['phoneID']}",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(
                      padding: EdgeInsets.only(left: 30.0,top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("ORDER DATE", style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 10.0,
                            color: Colors.grey[700],
                          ),),
                          Text("${widget.list[widget.index]['orderDate']}",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(

                      padding: EdgeInsets.only(left: 30.0,top: 15.0),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("ORDER DAY", style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 10.0,
                            color: Colors.grey[700],
                          ),),
                          Text("${widget.list[widget.index]['orderDate']}",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(

                      padding: EdgeInsets.only(left: 30.0,top: 5.0),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("PICKUP LOCATION", style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 10.0,
                            color: Colors.grey[700],
                          ),),
                          Text("${widget.list[widget.index]['puLocation']}",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(

                      padding: EdgeInsets.only(left: 30.0,top: 15.0),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("EMAIL ADDRESS", style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 10.0,
                            color: Colors.grey[700],
                          ),),
                          Text("${widget.list[widget.index]['emailID']}",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(padding: EdgeInsets.only(top:15.0)),
            Container(
              color: Colors.white,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Center(
                    child:
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text("Product Info",
                        style: TextStyle(fontSize: 15.0,
                            color: Colors.grey[500]
                        ) ,),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 30.0,top: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("PRODUCT", style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 10.0,
                              color: Colors.grey[700],
                            ),),
                            Wrap(
                              children: <Widget>[
                                Text("${widget.list[widget.index]['orderType']}",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15.0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Container(
                        padding: EdgeInsets.only(left: 30.0,top: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("QUANTITY", style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 10.0,
                              color: Colors.grey[700],
                            ),),
                            Wrap(
                              children: <Widget>[
                                Text("${widget.list[widget.index]['orderQTT']}",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15.0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Container(
                    padding: EdgeInsets.only(left: 30.0,top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("ORDER STATUS", style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 10.0,
                          color: Colors.grey[700],
                        ),),
                        Wrap(
                          children: <Widget>[
                            Text("${widget.list[widget.index]['orderStatus']}",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 15.0,
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25.0)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: new InkWell(

                      onTap: confirm,
                      child: new Container(
                        //width: 100.0,
                        height: 40.0,
                        decoration: new BoxDecoration(
                          color: Colors.greenAccent,
                          border: new Border.all(color: Colors.white, width: 2.0),
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: new Center(child: new Text('COMPLETE ORDER', style: new TextStyle(fontSize: 18.0, color: Colors.white),),),
                      ),
                    ),),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}


