import 'package:LangkahApp/services/loader.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:LangkahApp/Classes/States.dart';
import 'package:LangkahApp/Classes/Cases.dart';
import 'package:LangkahApp/Screens/authenticate/UpdateInfectedArea.dart';
import 'package:LangkahApp/Screens/authenticate/AdminViewInfectedArea.dart';


class AdminInfectedAreaListPage extends StatefulWidget {
  @override
  _AdminInfectedAreaListPageState createState() => _AdminInfectedAreaListPageState();
}

class _AdminInfectedAreaListPageState extends State<AdminInfectedAreaListPage> {

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
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(currentstates.states),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminViewInfectedAreaPage()));
            })
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
                  child: ListTile(
                    tileColor: Colors.blue[100],
                    title: Text(
                        "${snap[index]['district']}",style: TextStyle(fontSize: 20, color: Colors.black)), 
                    subtitle: Text(
                        "Total cases:    ${snap[index]['total']}\nActive cases:  ${snap[index]['active']}",style: TextStyle(fontSize: 18, color: Colors.black54)),
                    trailing: RaisedButton(
                      color: Colors.blue,
                      child: Text("UPDATE", style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateInfectedArea(),
                            settings: RouteSettings(
                                arguments: Cases(
                                  currentstates.states,
                                  snap[index]['district'],
                                  snap[index]['total'],
                                  snap[index]['active']
                            )),
                          ),
                        );
                      },
                    )
                    ));
              },
            );
          },
        ));
  }
}
