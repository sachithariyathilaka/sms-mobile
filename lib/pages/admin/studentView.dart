import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/pages/admin/studentCourse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/widget/adminSidebar/AdminNavigationDrawerStudents.dart';

class viewStudent extends StatefulWidget {

  @override
  viewStudentState createState() => viewStudentState();
}

class viewStudentState extends State<viewStudent> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";
  String student = "";
  String name = "" ;
  String parent = "";
  String school = "";
  String mobile ="";
  String email = "";
  String username = "";
  int age = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    getToken().then(updateToken);
    getStudent().then(updateTeacher);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            student+"'s Profile",
            style: TextStyle(color: Colors.white),

          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.subject, color: Colors.white, size: 35.0,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new StudentCourse()),
                );
              },
            )
          ],
          backgroundColor: Color(0xFF398AE5),
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width - 70,
              color: Color(0xFF398AE5),
              margin: EdgeInsets.only(left: 70.0),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.3)
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.person, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Name : "+student, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.perm_contact_calendar, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Parent Name : "+parent, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.school, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("School : "+school, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.subject, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Age : "+age.toString(), style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.phone, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Contact Number : "+mobile, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.email, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("E-mail : "+email, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.verified_user, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Username : "+username, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ),
            AdminNavigationDrawerStudents(),
          ],
        )
    );
  }
  void updateToken(String token) {
    setState(() {
      this.token = token;
      getStudent();
    });
  }
  Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }
  void updateTeacher(String student) {
    setState(() {
      this.student = student;
      getStudentByName();
    });
  }
  Future<String> getStudent() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String teacher = sharedPreferences.getString("student");
    return teacher;
  }
  Future<bool> studentSave(String student) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("student", student);
    // ignore: deprecated_member_use
    return sharedPreferences.commit();
  }
  void getStudentByName() async{
    String data = student;
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/getStudentByName", body: data, headers: headers);
    var jsonData = null;
    jsonData = json.decode(response.body);
    if(response.statusCode == 200){
      setState(() {
        name = jsonData['name'];
        parent = jsonData['parent'];
        age = jsonData['age'];
        school = jsonData['school'];
        mobile = jsonData['mobile'];
        email = jsonData['email'];
        username = jsonData['username'];
      });
    }
  }
}