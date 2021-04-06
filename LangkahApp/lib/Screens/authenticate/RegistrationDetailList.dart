import 'package:LangkahApp/Screens/authenticate/RegistrationListPage.dart';
import 'package:flutter/material.dart';
import 'package:LangkahApp/Classes/Registration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class RegistrationDetailList extends StatefulWidget {
  //requiring the list of todos

  @override
  _RegistrationDetailListState createState() => _RegistrationDetailListState();
}

class _RegistrationDetailListState extends State<RegistrationDetailList> {
  @override
  Widget build(BuildContext context) {
    final Registration currentuser = ModalRoute.of(context).settings.arguments;

    DateTime _now;
    _now = new DateTime.now();
    String cheDate = "";
    cheDate = _now.toString();

    void approvemsg() async {
      String username = 'langkahapp@gmail.com';
      String password = 'langkahapp@isthebest';

      final smtpServer = gmail(username, password);
      // Use the SmtpServer class to configure an SMTP server:
      // final smtpServer = SmtpServer('smtp.domain.com');
      // See the named arguments of SmtpServer for further configuration
      // options.

      // Create our message.
      final message = Message()
        ..from = Address(username, 'Langkah Admin')
        ..recipients.add('${currentuser.email}')
        ..subject = ' Langkah Account Registration is approved.'
        ..text = 'Do not reply to this msg'
        ..html =
            "<h1>Your registration for langkah account is approved</h1><p>Your langkah account have been approve by the admin on ${DateTime.now()}\nIC:${currentuser.ic}\nPassword:${currentuser.password}</p>";

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }

    void declinemsg() async {
      String username = 'langkahapp@gmail.com';
      String password = 'langkahapp@isthebest';

      final smtpServer = gmail(username, password);
      // Use the SmtpServer class to configure an SMTP server:
      // final smtpServer = SmtpServer('smtp.domain.com');
      // See the named arguments of SmtpServer for further configuration
      // options.

      // Create our message.
      final message = Message()
        ..from = Address(username, 'Langkah Admin')
        ..recipients.add('${currentuser.email}')
        ..subject = ' Langkah Account Registration is declined.'
        ..text = 'Do not reply to this msg'
        ..html =
            "<h1>unfortunately, your registration for langkah account is declined by admin</h1><p>Your langkah account have been declined by the admin on ${DateTime.now()}\nwhere\nIC:${currentuser.ic}\nFull Name:${currentuser.name}\nKindly to inform to register again.\nThank you.</p>";

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    }

    void approve() async {
      _now = new DateTime.now();
      cheDate = _now.toString();
      var url = "https://langkah2020.000webhostapp.com/approve.php";
      var data = {
        "id": currentuser.id,
        "ic": currentuser.ic,
        "name": currentuser.name,
        "email": currentuser.email,
        "address": currentuser.address,
        "phone": currentuser.phone,
        "password": currentuser.password,
        "cheDate": cheDate,
      };
      var res = await http.post(url, body: data);
      if (jsonDecode(res.body) == "Invalid") {
        Fluttertoast.showToast(
            msg: "Invalid Pair of IC and Full Name, cannot be approved....",
            toastLength: Toast.LENGTH_SHORT);
      } else {
        if (jsonDecode(res.body) == "Error") {
          Fluttertoast.showToast(
              msg: "Error occurs, please validate again.....",
              toastLength: Toast.LENGTH_SHORT);
        } else if (jsonDecode(res.body) == "Account Exist") {
          Fluttertoast.showToast(
              msg: "Account already exist!", toastLength: Toast.LENGTH_SHORT);
        } else if (jsonDecode(res.body) == "Successfully") {
          Fluttertoast.showToast(
              msg: "The registration is approved.",
              toastLength: Toast.LENGTH_SHORT);
          approvemsg();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserList()));
          // approvemsg();
        } else if (jsonDecode(res.body) == "Failed") {
          Fluttertoast.showToast(
              msg: "Approve is failed.", toastLength: Toast.LENGTH_SHORT);
        }
      }
    }

    void decline() async {
      _now = new DateTime.now();
      cheDate = _now.toString();
      var url = "https://langkah2020.000webhostapp.com/decline.php";
      var data = {
        "ic": currentuser.ic,
        "name": currentuser.name,
        "cheDate": cheDate,
        "id": currentuser.id,
      };
      var res = await http.post(url, body: data);
      if (jsonDecode(res.body) == "Successfully") {
        Fluttertoast.showToast(
            msg: "The registration is declined.",
            toastLength: Toast.LENGTH_SHORT);
        declinemsg();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserList()));
      } else {
        Fluttertoast.showToast(
            msg: "Error occurs, please validate again.....",
            toastLength: Toast.LENGTH_SHORT);
      }
    }

    void validateICAndName() async {
      var url =
          "https://langkah2020.000webhostapp.com/validateicandfullname.php";
      var data = {
        "ic": currentuser.ic,
        "name": currentuser.name,
      };
      var res = await http.post(url, body: data);
      if (jsonDecode(res.body) == "Invalid") {
        Fluttertoast.showToast(
            msg: "Invalid Pair of IC and Full Name",
            toastLength: Toast.LENGTH_SHORT);
      } else {
        if (jsonDecode(res.body) == "Error") {
          Fluttertoast.showToast(
              msg: "Error occurs, please validate again.....",
              toastLength: Toast.LENGTH_SHORT);
        } else if (jsonDecode(res.body) == "Account Exist") {
          Fluttertoast.showToast(
              msg: "Account already exist!", toastLength: Toast.LENGTH_SHORT);
        } else if (jsonDecode(res.body) == "Valid") {
          Fluttertoast.showToast(
              msg: "The pair of IC and Full Name is valid.",
              toastLength: Toast.LENGTH_SHORT);
        }
      }
    }

    if (currentuser.status == "Unprocessed") {
      return Scaffold(
          appBar: AppBar(
            title: Text('Registration No#${currentuser.id} Details'),
            automaticallyImplyLeading: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserList()));
                }),
          ),
          body: Container(

              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  new ListTile(
                    title: new Text('${currentuser.status}',
                        textAlign: TextAlign.center,
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
                    title: new Text('IC:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.ic}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                    trailing: new RaisedButton(
                      color: Colors.blueAccent[200],
                      child: new Text(
                        'Validate',
                        style: new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      onPressed: () => validateICAndName(),
                    ),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.contacts,
                        size: 55, color: Colors.blue),
                    title: new Text('NAME:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.name}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.contact_phone,
                        size: 55, color: Colors.blue),
                    title: new Text('PHONE NUMBER:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.phone}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.contact_mail,
                        size: 55, color: Colors.blue),
                    title: new Text('EMAIL:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.email}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.person_pin_circle,
                        size: 55, color: Colors.blue),
                    title: new Text('ADDRESS:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.address}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.admin_panel_settings,
                        size: 55, color: Colors.blue),
                    title: new Text('PASSWORD:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.password}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.camera_front_outlined,
                        size: 55, color: Colors.blue),
                    title: new Text('REGISTER DATE:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.regDate}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: new RaisedButton(
                      color: Colors.lightGreenAccent[400],
                      child: new Text(
                        'Approve',
                        style: new TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      onPressed: () => approve(),
                    ),
                    trailing: new RaisedButton(
                      color: Colors.red,
                      child: new Text(
                        'Decline',
                        style: new TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      onPressed: () => decline(),
                    ),
                  ),
                  new Divider(
                    // height: 40.0,
                    color: Colors.blue,
                    thickness: 5,
                  ),
                ]),
              )));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Registration No#${currentuser.id} Details'),
            automaticallyImplyLeading: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserList()));
                }),
          ),
          body: Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/images/bck2.jpg"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  new ListTile(
                    title: new Text('${currentuser.status}',
                        textAlign: TextAlign.center,
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
                        size: 55, color: Colors.blue[600]),
                    title: new Text('IC:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.ic}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.contacts,
                        size: 55, color: Colors.blue),
                    title: new Text('NAME:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.name}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.contact_phone,
                        size: 55, color: Colors.blue),
                    title: new Text('PHONE NUMBER:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.phone}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.contact_mail,
                        size: 55, color: Colors.blue),
                    title: new Text('EMAIL:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.email}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.person_pin_circle,
                        size: 55, color: Colors.blue),
                    title: new Text('ADDRESS:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.address}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.admin_panel_settings,
                        size: 55, color: Colors.blue),
                    title: new Text('PASSWORD:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.password}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.camera_front_outlined,
                        size: 55, color: Colors.blue),
                    title: new Text('REGISTER DATE:', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.regDate}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new ListTile(
                    leading: Icon(Icons.how_to_reg_rounded,
                        size: 55, color: Colors.blue),
                    title: new Text('REVIEW DATE::', //add IC variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black)),
                    subtitle: Text('${currentuser.cheDate}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ),
                  new Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0)),
                  new Divider(
                    // height: 40.0,
                    color: Colors.blue,
                    thickness: 5,
                  ),
                ]),
              )));
    }
  }
}

//    void approvemsg() async {
//   String username = 'senderusername';
//   String password = 'senderemail';

//   final smtpServer = gmail(username, password);

//   final message = Message()
//     ..from = Address(username, 'Langkah Admin')
//     ..recipients.add("haozhe3698@gmail.com")
//     ..subject = 'Your registration is approve :: 😀 :: ${DateTime.now()}'
//     ..text = 'IC: ${currentuser.ic}/nPassword: ${currentuser.password}'
//     ..html =
//         "<h1>Registration is Approve</h1>\n<p>Congragulation your registration have been approve, please check it using your langkah App</p>";

//   try {
//     final sendReport = await send(message, smtpServer);
//     print('Message sent: ' + sendReport.toString());
//   } on MailerException catch (e) {
//     print('Message not sent.');
//     for (var p in e.problems) {
//       print('Problem: ${p.code}: ${p.msg}');
//     }
//   }
// }

// void validate(){

// final form = formKey.currentState;
// if(form.validate()) {
//   form.save();
// _now = new DateTime.now();
// regDate = _now.toString();
//     registerUser();
//     print('Form is valid');
//   } else {
//     print('Form is invalid');
//   }
// }
