import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/pages/admin/teacherCourse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/widget/adminSidebar/AdminNavigationDrawerTeachers.dart';

class viewTeachers extends StatefulWidget {

  @override
  viewTeachersState createState() => viewTeachersState();
}

class viewTeachersState extends State<viewTeachers> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";
  String teacher = "";
  String name = "";
  String nic ="";
  String subject = "";
  String education ="";
  String mobile = "";
  String email = "";
  String username = "";

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
            teacher+"'s Profile",
            style: TextStyle(color: Colors.white),

          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.subject, color: Colors.white, size: 35.0,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new TeacherCourse()),
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
                              child: Text("Name : "+teacher, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:32.0, left: 16.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.insert_drive_file, color: Colors.white, size: 24.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("National ID : "+nic, style: TextStyle(fontSize: 20.0, color: Colors.white)),
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
                              child: Text("Specialized Subject : "+subject, style: TextStyle(fontSize: 20.0, color: Colors.white)),
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
                              child: Text("Qualification : "+education, style: TextStyle(fontSize: 20.0, color: Colors.white)),
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
            AdminNavigationDrawerTeachers(),
          ],
        )
    );
  }
  void updateToken(String token) {
    setState(() {
      this.token = token;
      getTeacher().then(updateTeacher);
    });
  }
  Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }
  void updateTeacher(String teacher) {
    setState(() {
      this.teacher = teacher;
      getTeacherByName();
    });
  }
  Future<String> getTeacher() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String teacher = sharedPreferences.getString("teacher");
    return teacher;
  }
  Future<bool> teacherSave(String teacher) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("teacher", teacher);
    // ignore: deprecated_member_use
    return sharedPreferences.commit();
  }
  void getTeacherByName() async{
    String data = teacher;
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/getTeacherByName", body: data, headers: headers);
    var jsonData = null;
    jsonData = json.decode(response.body);
    if(response.statusCode == 200){
      setState(() {
        name = jsonData['name'];
        nic = jsonData['nic'];
        subject = jsonData['subject'];
        education = jsonData['education'];
        mobile = jsonData['mobile'];
        email = jsonData['email'];
        username = jsonData['username'];
      });
    }
  }
}