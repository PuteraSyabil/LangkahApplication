import 'package:LangkahApp/Screens/authenticate/UserLoginPage.dart';
import 'package:LangkahApp/Screens/authenticate/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:LangkahApp/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserLoginPage(),
      ),
    );
  }
}
