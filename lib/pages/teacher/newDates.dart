
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/utillties/styles.dart';
import 'package:sms/widget/teacherSidebar/TeacherNavigationDrawerAttendance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'attendanceDates.dart';

class NewDates extends StatefulWidget {

  @override
  NewDatesState createState() => NewDatesState();
}

class NewDatesState extends State<NewDates> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  String token = "";
  bool isLoading = false;
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
            "NEW DATES",
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
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 70.0),
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 50.0,
                                  child: TextField(
                                    controller: date,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter Date',
                                      hintStyle: kHintTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      isLoading ? Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: CircularProgressIndicator(backgroundColor: Colors.white),
                      ): Container(
                        margin: EdgeInsets.only(left: 70.0),
                        width: MediaQuery.of(context).size.width - 70.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 32.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 70.0,
                                  child: RaisedButton(
                                    elevation: 0.0,
                                    onPressed: (){
                                      setState(() {
                                        isLoading = true;
                                      });
                                      registerDate(date.text);
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(
                                      "REGISTER DATE",
                                      style: TextStyle(
                                          color: Color(0xFF527DAA),
                                          letterSpacing: 1.0,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'openSans'
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
  Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }
  void updateCourse(String course) {
    setState(() {
      this.course = course;
    });
  }
  Future<String> getCourse() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String course = sharedPreferences.getString("course");
    return course;
  }
  TextEditingController date = new TextEditingController();
  void registerDate(String date) async{
    Map data = {
      "date": date,
      "course": course
    };
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/newTempDate", body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200){
      setState(() {
        isLoading=false;
        Fluttertoast.showToast(
            msg: "Date Registered Succusfully!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new AttendanceDates()),
        );
      });
    } else{
      isLoading = false;
      Fluttertoast.showToast(
          msg: "Error Occured, Please Try Again!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}