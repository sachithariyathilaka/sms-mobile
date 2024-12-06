import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/utillties/styles.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/widget/teacherSidebar/TeacherNavigationDrawerNotes.dart';

import 'notes.dart';


class NewNotes extends StatefulWidget {

  @override
  NewNotesState createState() => NewNotesState();
}

class NewNotesState extends State<NewNotes> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";
  int id = 0;
  String courseValue;
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
            "NEW NOTES",
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
                                        Icons.perm_contact_calendar,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
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
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              canvasColor: Color(0xFF398AE5)),
                                          child: Container(
                                            width: 250.0,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: courseValue,
                                                icon: Icon(Icons.arrow_drop_down),
                                                iconSize: 24,
                                                iconEnabledColor: Colors.white,
                                                hint: Text('Select Course', style: TextStyle(color: Colors.white)),
                                                style: TextStyle(color: Colors.white),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    courseValue = newValue;
                                                  });
                                                },
                                                items: courses.map((student) {
                                                  return DropdownMenuItem<String>(
                                                    value: student,
                                                    child: Text(student),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
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
                                    controller: note,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.subject,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter E-note Link',
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
                                      registerNote(date.text, courseValue, note.text);
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(
                                      "ADD NOTE",
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
            TeacherNavigationDrawerNotes()
          ],
        )
    );
  }
  registerNote(String date, String course, String note) async {
    Map data = {
      "date": date,
      "course": course,
      "url": note,
      "type": "Note"
    };
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer "+token
    };
    var response = await http.post("http://13.212.36.183:8081/saveNote", body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200){
      setState(() {
        isLoading=false;
        Fluttertoast.showToast(
            msg: "Note Insert Succusfully!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new Notes()),
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
  TextEditingController date = new TextEditingController();
  TextEditingController note = new TextEditingController();

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
}