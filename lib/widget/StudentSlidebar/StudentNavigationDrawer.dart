import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/authentication/login_screen.dart';
import 'package:sms/model/NavigationModel.dart';
import 'package:sms/pages/Student/Course.dart';
import 'package:sms/pages/Student/assignments.dart';
import 'package:sms/pages/Student/attendanceCourse.dart';
import 'package:sms/pages/Student/home.dart';
import 'package:sms/pages/Student/notes.dart';
import 'package:sms/pages/admin/studentCourse.dart';
import 'package:sms/pages/teacher/CoursesForAttendance.dart';
import 'package:sms/pages/teacher/coursesForAssignment.dart';
import 'package:sms/pages/teacher/coursesForNotes.dart';
import 'package:sms/pages/teacher/setting.dart';
import 'package:sms/utillties/styles.dart';

import '../CollapsingListTile.dart';


class StudentNavigationDrawer extends StatefulWidget {
  @override
  StudentNavigationDrawerState createState() {
    return new StudentNavigationDrawerState();
  }
}

class StudentNavigationDrawerState extends State<StudentNavigationDrawer> with SingleTickerProviderStateMixin{
  double maxWidth = 220.0;
  double minWidth = 70.0;
  bool isCollapsed = true;
  AnimationController animationController;
  Animation<double> widthAnimation;
  int curruntSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController, builder: (context, widget) => getWidget(context, widget)
    );
  }

  getWidget(context, widget) {
    return Container(
      width: widthAnimation.value,
      color: defaultColor,
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image(image: AssetImage('assets/pp.png'), width: 60, height: 60),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: (widthAnimation.value >= 220) ? Text(
                      'Student User Panel',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ) : Container(),
                  ),

                ],
              ),
            ),
          ),
          Divider(color: Color(0xFF398AE5), height: 40.0),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, counter) {
                return Divider(height: 12.0,
                );
              },
              itemBuilder: (context, counter){
                return CollapsingListTile(
                    onTap: (){
                      setState(() {
                        curruntSelectedIndex = counter;
                      });
                      if(teacherNavigationItems[counter].title == 'Profile'){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new StudentHomeScreen()),
                        );
                      } else if(teacherNavigationItems[counter].title == 'Courses'){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new StudentCourseView()),
                        );
                      }else if(teacherNavigationItems[counter].title == 'Notes'){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new StudentNotes()),
                        );
                      }else if(teacherNavigationItems[counter].title == "Assignments"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new StudentAssignments()),
                        );
                      } else if(teacherNavigationItems[counter].title == "Attendance"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new AttendanceCourse()),
                        );
                      }else if(teacherNavigationItems[counter].title == "Settings"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new Setting()),
                        );
                      } else if(teacherNavigationItems[counter].title == "Log Out"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new LoginScreen()),
                        );
                      } else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new LoginScreen()),
                        );
                      }
                    },
                    isSelected: curruntSelectedIndex == counter,
                    title: teacherNavigationItems[counter].title,
                    icon: teacherNavigationItems[counter].icon,
                    animationController: animationController);

              },
              itemCount:teacherNavigationItems.length,
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                isCollapsed = !isCollapsed;
                isCollapsed ? animationController.reverse() : animationController.forward();
              });
            },
            child: AnimatedIcon(
                icon: AnimatedIcons.menu_arrow,
                progress: animationController,
                color: Colors.white,
                size: 30.0
            ),
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }
}