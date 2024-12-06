import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/authentication/login_screen.dart';
import 'package:sms/model/NavigationModel.dart';
import 'package:sms/pages/admin/assignStudent.dart';
import 'package:sms/pages/admin/teacher.dart';
import 'package:sms/pages/admin/home.dart';
import 'package:sms/pages/admin/student.dart';
import 'package:sms/pages/admin/setting.dart';
import 'package:sms/utillties/styles.dart';
import 'package:sms/pages/admin/course.dart';

import '../CollapsingListTile.dart';


class AdminNavigationDrawerAssign extends StatefulWidget {
  @override
  AdminNavigationDrawerAssignState createState() {
    return new AdminNavigationDrawerAssignState();
  }
}

class AdminNavigationDrawerAssignState extends State<AdminNavigationDrawerAssign> with SingleTickerProviderStateMixin{
  double maxWidth = 220.0;
  double minWidth = 70.0;
  bool isCollapsed = true;
  AnimationController animationController;
  Animation<double> widthAnimation;
  int curruntSelectedIndex = 4;

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
                      'Admin User Panel',
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
                      if(adminNavigationItems[counter].title == 'Teachers'){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new Teachers()),
                        );
                      } else if(adminNavigationItems[counter].title == 'Students'){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new Students()),
                        );
                      }else {
                        if(adminNavigationItems[counter].title == 'Settings'){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new Setting()),
                        );
                      }else if(adminNavigationItems[counter].title == "Home"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new AdminHomeScreen()),
                        );
                      } else if(adminNavigationItems[counter].title == "Courses"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new Course()),
                        );
                      } else if(adminNavigationItems[counter].title == "Assign Students"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new AssignStudent()),
                        );
                      }else if(adminNavigationItems[counter].title == "Log Out"){
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
                      }
                    },
                    isSelected: curruntSelectedIndex == counter,
                    title: adminNavigationItems[counter].title,
                    icon: adminNavigationItems[counter].icon,
                    animationController: animationController);

              },
              itemCount:adminNavigationItems.length,
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