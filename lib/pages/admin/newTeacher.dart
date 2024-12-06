import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/utillties/styles.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/pages/admin/teacher.dart';
import 'package:sms/widget/adminSidebar/AdminNavigationDrawerTeachers.dart';

import 'home.dart';

class NewTeacher extends StatefulWidget {

  @override
  NewTeacherState createState() => NewTeacherState();
}

class NewTeacherState extends State<NewTeacher> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";
  String educationValue;
  List<String> education = ["Bsc", "Msc", "Phd", "BA", "MBA"];

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
            "NEW TEACHER",
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
                                    controller: nic,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.account_balance_wallet,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter NIC',
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
                                    controller: subject,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.subject,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter Specific Subject',
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
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: Icon(
                                          Icons.school,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              canvasColor: Color(0xFF398AE5)),
                                          child: Container(
                                            width: 250.0,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: educationValue,
                                                icon: Icon(Icons.arrow_drop_down),
                                                iconSize: 24,
                                                iconEnabledColor: Colors.white,
                                                hint: Text('Select Education Level', style: TextStyle(color: Colors.white)),
                                                style: TextStyle(color: Colors.white),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    educationValue = newValue;
                                                  });
                                                },
                                                items: education.map((teacher) {
                                                  return DropdownMenuItem<String>(
                                                    value: teacher,
                                                    child: Text(teacher),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                      registerTeacher(fullNameBox.text, nic.text, subject.text, educationValue, contact.text, email.text, username.text);
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(
                                      "REGISTER TEACHER",
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
            AdminNavigationDrawerTeachers()
          ],
        )
    );
  }
  registerTeacher(String name, String nic, String subject, String education, String mobile, String email, String username) async {
    Map data = {
      "name": name,
      "nic": nic,
      "subject": subject,
      "mobile": mobile,
      "education": education,
      "email": email,
      "username": username,
      "password": username,
    };
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/teacherRegister", body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200){
      setState(() {
        isLoading=false;
        Fluttertoast.showToast(
            msg: "Teacher Registered Succusfully!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new Teachers()),
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
  TextEditingController nic = new TextEditingController();
  TextEditingController subject = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController username = new TextEditingController();
}