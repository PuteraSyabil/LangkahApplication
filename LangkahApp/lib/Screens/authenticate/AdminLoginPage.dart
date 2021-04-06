import 'package:LangkahApp/Screens/authenticate/UserLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:LangkahApp/Screens/authenticate/AdminMainPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class UpperCaseTxt extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue txtOld, TextEditingValue txtNew) {
    return txtNew.copyWith(text: txtNew.text.toUpperCase());
  }
}

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  TextEditingController username = TextEditingController();

  TextEditingController pass = TextEditingController();
  Future adminLogin() async {
    var url = "https://langkah2020.000webhostapp.com/admin_login.php";
    var response = await http.post(url, body: {
      "username": username.text.toUpperCase(),
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Login success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminMainPage()));
    } else {
      Fluttertoast.showToast(
          msg: "Username or password is incorrect!",
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
        appBar: AppBar(
          title: Text('         Welcome Admin'),
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserLoginPage()));
              }),
        ),
        body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin:EdgeInsets.only(top:10, left:10, right:10),
        child: SingleChildScrollView(
        child:Column(children:<Widget>[logo(), SizedBox(height:50), loginfunction()]))
      )
    );
  }

  Widget logo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[Image.asset('assets/images/step.jpg', width: 100, height:150),
                                Text('LANGKAH', style: TextStyle(color: Colors.black,
                                                                 fontWeight: FontWeight.bold,
                                                                 fontSize: 30,))]);
  }

  Widget loginfunction(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
                TextField(controller: username, decoration: InputDecoration( labelText: 'Username', prefixIcon: Icon(Icons.account_box), contentPadding:EdgeInsets.fromLTRB(10,0,10,0), border: OutlineInputBorder()),
                inputFormatters: [
                  UpperCaseTxt(),
                ],),
                SizedBox(height:20),
                TextField(obscureText:true, controller: pass, decoration: InputDecoration( labelText: 'Password', prefixIcon: Icon(Icons.lock), contentPadding:EdgeInsets.fromLTRB(10,0,10,0), border: OutlineInputBorder())),
                SizedBox(height:40),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [FlatButton(padding: EdgeInsets.symmetric(vertical:12, horizontal: 60),
                                            child: Text('Login', style: TextStyle(fontSize: 20)),
                                            onPressed: (){adminLogin(); },
                                            color: Colors.lightBlue,
                                            textColor: Colors.white)])
          ]
        );

  }

  
}