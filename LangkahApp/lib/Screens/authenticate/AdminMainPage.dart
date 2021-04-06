import 'package:LangkahApp/Screens/authenticate/AdminLoginPage.dart';
import 'package:LangkahApp/Screens/authenticate/RegistrationListPage.dart';
import 'package:LangkahApp/Screens/authenticate/ReviewRequestPage.dart';
import 'package:flutter/material.dart';
import 'package:LangkahApp/Screens/authenticate/viewCheckInHistoryAdmin.dart';
import 'package:LangkahApp/Screens/authenticate/AdminViewInfectedArea.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key key}) : super(key: key);

  @override
  _AdminMainPage createState() => _AdminMainPage();
}

class _AdminMainPage extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Langkah')),
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
                margin: EdgeInsets.only(top: 20, left: 0, right: 0),
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
                      child: Column(children: <Widget>[
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
                             child: Icon(Icons.article_outlined, size: 25, color: Colors.blue,),
                             ),
                            Text('Review Request',
                                style: TextStyle(fontSize: 15, color: Colors.blue))
                          ]),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewRequestPage()));
                          },
                          color: Colors.blue[50],
                          textColor: Colors.green),
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
                             child: Icon(Icons.rule_rounded, size: 25, color: Colors.blue,),
                             ),
                            Text('Register New User',
                                style: TextStyle(fontSize: 15, color: Colors.blue))
                          ]),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserList()));
                          },
                          color: Colors.blue[50],
                          textColor: Colors.orange),
                          ],
                          )
                          ),
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
                             child: Icon(Icons.history_rounded, size: 25, color: Colors.blue,),
                             ),  
                            Text('Check-in History',
                                style: TextStyle(fontSize: 15, color: Colors.blue))
                          ]),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationList()));
                          },
                          color: Colors.blue[50],
                          textColor: Colors.purple),
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
                             child: Icon(Icons.create, size: 25, color: Colors.blue),
                             ), 
                            Text(' Update Infected Area',
                                style: TextStyle(fontSize: 15, color: Colors.blue))
                          ]),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AdminViewInfectedAreaPage()));
                          },
                          color: Colors.blue[50],
                          textColor: Colors.red)
                      ],)),
                    ]),
                    ),
                     Container(
                    margin: EdgeInsets.only(top: 70, left: 0, right: 0,),
                    child:SizedBox(
                      width: 320, height: 220,
                      child: 
                      logo()
                    )
                    )
                  ],),
  
                ]))
                ),);
  }

  Widget logo() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/step.jpg', width: 80, height: 130),
          Text('LANGKAH',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20))
        ]);
  }

  Widget logout() {
    return Row(children: <Widget>[
      Icon(Icons.logout),
      GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminLoginPage()));
          },
          child: Text(' Logout',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20))),
    ]);
  }
}
