import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/pages/admin/student.dart';
import 'package:sms/utillties/styles.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/widget/adminSidebar/AdminNavigationDrawerStudents.dart';

import 'home.dart';

class NewStudent extends StatefulWidget {

  @override
  NewStudentState createState() => NewStudentState();
}

class NewStudentState extends State<NewStudent> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    getToken().then(updateToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "NEW STUDENT",
            style: TextStyle(color: Colors.white),

          ),
          backgroundColor: Color(0xFF398AE5),
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xFF398AE5),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.3)
                  ),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 70.0),
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 50.0,
                                  child: TextField(
                                    controller: fullNameBox,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.perm_contact_calendar,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter Full Name',
                                      hintStyle: kHintTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          margin: EdgeInsets.only(left: 70.0),
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 50.0,
                                  child: TextField(
                                    controller: parent,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.perm_identity,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter Parent Name',
                                      hintStyle: kHintTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          margin: EdgeInsets.only(left: 70.0),
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 50.0,
                                  child: TextField(
                                    controller: age,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.subject,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter Age',
                                      hintStyle: kHintTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          margin: EdgeInsets.only(left: 70.0),
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 50.0,
                                  child: TextField(
                                    controller: school,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.account_balance,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter School',
                                      hintStyle: kHintTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          margin: EdgeInsets.only(left: 70.0),
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 50.0,
                                  child: TextField(
                                    controller: contact,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter Contact Number',
                                      hintStyle: kHintTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          margin: EdgeInsets.only(left: 70.0),
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 50.0,
                                  child: TextField(
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter E-mail Address',
                                      hintStyle: kHintTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          margin: EdgeInsets.only(left: 70.0),
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 50.0,
                                  child: TextField(
                                    controller: username,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.verified_user,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter Username',
                                      hintStyle: kHintTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      isLoading ? Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: CircularProgressIndicator(backgroundColor: Colors.white),
                      ): Container(
                        margin: EdgeInsets.only(left: 70.0),
                        width: MediaQuery.of(context).size.width - 70.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 32.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 70.0,
                                  child: RaisedButton(
                                    elevation: 0.0,
                                    onPressed: (){
                                      setState(() {
                                        isLoading = true;
                                      });
                                      registerStudent(fullNameBox.text, parent.text, age.text, school.text, contact.text, email.text, username.text);
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(
                                      "REGISTER STUDENT",
                                      style: TextStyle(
                                          color: Color(0xFF527DAA),
                                          letterSpacing: 1.0,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'openSans'
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AdminNavigationDrawerStudents()
          ],
        )
    );
  }
  registerStudent(String name, String parent, String age, String school, String mobile, String email, String username) async {
    Map data = {
      "name": name,
      "parent": parent,
      "age": age,
      "mobile": mobile,
      "school": school,
      "email": email,
      "username": username,
      "password": username,
    };
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/studentRegister", body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200){
      setState(() {
        isLoading=false;
        Fluttertoast.showToast(
            msg: "Student Registered Succusfully!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new Students()),
        );
      });
    } else{
      isLoading = false;
      Fluttertoast.showToast(
          msg: "Error Occured, Please Try Again!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  void updateToken(String token) {
    setState(() {
      this.token = token;
    });
  }
  Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }
  TextEditingController fullNameBox = new TextEditingController();
  TextEditingController parent = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController school = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController username = new TextEditingController();
}