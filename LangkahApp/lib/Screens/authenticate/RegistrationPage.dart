import 'dart:convert';
import 'package:LangkahApp/Screens/authenticate/UserLoginPage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class UpperCaseTxt extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue txtOld, TextEditingValue txtNew) {
    return txtNew.copyWith(text: txtNew.text.toUpperCase());
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  final formKey = new GlobalKey<FormState>();

  String _ic = "";
  String _name = "";
  String _phoneNum = "";
  String _email = "";
  String _address = "";
  String _password = "";
  DateTime _now;
  String regDate = "";

  void registerUser() async {
    var url = "https://langkah2020.000webhostapp.com/register.php";
    var data = {
      "ic": _ic,
      "name": _name,
      "phone": _phoneNum,
      "email": _email,
      "address": _address,
      "password": _password,
      "regDate": regDate,
    };
    var res = await http.post(url, body: data);
    if (jsonDecode(res.body) == "IC is already registered") {
      Fluttertoast.showToast(
          msg: "Account already exist!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red[100],
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (jsonDecode(res.body) == "Successfully") {
      Fluttertoast.showToast(
          msg: "Registration is sent successfully for approve.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserLoginPage()));
    } else if (jsonDecode(res.body) == "Failed") {
      Fluttertoast.showToast(
          msg: "Error!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _now = new DateTime.now();
      regDate = _now.toString();
      registerUser();
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Langkah"),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Text(
                    'Registration',
                    style: new TextStyle(
                      color: Colors.blue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'IC Number'),
                    validator: (value) =>
                        value.isEmpty ? 'IC Number can\'t be empty' : null,
                    onSaved: (value) => _ic = value,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'Name'),
                    inputFormatters: [
                      UpperCaseTxt(),
                    ],
                    validator: (value) =>
                        value.isEmpty ? 'Name can\'t be empty' : null,
                    onSaved: (value) => _name = value,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'Phone Number'),
                    validator: (value) =>
                        value.isEmpty ? 'Phone Number can\'t be empty' : null,
                    onSaved: (value) => _phoneNum = value,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'Email'),
                    validator: (value) =>
                        value.isEmpty ? 'Email can\'t be empty' : null,
                    onSaved: (value) => _email = value,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'Address'),
                    inputFormatters: [
                      UpperCaseTxt(),
                    ],
                    validator: (value) =>
                        value.isEmpty ? 'Adress can\'t be empty' : null,
                    onSaved: (value) => _address = value,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) =>
                        value.isEmpty ? 'Password can\'t be empty' : null,
                    onSaved: (value) => _password = value,
                  ),
                  SizedBox(height: 40,),
                  new FlatButton(
                    padding: EdgeInsets.symmetric(vertical:12, horizontal: 60),
                    color: Colors.blue,
                    child: new Text(
                      'Sign Up',
                      style: new TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () => validateAndSave(),
                  )
                ],
              ))),
    );
  }
}
