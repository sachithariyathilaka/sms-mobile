import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/widget/teacherSidebar/TeacherNavigationDrawer.dart';

class TeacherHomeScreen extends StatefulWidget {

  @override
  TeacherHomeScreenState createState() => TeacherHomeScreenState();
}

class TeacherHomeScreenState extends State<TeacherHomeScreen> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  String token = "";
  int id = 0;
  String name = "";
  String nic = "";
  String subject = "";
  String education = "";
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
            "PROFILE",
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
                              Icon(Icons.person, color: Colors.white, size: 24.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Name : "+name, style: TextStyle(fontSize: 20.0, color: Colors.white)),
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
            TeacherNavigationDrawer(),
          ],
        )
    );
  }

  void updateToken(String token) {
    setState(() {
      this.token = token;
      getId().then(updateId);
    });
  }
  Future<String> getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    return token;
  }
  void updateId(int id) {
    setState(() {
      this.id = id;
      getTeacherById();
    });
  }
  Future<int> getId() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt("id");
    return id;
  }

  void getTeacherById() async{
    String data = id.toString();
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/getTeacherById", body: data, headers: headers);
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