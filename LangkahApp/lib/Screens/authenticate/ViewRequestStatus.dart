import 'package:LangkahApp/Screens/authenticate/ViewRequestDetail.dart';
import 'package:LangkahApp/services/loader.dart';
import 'package:flutter/material.dart';
import 'package:LangkahApp/Classes/User.dart';
import 'package:LangkahApp/Screens/authenticate/UserMainPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:LangkahApp/Classes/Request.dart';

class ViewRequestStatus extends StatefulWidget {
  @override
  _ViewRequestStatusState createState() => _ViewRequestStatusState();
}

class _ViewRequestStatusState extends State<ViewRequestStatus> {
  @override
  @override
  Widget build(BuildContext context) {
    int cc1 = 0;

    final User currentuser = ModalRoute.of(context).settings.arguments;

    getMethod(String ic) async {
      var theUrl = "https://langkah2020.000webhostapp.com/ViewRequest.php";
      var res = await http.post(theUrl, body: {
        "ic": ic,
      }, headers: {
        "Accept": "application/json"
      });

      var responsbody = json.decode(res.body);

      print(responsbody);

      return responsbody;
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserMainPage(),
                        settings: RouteSettings(arguments: currentuser)));
              }),
          title: Text("My Permit Request"),
        ),
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/bck1.jpg"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: FutureBuilder(
            future: getMethod(currentuser.ic),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List snap = snapshot.data;

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Loader(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("No Data Found"),
                );
              }
              List<int> numlist = new List(snap.length);
              return ListView.builder(
                itemCount: snap.length,
                itemBuilder: (context, index) {
                  cc1++;
                  numlist[index] = cc1;
                  return SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            border:
                                Border.all(width: 3, color: Colors.blue[100]),
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                            isThreeLine: true,
                            dense: true,
                            title: Text("No: $cc1",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Colors.black)), //add title, request no
                            subtitle: Text(
                              "Status: ${snap[index]['status']}\nRequest Date: ${snap[index]['regDate']}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            trailing: RaisedButton(
                              color: Colors.blue,
                              child: Text("View Now",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewRequestDetail(),
                                    settings: RouteSettings(
                                        arguments: Request(
                                      (numlist[index]).toString(),
                                      snap[index]['ic'],
                                      snap[index]['status'],
                                      snap[index]['departureAddress'],
                                      snap[index]['destinationAddress'],
                                      snap[index]['purpose'],
                                      snap[index]['departureDate'],
                                      snap[index]['cheDate'],
                                      snap[index]['regDate'],
                                    )),
                                  ),
                                );
                              },
                            ))),
                  ));
                },
              );
            },
          ),
        ));
  }
}
