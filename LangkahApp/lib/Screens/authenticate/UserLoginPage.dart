import 'package:LangkahApp/Screens/authenticate/RegistrationPage.dart';
import 'package:LangkahApp/Screens/authenticate/UserMainPage.dart';
import 'package:flutter/material.dart';
import 'package:LangkahApp/Screens/authenticate/AdminLoginPage.dart';
import 'package:LangkahApp/Screens/authenticate/ForgotPasswordPage.dart';
import 'package:LangkahApp/Classes/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  TextEditingController ic = TextEditingController();

  TextEditingController pass = TextEditingController();

  Future login() async {
    var url = "https://langkah2020.000webhostapp.com/login.php";
    var response = await http.post(url, body: {
      "ic": ic.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Login success!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('ic', ic.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => new UserMainPage()));
    } else {
      Fluttertoast.showToast(
          msg: "Incorrect IC or password!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 50, left: 10, right: 10),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminLoginPage()));
                          },
                          child: Text('Admin Login   ',
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                      SizedBox(height: 20),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/images/step.jpg',
                                width: 100, height: 150),
                            Text('LANGKAH',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30)),
                            SizedBox(height: 40),
                            TextField(
                              controller: ic,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.account_box),
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                  labelText: 'IC number'),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: pass,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                  labelText: 'Password'),
                            ),
                            SizedBox(height: 40),
                            FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 86),
                                child:
                                Text('Login', style: TextStyle(fontSize: 20)),
                                onPressed: () {
                                  login();
                                },
                                color: Colors.lightBlue,
                                textColor: Colors.white),
                            SizedBox(height: 5),
                            OutlineButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text('Register An Account',
                                    style: TextStyle(fontSize: 20)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          new RegistrationPage()));
                                },
                                color: Colors.white,
                                textColor: Colors.lightBlue,
                                borderSide: BorderSide(color: Colors.lightBlue)),
                            SizedBox(height: 5),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordPage()));
                                },
                                child: Text('Forgot Password?',
                                    style: TextStyle(
                                        color: Colors.lightBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)))
                          ])
                    ]))));
  }
}
