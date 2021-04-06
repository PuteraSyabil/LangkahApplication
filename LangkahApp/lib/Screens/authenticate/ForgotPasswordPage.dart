import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:LangkahApp/Screens/authenticate/UserLoginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:LangkahApp/services/passwordgenerator.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPage createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  TextEditingController ic = TextEditingController();
  TextEditingController email = TextEditingController();
  String _generatedPassword = "";
  @override
  void initState() {
    super.initState();
    ic = new TextEditingController();
    email = new TextEditingController();
  }

  void resetmsg(String pass) async {
    String username = 'langkahapp@gmail.com';
    String password = 'langkahapp@isthebest';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Langkah Admin')
      ..recipients.add('${email.text}')
      ..subject = ' Langkah Account Registration is approved.'
      ..text = 'Do not reply to this msg'
      ..html =
          "<h1>Password reset successfully</h1><p>Your langkah account password was on ${DateTime.now()}\nCurrent account info:\nIC:${ic.text}\nPassword:$pass</p>";

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

  void resetPass() async {
    _generatedPassword = generatePassword(true, true, true, false, 17);
    if (ic.text.isNotEmpty && email.text.isNotEmpty) {
      var url = "https://langkah2020.000webhostapp.com/forgotpassword.php";
      var response = await http.post(url, body: {
        "ic": ic.text,
        "email": email.text,
        "password": _generatedPassword,
      });
      var data = json.decode(response.body);
      if (data == "Success") {
        Fluttertoast.showToast(
            msg: "Your password was reset, please check your email",
            toastLength: Toast.LENGTH_SHORT);
        resetmsg(_generatedPassword);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserLoginPage()));
      } else if (data == "Invalid") {
        Fluttertoast.showToast(
            msg: "Invalid IC and Email",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2);
      } else if (data == "Failed") {
        Fluttertoast.showToast(
            msg: "Error occurs, please try it again later.",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2);
      } else {
        Fluttertoast.showToast(
            msg: "Failed to reset password",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 2);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please enter the IC and Email",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar( centerTitle: true,
          title: Text('Reset Password')),
        body: SingleChildScrollView(child: 
        Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child:
                Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                alignment: Alignment.topCenter,
                  child: 
                Column(children: <Widget>[
                  SizedBox(
                  height: 40,
                  width: 300,
                  child: Center(child: Text('Forgot Password?', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),)),
                  ),
                  SizedBox(height:90),
                  Card(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blue[50],
                elevation: 10,
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(height: 40, width: 400,),
                  SizedBox(
                  width: 300,
                  height: 80,
                  child: 
                  TextField(
                      controller: ic,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box_rounded),
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: OutlineInputBorder(),
                          labelText: 'Registered IC number')),
                  ),
                  SizedBox(
                  width: 300,  
                  height: 80,
                  child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: OutlineInputBorder(),
                          labelText: 'Registered email address')),),
                
                ])
                ,),
                SizedBox(height:20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                        child: Text('Get New Password',
                            style: TextStyle(fontSize: 20)),
                        onPressed: () {
                          resetPass();
                        },
                        color: Colors.lightBlue,
                        textColor: Colors.white)
                  ]),
                ]),  
                ) 
        ,)
        
                
                
                ));
  }
}
