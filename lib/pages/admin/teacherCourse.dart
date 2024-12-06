import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/pages/admin/viewCourseForTeacher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/widget/ListTile.dart';
import 'package:sms/widget/adminSidebar/AdminNavigationDrawerTeachers.dart';


class TeacherCourse extends StatefulWidget {

  @override
  TeacherCourseState createState() => TeacherCourseState();
}

class TeacherCourseState extends State<TeacherCourse> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";
  String teacher = "";
  List<String> courses = [];

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
            teacher+"'s Courses",
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
                          setState(() {
                            courseSave(courses[counter]);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => new viewCourseForTeacher()),
                          );
                        },
                        title: courses[counter],
                        icon: Icons.subject,
                      );
                    },
                    itemCount:courses.length,
                  ),
                ),
              ),
            ),
            AdminNavigationDrawerTeachers()
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
  void getAllCourses() async{
    String data = teacher;
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/getCoursesByTeacher", body: data, headers: headers);
    var jsonData = null;
    jsonData = json.decode(response.body);
    if(response.statusCode == 200){
      setState(() {
        for(var i=0; i<jsonData.length; i++){
          courses.add(jsonData[i]['courseName']);
        }
      });
    }
  }
  Future<bool> courseSave(String course) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("course", course);
    // ignore: deprecated_member_use
    return sharedPreferences.commit();
  }
  void updateTeacher(String teacher) {
    setState(() {
      this.teacher = teacher;
      getAllCourses();
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
}