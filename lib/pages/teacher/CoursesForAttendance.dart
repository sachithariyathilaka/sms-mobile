import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/pages/teacher/attendanceDates.dart';
import 'package:sms/widget/ListTile.dart';
import 'package:sms/widget/teacherSidebar/TeacherNavigationDrawerAttendance.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CoursesForAttendance extends StatefulWidget {

  @override
  CoursesForAttendanceState createState() => CoursesForAttendanceState();
}

class CoursesForAttendanceState extends State<CoursesForAttendance> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";
  int id = 0;
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
            "ATTENDANCE",
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
                            MaterialPageRoute(builder: (context) => new AttendanceDates()),
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
            TeacherNavigationDrawerAttendance()
          ],
        )
    );
  }
  void updateToken(String token) {
    setState(() {
      this.token = token;
      getId().then(updateId);
      getAllCourses();
    });
  }
  Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }
  void getAllCourses() async{
    String data = id.toString();
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/getCoursesByTeacherId", body: data, headers: headers);
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
  Future<int> getId() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt("id");
    return id;
  }
  void updateId(int id) {
    setState(() {
      this.id = id;
      getAllCourses();
    });
  }
}