import 'package:flutter/material.dart';
import 'authentication/login_screen.dart';

void main() => runApp(app());

class app extends StatefulWidget{
  @override
  AppState createState() => AppState();
}

class AppState extends State<app>{
  @override
  Widget build(BuildContext context) {
    return (
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "SMS",
          home: LoginScreen(),
        ));
  }

}
