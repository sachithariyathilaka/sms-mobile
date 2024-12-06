import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> adminNavigationItems = [
  NavigationModel(title: "Home", icon: Icons.home),
  NavigationModel(title: "Teachers", icon: Icons.person),
  NavigationModel(title: "Students", icon: Icons.perm_identity),
  NavigationModel(title: "Courses", icon: Icons.book),
  NavigationModel(title: "Assign Students", icon: Icons.person_add),
  NavigationModel(title: "Settings", icon: Icons.settings),
  NavigationModel(title: "Log Out", icon: Icons.exit_to_app)
];

List<NavigationModel> teacherNavigationItems = [
  NavigationModel(title: "Profile", icon: Icons.person),
  NavigationModel(title: "Courses", icon: Icons.book),
  NavigationModel(title: "Notes", icon: Icons.subject),
  NavigationModel(title: "Assignments", icon: Icons.view_headline),
  NavigationModel(title: "Attendance", icon: Icons.person_add),
  NavigationModel(title: "Settings", icon: Icons.settings),
  NavigationModel(title: "Log Out", icon: Icons.exit_to_app)
];

