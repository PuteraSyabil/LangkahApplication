import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:LangkahApp/Screens/authenticate/UserMainPage.dart';
import 'package:LangkahApp/Classes/User.dart';
import 'package:intl/intl.dart';

class UpperCaseTxt extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue txtOld, TextEditingValue txtNew) {
    return txtNew.copyWith(text: txtNew.text.toUpperCase());
  }
}

class RequestPermitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RequestPermitPage();
}

class _RequestPermitPage extends State<RequestPermitPage> {
  final formKey = new GlobalKey<FormState>();

  // String _ic = "";
  String _deptAddress = "";
  String _destAddress = "";
  String _purpose = "";
  String _deptDate = "";
  DateTime _now;
  String regDate = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate:
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        otherController.text = formattedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    final User currentuser = ModalRoute.of(context).settings.arguments;

    void saveRequest() async {
      var url = "https://langkah2020.000webhostapp.com/requestPermit.php";
      var data = {
        "ic": currentuser.ic,
        "deptAddress": _deptAddress,
        "destAddress": _destAddress,
        "deptDate": _deptDate,
        "purpose": _purpose,
        "regDate": regDate,
      };
      var res = await http.post(url, body: data);
      if (jsonDecode(res.body) == "Data Inserted") {
        Fluttertoast.showToast(
            msg: "Your request is sent successfully for approve.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserMainPage(),
                settings: RouteSettings(arguments: currentuser)));
      } else {
        Fluttertoast.showToast(
            msg: "Your IC Number or format of Departure Date incorrect!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
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
        saveRequest();
        print('Form is valid');
      } else {
        print('Form is invalid');
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Request Permit"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserMainPage(),
                      settings: RouteSettings(arguments: currentuser)));
            }),
      ),
      body: new SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Text(
                    'Interstate Travel Permit Form',
                    style: new TextStyle(
                      color: Colors.blue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 20),
                  // new TextFormField(
                  //   decoration: new InputDecoration(labelText: 'IC Number'),
                  //   validator: (value) =>
                  //       value.isEmpty ? 'IC Number can\'t be empty' : null,
                  //   onSaved: (value) => _ic = value,
                  // ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration:
                        new InputDecoration(icon: Icon(Icons.add_location_sharp), labelText: 'Departure Address'),
                    inputFormatters: [
                      UpperCaseTxt(),
                    ],
                    validator: (value) => value.isEmpty
                        ? 'Departure Address can\'t be empty'
                        : null,
                    onSaved: (value) => _deptAddress = value,
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration:
                        new InputDecoration(icon: Icon(Icons.apartment), labelText: 'Destination Address'),
                    inputFormatters: [
                      UpperCaseTxt(),
                    ],
                    validator: (value) => value.isEmpty
                        ? 'Destination Address can\'t be empty'
                        : null,
                    onSaved: (value) => _destAddress = value,
                  ),
                  SizedBox(height: 20),
                  new TextFormField(
                    decoration: new InputDecoration(icon: Icon(Icons.book_rounded), labelText: "Purpose"),
                    validator: (value) =>
                        value.isEmpty ? 'Purpose can\'t be empty' : null,
                    onSaved: (value) => _purpose = value,
                  ),

                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: new TextFormField(
                        decoration: new InputDecoration(
                            icon: Icon(Icons.date_range),
                            labelText: "Departure Date"),
                        controller: otherController,
                        validator: (otherController) => otherController.isEmpty
                            ? 'Depature Date can\'t be empty'
                            : null,
                        onSaved: (otherController) =>
                            _deptDate = otherController,
                      ),
                    ),
                  ),
                  // new TextFormField(
                  //   decoration: new InputDecoration(
                  //       labelText: 'Departure Date (YYYY-MM-DD)'),
                  //   validator: (value) =>
                  //       value.isEmpty ? 'Departure Date can\'t be empty' : null,
                  //   onSaved: (value) => _deptDate = value,
                  // ),

                  SizedBox(height: 50),
                  new RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 9, horizontal: 45),
                      color: Colors.blue,
                      child: new Text(
                        'Submit',
                        style: new TextStyle(fontSize: 23, color: Colors.white),
                      ),
                      onPressed: () {
                        validateAndSave();
                      })
                ],
              ))),
    );
  }
}
