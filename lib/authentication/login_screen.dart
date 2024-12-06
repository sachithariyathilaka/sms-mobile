import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sms/pages/Student/home.dart';
import 'package:sms/pages/admin/home.dart';
import 'package:sms/pages/teacher/home.dart';
import 'package:sms/utillties/styles.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool isLoading = false;
  bool isLoadingTeacher = false;
  bool isLoadingStudent   = false;

  Widget buildUsernameBox(){
    return(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 5),
          child: Text(
            'Username',
            style: kLabelStyle,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: usernameBox,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter Your Username',
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    )
    );
  }
  Widget buildPasswordBox(){
    return(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 5),
          child: Text(
            'Password',
            style: kLabelStyle,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            controller: passwordBox,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter Your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    )
    );
  }
  Widget buildForgetPasswordBtn(){
    return( Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed:()=> print("Forgot Password Button Pressed"),
        padding: EdgeInsets.only(right: 5.0),
        child: Text("Forget Password?",
            style: kLabelStyle
        ),
      ),
    ));
  }
  Widget buildRememberMeCheckBox() {
    return(
        Container(
          height: 20.0,
          child: Row(
            children: <Widget>[
              Theme(
                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: Checkbox(
                  value: rememberMe,
                  checkColor:
                  Colors.green,
                  activeColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value;
                    });
                  },
                ),
              ),
              Text("Remember Me",
                  style: kLabelStyle
              ),
            ],
          ),
        )
    );
  }
  Widget buildAdminLoginButton() {
    return(
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          width: double.infinity,
          child: RaisedButton(
            elevation: 5.0,
            onPressed: (){
              setState(() {
                isLoading = true;
              });
              AdminsignIn(usernameBox.text, passwordBox.text);
            },
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.white,
            child: Text(
              "ADMIN LOGIN",
              style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'openSans'
              ),
            ),
          ),
        )
    );
  }
  Widget buildTeacherLoginButton() {
    return(
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          width: double.infinity,
          child: RaisedButton(
            elevation: 5.0,
            onPressed: (){
              setState(() {
                isLoadingTeacher = true;
              });
              TeachersignIn(usernameBox.text, passwordBox.text);
            },
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.white,
            child: Text(
              "TEACHER LOGIN",
              style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'openSans'
              ),
            ),
          ),
        )
    );
  }
  Widget buildStudentLoginButton() {
    return(
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          width: double.infinity,
          child: RaisedButton(
            elevation: 5.0,
            onPressed: (){
              setState(() {
                isLoadingStudent = true;
              });
              StudentsignIn(usernameBox.text, passwordBox.text);
            },
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.white,
            child: Text(
              "STUDENT LOGIN",
              style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'openSans'
              ),
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xFF398AE5),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0.3)
                ),
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 80.0
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage('assets/pp.png'), width: 100, height: 80),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0, right: 48.0),
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,

                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),
                      buildUsernameBox(),
                      SizedBox(height: 30.0),
                      buildPasswordBox(),
                      buildForgetPasswordBtn(),
                      buildRememberMeCheckBox(),
                      isLoading ? Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: CircularProgressIndicator(backgroundColor: Colors.white),
                      ): buildAdminLoginButton(),
                      Column(
                        children: <Widget>[
                          Text(
                            "- OR -",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      isLoadingTeacher ? Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: CircularProgressIndicator(backgroundColor: Colors.white),
                      ): buildTeacherLoginButton(),
                      Column(
                        children: <Widget>[
                          Text(
                            "- OR -",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      isLoadingStudent ? Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: CircularProgressIndicator(backgroundColor: Colors.white),
                      ): buildStudentLoginButton()
                    ],
                  ),
                )

            )
          ],
        )
    );

  }

  TextEditingController usernameBox = new TextEditingController();
  TextEditingController passwordBox = new TextEditingController();
  Future<bool> tokenSave(String token, int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    sharedPreferences.setInt("id", id);
    // ignore: deprecated_member_use
    return sharedPreferences.commit();
  }
  AdminsignIn(String email, String password) async{
    Map data = {
      "username": email,
      "password": password,
    };
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };
    var jsonData = null;
    var response = await http.post("http://13.212.36.183:8081/userLogin", body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200){
      jsonData = json.decode(response.body);
      setState(() {
        isLoading=false;
        /*sharedPreferences.setString("token", jsonData[0]);
        sharedPreferences.setInt("id", jsonData[1]);*/
        String tokenValue = jsonData['token'];
        if(tokenValue == "Invalid"){
          Fluttertoast.showToast(
              msg: "Invalid Credentials, Please Try Again!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
        } else{
          int idValue  = jsonData['id'];
          tokenSave(tokenValue, idValue);
          Fluttertoast.showToast(
              msg: "You're Logged In!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new AdminHomeScreen()),
          );
        }
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
  TeachersignIn(String email, String password) async{
    Map data = {
      "username": email,
      "password": password,
    };
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };
    var jsonData = null;
    var response = await http.post("http://13.212.36.183:8081/teacherLogin", body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200){
      jsonData = json.decode(response.body);
      setState(() {
        isLoadingTeacher=false;
        /*sharedPreferences.setString("token", jsonData[0]);
        sharedPreferences.setInt("id", jsonData[1]);*/
        String tokenValue = jsonData['token'];
        if(tokenValue == "Invalid"){
          Fluttertoast.showToast(
              msg: "Invalid Credentials, Please Try Again!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
        } else{
          int idValue  = jsonData['id'];
          tokenSave(tokenValue, idValue);
          Fluttertoast.showToast(
              msg: "You're Logged In!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new TeacherHomeScreen()),
          );
        }
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
  StudentsignIn(String email, String password) async {
    Map data = {
      "username": email,
      "password": password,
    };
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };
    var jsonData = null;
    var response = await http.post("http://13.212.36.183:8081/studentLogin", body: jsonEncode(data), headers: headers);
    if(response.statusCode == 200){
      jsonData = json.decode(response.body);
      setState(() {
        isLoadingStudent=false;
        /*sharedPreferences.setString("token", jsonData[0]);
        sharedPreferences.setInt("id", jsonData[1]);*/
        String tokenValue = jsonData['token'];
        if(tokenValue == "Invalid"){
          Fluttertoast.showToast(
              msg: "Invalid Credentials, Please Try Again!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
        } else{
          int idValue  = jsonData['id'];
          tokenSave(tokenValue, idValue);
          Fluttertoast.showToast(
              msg: "You're Logged In!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new StudentHomeScreen()),
          );
        }
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



