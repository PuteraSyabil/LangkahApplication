import 'package:flutter/material.dart';
import 'package:LangkahApp/Classes/Request.dart';
import 'package:LangkahApp/Screens/authenticate/ViewRequestStatus.dart';
import 'package:LangkahApp/Classes/User.dart';

class ViewRequestDetail extends StatefulWidget {
  @override
  _ViewRequestDetailState createState() => _ViewRequestDetailState();
}

class _ViewRequestDetailState extends State<ViewRequestDetail> {
  @override
  Widget build(BuildContext context) {
    final Request currentrequest = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text('Request No#${currentrequest.id} Details'),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewRequestStatus(),
                    settings: RouteSettings(arguments: User(currentrequest.ic)),
                  ),
                );
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
                          color: Colors.black)),
                ),
                new Divider(
                  // height: 40.0,
                  color: Colors.blue,
                  thickness: 5,
                ),
                new ListTile(
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
                  // tileColor: Colors.green[50],
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
                )
              ],
            ),
          ),
        ));
  }
}
