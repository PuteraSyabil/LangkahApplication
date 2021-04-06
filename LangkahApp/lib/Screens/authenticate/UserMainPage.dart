import 'package:LangkahApp/Screens/authenticate/news.dart';
import 'package:LangkahApp/Screens/authenticate/RequestPermitPage.dart';
import 'package:LangkahApp/Screens/authenticate/ViewRequestStatus.dart';
import 'package:flutter/material.dart';
import 'package:LangkahApp/Screens/authenticate/UserLoginPage.dart';
import 'package:LangkahApp/Screens/authenticate/ViewInfectedArea.dart';
import 'package:LangkahApp/Classes/User.dart';
import 'package:LangkahApp/Screens/authenticate/viewCheckInHistory.dart';
import 'package:LangkahApp/Screens/authenticate/QRScannerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

String ic = "";
Future getIC() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  ic = prefs.getString('ic');
}

Future removeIC() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('ic');
}

class UserMainPage extends StatefulWidget {
  @override
  _UserMainPage createState() => _UserMainPage();
}

class _UserMainPage extends State<UserMainPage> {
  @override
  Widget build(BuildContext context) {
    getIC();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(centerTitle: true, title: Text("Langkah")),
        drawer: Drawer(
          child: ListView(
            children: [logout()],
          ),
        ),
        body: 
            SingleChildScrollView(child: 
            Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 20, left: 0, right: 0,),
            alignment: Alignment.topCenter,
            child:
            Wrap(direction: Axis.vertical, spacing: 10, children: <Widget>[
              Column(children: <Widget>[
              Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.blue[50],
              elevation: 10,
              child:
              Column( children: <Widget>[
                SizedBox(
                  width: 400,
                  height: 116, // specific value
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 3, color: Colors.blue)),
                        child: Icon(Icons.article_rounded, size: 25,),
                        ),
                        Text('Request Permit', style: TextStyle(fontSize: 14))
                      ]),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestPermitPage(),
                                settings: RouteSettings(arguments: User(ic))));
                      },
                      color: Colors.blue[50],
                      textColor: Colors.blue),
                      FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 3, color: Colors.blue)),
                        child: Icon(Icons.fact_check_rounded, size: 25,),
                        ),
                        Text('Request Status',
                            style: TextStyle(fontSize: 14))
                      ]),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewRequestStatus(),
                                settings: RouteSettings(arguments: User(ic))));
                      },
                      color: Colors.blue[50],
                      textColor: Colors.blue),
                      FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 3, color: Colors.blue)),
                        child: Icon(Icons.article_rounded, size: 25,),
                        ),
                        Text('Covid-19 News',
                            style: TextStyle(fontSize: 14))
                      ]),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsPage()));
                      },
                      color: Colors.blue[50],
                      textColor: Colors.blue)
                  ],)),
              SizedBox(
                  width: 400,
                  height: 120, // specific value
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    FlatButton(
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 3, color: Colors.blue)),
                        child:  Icon(Icons.qr_code_rounded, size: 25,),
                        ),
                        Text('Check-in Place', style: TextStyle(fontSize: 14))
                      ]),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QrScannerPage(),
                                settings: RouteSettings(arguments: User(ic))));
                      },
                      color: Colors.blue[50],
                      textColor: Colors.blue),
                      FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 3, color: Colors.blue)),
                        child: Icon(Icons.history_rounded, size: 25,),
                        ),
                        Text('Check-in History',
                            style: TextStyle(fontSize: 14))
                      ]),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserLocationList(),
                                settings: RouteSettings(arguments: User(ic))));
                      },
                      color: Colors.blue[50],
                      textColor: Colors.blue),
                      FlatButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 3, color: Colors.blue)),
                        child: Icon(Icons.map_rounded, size: 25,),
                        ),
                        Text('Infected Area',
                            style: TextStyle(fontSize: 14))
                      ]),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewInfectedAreaPage()));
                      },
                      color: Colors.blue[50],
                      textColor: Colors.blue)
                  ],)),
              ],
              ),
    ),
                    Container(
                    margin: EdgeInsets.only(top: 50, left: 0, right: 0,),
                    child:SizedBox(
                      width: 320, height: 220,
                      child: 
                      logo()
                    )
    ,)

    ],
    ),
    ]
    )
    )
            ,)

    );
  }

  Widget logo() {
    return Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/step.jpg', width: 100, height: 150),
          Text('LANGKAH',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22))
        ]);
  }

  Widget logout() {
    return Row(
      children: <Widget>[
      Icon(Icons.logout),
      GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserLoginPage()));
          },
          child: Text(' Logout',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20))),
    ]);
  }
}
