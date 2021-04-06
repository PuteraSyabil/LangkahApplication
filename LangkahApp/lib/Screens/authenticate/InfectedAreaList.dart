import 'package:LangkahApp/services/loader.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:LangkahApp/Classes/States.dart';

class InfectedAreaListPage extends StatefulWidget {
  @override
  _InfectedAreaListPageState createState() => _InfectedAreaListPageState();
}

class _InfectedAreaListPageState extends State<InfectedAreaListPage> {
  getMethod(String states) async {
    var theUrl = "https://langkah2020.000webhostapp.com/getInfectedList.php";
    var res = await http.post(theUrl, body: {
      "stateSelected": states,
    }, headers: {
      "Accept": "application/json"
    });

    var responsbody = json.decode(res.body);

    print(responsbody);

    return responsbody;
  }

  @override
  Widget build(BuildContext context) {
    final States currentstates = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(currentstates.states),
        ),
        body: FutureBuilder(
          future: getMethod(currentstates.states),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      tileColor: Colors.blue[100],
                      title: Text("${snap[index]['district']}",
                          style: TextStyle(fontSize: 21, color: Colors.black)),
                      subtitle: Text(
                          "Total cases:    ${snap[index]['total']}\nActive cases:  ${snap[index]['active']}",
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                    ));
              },
            );
          },
        ));
  }
}
