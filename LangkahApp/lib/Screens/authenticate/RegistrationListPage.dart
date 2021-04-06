import 'package:LangkahApp/Screens/authenticate/RegistrationDetailList.dart';
import 'package:LangkahApp/Screens/authenticate/AdminMainPage.dart';
import 'package:LangkahApp/services/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:LangkahApp/Classes/Registration.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  getMethod() async {
    String theUrl =
        "https://langkah2020.000webhostapp.com/getregistrationlist.php";
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
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.search,
        //       size: 40,
        //     ),
        //   )
        // ],
        title: Text("User Registration List"),
        // actions: [searchBar.getSearchAction(context)]
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
                  elevation: 6,
                  child: ListTile(
                    tileColor: Colors.blue[100],
                    //display ic as title
                    title: Text("Registration No: ${snap[index]['id']}",
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    //contains as subtitle
                    subtitle: Text(
                        "IC: ${snap[index]['ic']}\nName: ${snap[index]['name']}\nStatus: ${snap[index]['status']}\nRegister Date: ${snap[index]['regDate']}\n",
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                    trailing: FlatButton(
                      color: Colors.blue,
                      child: Text("View",
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => new RegistrationDetailList(),
                            settings: RouteSettings(
                              arguments: Registration(
                                  snap[index]['id'],
                                  snap[index]['ic'],
                                  snap[index]['password'],
                                  snap[index]['name'],
                                  snap[index]['email'],
                                  snap[index]['phone'],
                                  snap[index]['address'],
                                  snap[index]['cheDate'],
                                  snap[index]['regDate'],
                                  snap[index]['status']),
                            ),
                          ),
                        );
                      },
                    ),
                    //),
                  ));
            },
          );
        },
      ),
    );
  }
}
