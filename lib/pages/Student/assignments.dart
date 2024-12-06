import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/pages/teacher/newAssignments.dart';
import 'package:sms/widget/ListTile.dart';
import 'package:sms/widget/StudentSlidebar/StudentNavigationDrawerAssignments.dart';
import 'package:sms/widget/teacherSidebar/TeacherNavigationDrawerAssignments.dart';
import 'package:url_launcher/url_launcher.dart';


class StudentAssignments extends StatefulWidget {

  @override
  StudentAssignmentsState createState() => StudentAssignmentsState();
}

class StudentAssignmentsState extends State<StudentAssignments> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  String token = "";
  List<String> dates = [];
  String course = "";

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    getToken().then(updateToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "ASSIGNMENTS",
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 70,
              color: Color(0xFF398AE5),
              margin: EdgeInsets.only(left: 70.0),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.3)
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, counter) {
                      return Divider(
                        height: 0.0, color: Color(0xFF398AE5).withOpacity(0.3),
                      );
                    },
                    itemBuilder: (context, counter) {
                      return listTile(
                        onTap: () {
                          viewNote(dates[counter]);
                        },
                        title: dates[counter],
                        icon: Icons.calendar_today,
                      );
                    },
                    itemCount: dates.length,
                  ),
                ),
              ),
            ),
            StudentNavigationDrawerAssignments()
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

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }

  void updateCourse(String course) {
    setState(() {
      this.course = course;
      getDatesForCourse();
    });
  }

  Future<String> getCourse() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String course = sharedPreferences.getString("course");
    return course;
  }

  void getDatesForCourse() async {
    Map data = {
      "type": "Assignment",
      "course": course,
    };
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': "Bearer " + token
    };
    var response = await http.post(
        "http://13.212.36.183:8081/getDatesForCourse", body: jsonEncode(data),
        headers: headers);
    var jsonData = null;
    jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        for (var i = 0; i < jsonData.length; i++) {
          dates.add(jsonData[i]);
        }
      });
    }
  }

  void viewNote(String date) async {
    Map data = {
      "type": "Note",
      "course": course,
      "date": date
    };
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': "Bearer " + token
    };
    var response = await http.post(
        "http://13.212.36.183:8081/getNotesForDate", body: jsonEncode(data),
        headers: headers);
    var jsonData = null;
    jsonData = response.body.toString();
    if (response.statusCode == 200) {
      _launchURL(jsonData);
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}