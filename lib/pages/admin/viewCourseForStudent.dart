import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/widget/adminSidebar/AdminNavigationDrawerStudents.dart';

class viewCourseForStudent extends StatefulWidget {

  @override
  viewCourseForStudentState createState() => viewCourseForStudentState();
}

class viewCourseForStudentState extends State<viewCourseForStudent> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";
  String course = "";
  String name = "";
  String date = "";
  String hall = "";
  String time = "";
  String location = "";
  String teacher ="";
  double duration = 0.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    getToken().then(updateToken);
    getCourse().then(updateCourse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            course+" Course",
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
                              Icon(Icons.calendar_today, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Start Date : "+date, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.timer, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Time : "+time, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.account_balance, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Lecture Hall : "+hall, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.access_time, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Duration : "+duration.toString()+" hours", style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Location : "+location, style: TextStyle(fontSize: 20.0, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:32.0, left: 16.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.person, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Teacher : "+teacher, style: TextStyle(fontSize: 20.0, color: Colors.white)),
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
      getCourse();
    });
  }
  Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }
  void updateCourse(String course) {
    setState(() {
      this.course = course;
      getCourseByName();
    });
  }
  Future<String> getCourse() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String teacher = sharedPreferences.getString("course");
    return teacher;
  }
  Future<bool> courseSave(String course) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("course", course);
    // ignore: deprecated_member_use
    return sharedPreferences.commit();
  }
  void getCourseByName() async{
    String data = course;
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/getCourseByName", body: data, headers: headers);
    var jsonData = null;
    jsonData = json.decode(response.body);
    if(response.statusCode == 200){
      setState(() {
        name = jsonData['courseName'];
        duration = jsonData['duration'];
        date = jsonData['startDate'];
        time = jsonData['time'];
        location = jsonData['location'];
        teacher = jsonData['teacher'];
        hall = jsonData['hall'];
      });
    }
  }
}