import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/pages/admin/studentView.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/widget/ListTile.dart';
import 'package:sms/widget/adminSidebar/AdminNavigationDrawerStudents.dart';
import 'package:sms/widget/teacherSidebar/TeacherNavigationDrawerAttendance.dart';

class ViewAttendance extends StatefulWidget {

  @override
  ViewAttendanceState createState() => ViewAttendanceState();
}

class ViewAttendanceState extends State<ViewAttendance> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";
  String course = "";
  String date = "";
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
            "VIEW ATTENDANCE",
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
                  child: ListView.separated(
                    separatorBuilder: (context, counter) {
                      return Divider(height: 0.0, color: Color(0xFF398AE5).withOpacity(0.3),
                      );
                    },
                    itemBuilder: (context, counter){
                      return listTile(
                        onTap: (){
                        },
                        title: students[counter],
                        icon: Icons.person,
                      );
                    },
                    itemCount:students.length,
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
  Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }
  void getAllStudents() async{
    Map data = {
      "course": course,
      "date": date
    };

    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/getAllStudentsForAttendance", body: jsonEncode(data), headers: headers);
    var jsonData = null;
    jsonData = json.decode(response.body);
    if(response.statusCode == 200){
      setState(() {
        for(var i=0; i<jsonData.length; i++){
          students.add(jsonData[i]);
        }
      });
    }
  }
  void updateCourse(String course) {
    setState(() {
      this.course = course;
      getDate().then(updateDate);
    });
  }
  Future<String> getCourse() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String course = sharedPreferences.getString("course");
    return course;
  }
  void updateDate(String date) {
    setState(() {
      this.date = date;
      getAllStudents();
    });
  }
  Future<String> getDate() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String date = sharedPreferences.getString("date");
    return date;
  }
}