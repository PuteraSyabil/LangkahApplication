import 'package:LangkahApp/services/loader.dart';
import 'package:flutter/material.dart';
import 'package:LangkahApp/Screens/authenticate/ManageRequest.dart';
import 'package:LangkahApp/Screens/authenticate/AdminMainPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:LangkahApp/Classes/Request.dart';

class ReviewRequestPage extends StatefulWidget {
  @override
  _ReviewRequestPageState createState() => _ReviewRequestPageState();
}

class _ReviewRequestPageState extends State<ReviewRequestPage> {
  getMethod() async {
    String theUrl = "https://langkah2020.000webhostapp.com/getRequestList.php";
    var res = await http
        .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});

    var responsbody = json.decode(res.body);

    print(responsbody);

    return responsbody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminMainPage()));
              }),
          title: Text("Review Request"),
        ),
        body: FutureBuilder(
          future: getMethod(),
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
            return ListView.builder(
              itemCount: snap.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 5,
                    child: ListTile(
                        tileColor: Colors.blue[100],
                        title: Text("Request No: ${snap[index]['id']}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black)), //add title, request no
                        subtitle: Text(
                            "Requester IC: ${snap[index]['ic']}\nStatus ${snap[index]['status']}\nDate: ${snap[index]['regDate']}",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                        trailing: FlatButton(
                          color: Colors.blue,
                          child: Text("Review Now",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManageRequest(),
                                settings: RouteSettings(
                                    arguments: Request(
                                  snap[index]['id'],
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
                        )));
              },
            );
          },
        ));
  }
}
