import 'package:flutter/material.dart';
import 'package:LangkahApp/Screens/authenticate/AdminInfectedAreaList.dart';
import 'package:LangkahApp/Classes/States.dart';
import 'package:LangkahApp/Screens/authenticate/AdminMainPage.dart';

class AdminViewInfectedAreaPage extends StatefulWidget {
  @override
  _AdminViewInfectedAreaPage createState() => _AdminViewInfectedAreaPage();
}

class _AdminViewInfectedAreaPage extends State<AdminViewInfectedAreaPage> {
  var _state = [
    'Johor',
    'Melaka',
    'Kelantan',
    'Kedah',
    'Perlis',
    'Perak',
    'Pahang',
    'Pulau Pinang',
    'Negeri Sembilan',
    'Terengganu',
    'Selangor',
    'Sarawak',
    'Sabah',
    'Kuala Lumpur',
    'Labuan',
    'Putrajaya'
  ];
  var _stateSelected = 'Johor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text("Infected Area"),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminMainPage()));
                })),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 70),
                Text("Please select a state",
                    style: TextStyle(fontSize: 19, color: Colors.black)),
                SizedBox(height: 10),
                state(),
                SizedBox(height: 30),
                SizedBox(height: 40),
                new RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 9, horizontal: 45),
                    color: Colors.blue,
                    child: new Text(
                      'View',
                      style: new TextStyle(fontSize: 23, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  new AdminInfectedAreaListPage(),
                              settings: RouteSettings(
                                  arguments: States(_stateSelected))));
                    }),

              ],
            ),
          ),
        ));
  }

  Widget state() {
    return Column(children: <Widget>[
      DropdownButton<String>(
        value: _stateSelected,
        items: _state.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this._stateSelected = newValueSelected;
          });
        },
      )
    ]);
  }

  Widget logo() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/step.jpg', width: 100, height: 150),
          Text('LANGKAH',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22))
        ]);
  }
}
