import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/pages/admin/newCourse.dart';
import 'package:sms/pages/admin/viewCourse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/widget/ListTile.dart';
import 'package:sms/widget/adminSidebar/AdminNavigationDrawerCources.dart';


class Course extends StatefulWidget {

  @override
  CourseState createState() => CourseState();
}

class CourseState extends State<Course> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";
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
            "COURSES",
            style: TextStyle(color: Colors.white),

          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.white, size: 35.0,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new NewCourse()),
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
                            courseSave(courses[counter]);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => new viewCourse()),
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
            AdminNavigationDrawerCources()
          ],
        )
    );
  }
  void updateToken(String token) {
    setState(() {
      this.token = token;
      getAllCourses();
    });
  }
  Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }
  void getAllCourses() async{
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.get("http://13.212.36.183:8081/getAllCourses", headers: headers);
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
}