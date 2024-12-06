import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/authentication/login_screen.dart';
import 'package:sms/pages/admin/assignStudent.dart';
import 'package:sms/pages/admin/course.dart';
import 'package:sms/pages/admin/setting.dart';
import 'package:sms/pages/admin/student.dart';
import 'package:sms/pages/admin/teacher.dart';
import 'package:sms/widget/adminSidebar/AdminNavigationDrawer.dart';

class AdminHomeScreen extends StatefulWidget {

  @override
  AdminHomeScreenState createState() => AdminHomeScreenState();
}

class AdminHomeScreenState extends State<AdminHomeScreen> with SingleTickerProviderStateMixin{
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "HOME",
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
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.3)
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, top: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(image: AssetImage('assets/pp.png'), width: 100, height: 80),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text(
                                'SMS ADMIN PANEL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,

                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Container(
                          margin: EdgeInsets.only(left: 70.0),
                          width: MediaQuery.of(context).size.width - 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 32.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 70.0,
                                    child: RaisedButton(
                                          elevation: 0.0,
                                          onPressed: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => new Teachers()),
                                            );
                                          },
                                          padding: EdgeInsets.all(15.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          color: Colors.white,
                                          child: Text(
                                            "TEACHERS : VIEW ALL & REGISTER",
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 32.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 70.0,
                                    child: RaisedButton(
                                      elevation: 0.0,
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => new Students()),
                                        );
                                      },
                                      padding: EdgeInsets.all(15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      child: Text(
                                        "STUDENTS : VIEW ALL & REGISTER",
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 32.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 70.0,
                                    child: RaisedButton(
                                      elevation: 0.0,
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => new Course()),
                                        );
                                      },
                                      padding: EdgeInsets.all(15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      child: Text(
                                        "COURSES : VIEW ALL & REGISTER",
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 32.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 70.0,
                                    child: RaisedButton(
                                      elevation: 0.0,
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => new AssignStudent()),
                                        );
                                      },
                                      padding: EdgeInsets.all(15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      child: Text(
                                        "ASSIGN STUDENTS : ASSIGN FOR COURCES",
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 32.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 70.0,
                                    child: RaisedButton(
                                      elevation: 0.0,
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => new Setting()),
                                        );
                                      },
                                      padding: EdgeInsets.all(15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      child: Text(
                                        "SETTINGS : CHANGE YOUR PASSWORD",
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 32.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 70.0,
                                    child: RaisedButton(
                                      elevation: 0.0,
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => new LoginScreen()),
                                        );
                                      },
                                      padding: EdgeInsets.all(15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      child: Text(
                                        "LOG OUT : LOG OUT FROM APP",
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AdminNavigationDrawer()
          ],
        )
    );
  }
  }