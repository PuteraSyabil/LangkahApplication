import 'package:flutter/material.dart';
import 'package:LangkahApp/Screens/authenticate/AdminInfectedAreaList.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:LangkahApp/Classes/Cases.dart';
import 'package:LangkahApp/Classes/States.dart';

class UpdateInfectedArea extends StatefulWidget {
  @override
  _UpdateInfectedAreaState createState() => _UpdateInfectedAreaState();
}

class _UpdateInfectedAreaState extends State<UpdateInfectedArea> {
  final formKey = new GlobalKey<FormState>();
  String _updTotal="";
  String _updActive="";

  @override
  Widget build(BuildContext context) {
    final Cases current = ModalRoute.of(context).settings.arguments;

    void saveUpdate() async {
      var url = "https://langkah2020.000webhostapp.com/updateInfectedArea.php";
      var data = {
        "state": current.states,
        "district": current.district,
        "updTotal": _updTotal,
        "updActive": _updActive,
      };
      var res = await http.post(url, body: data);
      if (jsonDecode(res.body) == "Successfully") {
        Fluttertoast.showToast(
            msg: "Update successfull.",
            toastLength: Toast.LENGTH_SHORT);
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new AdminInfectedAreaListPage(),
                          settings: RouteSettings(arguments: States(current.states))));
      } else {
        Fluttertoast.showToast(
            msg:
                "Error occur, the update is failed\nPlease try again later....",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3);
      }
    }

    void validateAndSave() {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        saveUpdate();
        print('Update Success');
      } else {
        print('Update Failed');
      }
    }

      return Stack(
        children: <Widget>[
          // Image.asset(
          //   "assets/images/bck4.jpg",
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
          Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(
                  'Update Infected Area'), 
              automaticallyImplyLeading: true,
                
              ),    
          body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child:new Column(
            children: <Widget>[
              new ListTile(
                title: new Text('District            : ${current.district}', 
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              new ListTile(
                title: new Text(
                    'Total Cases    : ${current.total}', 
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              new ListTile(
                title: new Text(
                    'Active Cases  : ${current.active}', 
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 40),
              new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Text(
                    'Please enter the latest total cases and active cases',
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  new TextFormField(
                        decoration: new InputDecoration(labelText: "Total Cases"),
                        validator: (value) =>
                            value.isEmpty ? 'Total cases can\'t be empty' : null,
                        onSaved: (value) => _updTotal = value,
                      ),
                  SizedBox(height: 10),
                  new TextFormField(
                        decoration: new InputDecoration(labelText: "Active Cases"),
                        validator: (value) =>
                            value.isEmpty ? 'Active cases can\'t be empty' : null,
                        onSaved: (value) => _updActive = value,
                      ),
                  SizedBox(height: 50),
                  new RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 9, horizontal: 45),
                      color: Colors.red,
                      child: new Text(
                        'Save',
                        style: new TextStyle(fontSize: 23, color: Colors.white),
                      ),
                      onPressed: () {
                        validateAndSave();
                      })
                ],))
            ],
          )))
    ]);
  }
}
