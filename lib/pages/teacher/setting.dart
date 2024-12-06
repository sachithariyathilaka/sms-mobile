import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/utillties/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms/widget/adminSidebar/AdminNavigationDrawerSettings.dart';
import 'package:sms/widget/teacherSidebar/TeacherNavigationDrawer.dart';
import 'package:sms/widget/teacherSidebar/TeacherNavigationDrawerSetting.dart';


class Setting extends StatefulWidget {

  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  bool isLoading = false;
  String token = "";
  int id = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    getToken().then(updateToken);
    getId().then(updateId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "SETTINGS",
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
                                    controller: old,
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.lock_open,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter Currant Password',
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
                        padding: const EdgeInsets.only(top: 0.0),
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
                                    controller: newPswd,
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Enter New Password',
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
                        padding: const EdgeInsets.only(top: 0.0),
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
                                    controller: rePswd,
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14.0),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      hintText: 'Re-Enter New Password',
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
                                      changePassword(newPswd.text, rePswd.text);
                                    },
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    child: Text(
                                      "CHANGE PASSWORD",
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
            TeacherNavigationDrawerSetting()
          ],
        )
    );
  }
  TextEditingController old = new TextEditingController();
  TextEditingController newPswd = new TextEditingController();
  TextEditingController rePswd = new TextEditingController();

  void changePassword(String newPswd, String rePswd) async {
    if(newPswd == rePswd){
      Map data = {
        "id": id,
        "password": newPswd
      };
      Map<String,String> headers = {
        'Content-type' : 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer "+token
      };
      var response = await http.post("http://13.212.36.183:8081/changeAdminPswd", body: jsonEncode(data), headers: headers);
      var jsonData = null;
      jsonData = json.decode(response.body);
      if(response.statusCode == 200){
        setState(() {
          isLoading=false;
          idSave(jsonData['id']);
          Fluttertoast.showToast(
              msg: "Password Changed Succusfully!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new Setting()),
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
    } else{
      isLoading = false;
      Fluttertoast.showToast(
          msg: "Two Passwords are not matching, Please Try Again!!",
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
    });
  }
  Future<int> getId() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt("id");
    return id;
  }
  Future<bool> idSave(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("id", id);
    // ignore: deprecated_member_use
    return sharedPreferences.commit();
  }
}