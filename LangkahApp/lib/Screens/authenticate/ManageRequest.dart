import 'package:flutter/material.dart';
import 'package:LangkahApp/Screens/authenticate/ReviewRequestPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:LangkahApp/Classes/Request.dart';

class ManageRequest extends StatefulWidget {
  @override
  _ManageRequestState createState() => _ManageRequestState();
}

class _ManageRequestState extends State<ManageRequest> {
  @override
  Widget build(BuildContext context) {
    final Request currentrequest = ModalRoute.of(context).settings.arguments;

    DateTime _now;
    _now = new DateTime.now();
    String cheDate = "";
    cheDate = _now.toString();

    void approve() async {
      _now = new DateTime.now();
      cheDate = _now.toString();
      var url = "https://langkah2020.000webhostapp.com/ApproveRequest.php";
      var data = {
        "id": currentrequest.id,
        "ic": currentrequest.ic,
        "cheDate": cheDate,
      };
      var res = await http.post(url, body: data);
      if (jsonDecode(res.body) == "Successfully") {
        Fluttertoast.showToast(
            msg: "The request is approved successfully.",
            toastLength: Toast.LENGTH_SHORT);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ReviewRequestPage()));
      } else {
        Fluttertoast.showToast(
            msg:
                "Error occur, the request is failed to approve\nPlease try again later....",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3);
      }
    }

    void deny() async {
      _now = new DateTime.now();
      cheDate = _now.toString();
      var url = "https://langkah2020.000webhostapp.com/DeclineRequest.php";
      var data = {
        "id": currentrequest.id,
        "ic": currentrequest.ic,
        "cheDate": cheDate,
      };
      var res = await http.post(url, body: data);
      if (jsonDecode(res.body) == "Successfully") {
        Fluttertoast.showToast(
            msg: "The request is declined successfully.",
            toastLength: Toast.LENGTH_SHORT);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ReviewRequestPage()));
      } else {
        Fluttertoast.showToast(
            msg: "Error occurs, please try again later.....",
            toastLength: Toast.LENGTH_SHORT);
      }
    }

    if (currentrequest.status == "Unprocessed") {
      return Scaffold(
          appBar: AppBar(
              title: Text('Request No#${currentrequest.id} Details'),
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewRequestPage()));
                },
              )),
          resizeToAvoidBottomInset: false,
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/bck1.jpg"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                new ListTile(
                  title: new Text('${currentrequest.status}',
                      textAlign: TextAlign.center, //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.blue)),
                ),
                new Divider(
                  // height: 40.0,
                  color: Colors.blue,
                  thickness: 5,
                ),
                new ListTile(
                  //tileColor: Colors.blue[50],
                  leading: Icon(Icons.account_box,
                      size: 55, color: Colors.blue),
                  title: new Text('IC', //add IC variable
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.ic}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  //tileColor: Colors.blue[50],
                  leading: Icon(Icons.add_location_sharp,
                      size: 55, color: Colors.blue),
                  title: new Text('Departure Address', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.departureAddress}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading:
                      Icon(Icons.apartment, size: 55, color: Colors.blue),
                  title: new Text('Destination Address', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.destinationAddress}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
              new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading: Icon(Icons.book_rounded,
                      size: 55, color: Colors.blue),
                  title: new Text('Purpose', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.purpose}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading: Icon(Icons.departure_board,
                      size: 55, color: Colors.blue),
                  title: new Text('Departure Date', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.departureDate}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading: Icon(Icons.unarchive_rounded,
                      size: 55, color: Colors.blue),
                  title: new Text('Request Date', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.regDate}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading: Icon(Icons.visibility,
                      size: 55, color: Colors.blue),
                  title: new Text('Checked Date', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.cheDate}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Divider(
                  color: Colors.blue,
                  thickness: 6,
                ),
                new ListTile(
                  leading: new RaisedButton(
                    color: Colors.lightGreenAccent[400],
                    child: new Text(
                      'Approve',
                      style: new TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    onPressed: () => approve(),
                  ),
                  trailing: new RaisedButton(
                    color: Colors.red,
                    child: new Text(
                      'Decline',
                      style: new TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    onPressed: () => deny(),
                  ),
                ),
              ],))
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
              title: Text('Request No#${currentrequest.id} Details'),
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewRequestPage()));
                },
              )),
          resizeToAvoidBottomInset: false,
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/bck1.jpg"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
              new ListTile(
                  title: new Text('${currentrequest.status}',
                      textAlign: TextAlign.center, //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.blue)),
                ),
                new Divider(
                  // height: 40.0,
                  color: Colors.blue,
                  thickness: 5,
                ),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading: Icon(Icons.account_box,
                      size: 55, color: Colors.blue),
                  title: new Text('IC', //add IC variable
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.ic}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading: Icon(Icons.add_location_sharp,
                      size: 55, color: Colors.blue),
                  title: new Text('Departure Address', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.departureAddress}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading:
                      Icon(Icons.apartment, size: 55, color: Colors.blue),
                  title: new Text('Destination Address', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.destinationAddress}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
              new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading: Icon(Icons.book_rounded,
                      size: 55, color: Colors.blue),
                  title: new Text('Purpose', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.purpose}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading: Icon(Icons.departure_board,
                      size: 55, color: Colors.blue),
                  title: new Text('Departure Date', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.departureDate}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading: Icon(Icons.unarchive_rounded,
                      size: 55, color: Colors.blue),
                  title: new Text('Request Date', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.regDate}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                new ListTile(
                  // tileColor: Colors.blue[50],
                  leading: Icon(Icons.visibility,
                      size: 55, color: Colors.blue),
                  title: new Text('Checked Date', //add address
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  subtitle: Text('${currentrequest.cheDate}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                ),
                new Divider(
                  color: Colors.blue,
                  thickness: 6,
                ),
            ],))
          ));
    }
  }
}
