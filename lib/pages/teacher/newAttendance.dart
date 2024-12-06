
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/utillties/styles.dart';
import 'package:sms/widget/attendanceListTile.dart';
import 'package:sms/widget/teacherSidebar/TeacherNavigationDrawerAttendance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class NewAttendance extends StatefulWidget {

  @override
  NewAttendanceState createState() => NewAttendanceState();
}

class NewAttendanceState extends State<NewAttendance> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  String token = "";
  int id = 0;
  String course="";
  List<String> students = [];

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
            "NEW ATTENDANCE",
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
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, counter) {
                            return Divider(height: 0.0, color: Color(0xFF398AE5).withOpacity(0.3),
                            );
                          },
                          itemBuilder: (context, counter){
                            return attendanceListTile(
                              title: students[counter],
                            );
                          },
                          itemCount:students.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TeacherNavigationDrawerAttendance()
          ],
        )
    );
  }
  void updateToken(String token) {
    setState(() {
      this.token = token;
      getCourse().then(updateCourse);
    });
  }
  void updateCourse(String course) {
    setState(() {
      this.course = course;
      getStudentByCourse();
    });
  }
  Future<String> getCourse() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String course = sharedPreferences.getString("course");
    return course;
  }
  Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }
  void getStudentByCourse() async{
    String data = course;
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/getStudentsByCourse", body: data, headers: headers);
    var jsonData = null;
    jsonData = json.decode(response.body);
    if(response.statusCode == 200){
      setState(() {
        for(var i=0; i<jsonData.length; i++){
          students.add(jsonData[i]['student']);
        }
      });
    }
  }
  TextEditingController date = new TextEditingController();
  void markAttendance(String value) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String course = sharedPreferences.getString("course");
    String token = sharedPreferences.getString("token");
    String date = sharedPreferences.getString("date");
    Map data = {
      "course": course,
      "student": value,
      "date": date
    };
    Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/markAttendance", body:jsonEncode(data), headers: headers);
    var jsonData = null;
    jsonData = json.decode(response.body);
    if(response.statusCode == 200){
      Fluttertoast.showToast(
          msg: "Attendance Marked!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}
