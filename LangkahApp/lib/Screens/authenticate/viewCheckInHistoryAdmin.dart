import 'package:LangkahApp/Screens/authenticate/AdminMainPage.dart';
import 'package:LangkahApp/services/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  getMethod() async {
    String theUrl =
        "https://langkah2020.000webhostapp.com/getCheckInHistory.php";
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
        title: Text("Check-in History List"),
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
                    title: Text("Check-in No: ${snap[index]['id']}",
                        style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                    //contains as subtitle
                    subtitle: Text(
                        "IC: ${snap[index]['ic']}\nLocation: ${snap[index]['location']}\nCheck-in Date: ${snap[index]['date']}\n",
                        style: TextStyle(fontSize: 17, color: Colors.black54)),
                  ));
            },
          );
        },
      ),
    );
  }
}
