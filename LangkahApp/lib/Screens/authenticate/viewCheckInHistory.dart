import 'package:LangkahApp/services/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:LangkahApp/Screens/authenticate/UserMainPage.dart';
import 'package:LangkahApp/Classes/User.dart';

class UserLocationList extends StatefulWidget {
  @override
  _UserLocationListState createState() => _UserLocationListState();
}

class _UserLocationListState extends State<UserLocationList> {
  @override
  Widget build(BuildContext context) {
    final User currentuser = ModalRoute.of(context).settings.arguments;

    getMethod(String ic) async {
      String theUrl =
          "https://langkah2020.000webhostapp.com/viewCheckInHistory.php";

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
        title: Text("Check-in History List"),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/bck3.png"),
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

            return ListView.builder(
              itemCount: snap.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        border: Border.all(width: 3, color: Colors.blue[100]),
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      leading:
                          Icon(Icons.location_pin, color: Colors.red[600], size: 50),
                      title: Text("Location: ${snap[index]['location']}",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      //contains as subtitle
                      subtitle: Text("Check-in Date: ${snap[index]['date']}\n",
                          style: TextStyle(fontSize: 16, color: Colors.black54)),
                      isThreeLine: true,
                    ),
                  ),
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
