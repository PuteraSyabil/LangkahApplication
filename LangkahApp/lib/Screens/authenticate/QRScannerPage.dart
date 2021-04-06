import 'dart:convert';

import 'package:LangkahApp/Classes/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:LangkahApp/Screens/authenticate/UserMainPage.dart';

class QrScannerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _QrScannerPage();
}

class _QrScannerPage extends State<QrScannerPage> {
  String _ic = "";
  String _location = "";
  DateTime _now;
  String _date = "";
  String location = "";
  String errorLocation = "-1";

  void checkIn() async {
    var url = "https://langkah2020.000webhostapp.com/CheckIn.php";
    var data = {
      "ic": _ic,
      "location": _location,
      "date": _date,
    };
    var res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "true") {
      Fluttertoast.showToast(
          msg: "Checked In!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } else if (jsonDecode(res.body) == "false") {
      Fluttertoast.showToast(
          msg: "Error!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User currentuser = ModalRoute.of(context).settings.arguments;
    _ic = currentuser.ic;
    _scan() async {
      await FlutterBarcodeScanner.scanBarcode(
              '#000000', 'Cancel', true, ScanMode.BARCODE)
          .then((value) => setState(() => location = value));
      _now = new DateTime.now();
      _date = _now.toString();
      if (location == errorLocation) {
        Fluttertoast.showToast(
            msg: "Error!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
      } else {
        _location = location;
        checkIn();
      }
    }

    return new Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserMainPage(),
                      settings: RouteSettings(arguments: currentuser)));
            },
          ),
          title: new Text("Langkah"),
          centerTitle: true,
        ),
        body: Center(
            child: new Icon(
          Icons.qr_code_scanner_sharp,
          color: Colors.blue,
          size: 200,
        )),
        bottomNavigationBar: SizedBox(
            height: 80,
            child: new RaisedButton(
              onPressed: () => _scan(),
              color: Colors.blue,
              child: Text('Check-in Place',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            )));
  }
}
