import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../pages/teacher/newAttendance.dart';

class attendanceListTile extends StatefulWidget{
  final String title;
  attendanceListTile({@required this.title});

  @override
  attendanceListTileState createState() {
    return new attendanceListTileState();
  }
}

class attendanceListTileState extends State<attendanceListTile>{
  NewAttendanceState newAttendanceState = new NewAttendanceState();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0, bottom: 0.0, left: 70.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: Colors.white
            ),
          width: MediaQuery.of(context).size.width - 70.0,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: CheckboxListTile(
            title: Text(widget.title, style: TextStyle(fontSize: 20.0, color: Color(0xFF527DAA))),
            value: timeDilation != 1.0,
            onChanged: (bool value) {
              setState(() {
                timeDilation = value ? 10.0 : 1.0;
                newAttendanceState.markAttendance(widget.title);
              });
            },
          )
        ),
      ),
    );
  }
}