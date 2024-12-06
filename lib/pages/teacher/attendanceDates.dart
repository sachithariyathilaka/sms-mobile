import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/pages/teacher/newAttendance.dart';
import 'package:sms/pages/teacher/viewDates.dart';
import 'package:sms/widget/ListTile.dart';
import 'package:sms/widget/teacherSidebar/TeacherNavigationDrawerAttendance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AttendanceDates extends StatefulWidget {

  @override
  AttendanceDatesState createState() => AttendanceDatesState();
}

class AttendanceDatesState extends State<AttendanceDates> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  String token = "";
  List<String> dates = [];
  String course = "";

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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.white, size: 35.0,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new ViewDates()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.white, size: 35.0,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new NewAttendance()),
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
                  child: ListView.separated(
                    separatorBuilder: (context, counter) {
                      return Divider(height: 0.0, color: Color(0xFF398AE5).withOpacity(0.3),
                      );
                    },
                    itemBuilder: (context, counter){
                      return listTile(
                        onTap: (){
                          setState(() {
                            dateSave(dates[counter]);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => new NewAttendance()),
                          );
                        },
                        title: dates[counter],
                        icon: Icons.calendar_today,
                      );
                    },
                    itemCount:dates.length,
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
  void updateCourse(String course) {
    setState(() {
      this.course = course;
      getDatesForCourse();
    });
  }
  Future<String> getCourse() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String course = sharedPreferences.getString("course");
    return course;
  }
  void getDatesForCourse() async{
    String data = course;
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/tempDatesForCourse", body: data, headers: headers);
    var jsonData = null;
    jsonData = json.decode(response.body);
    if(response.statusCode == 200){
      setState(() {
        for(var i=0; i<jsonData.length; i++){
          dates.add(jsonData[i]);
        }
      });
    }
  }
  Future<bool> dateSave(String date) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("date", date);
    // ignore: deprecated_member_use
    return sharedPreferences.commit();
  }
}