import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',

);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF398AE5),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final inputBox =  BoxDecoration(
    color: Colors.transparent.withOpacity(0.3),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
TextStyle listTitleDefault = TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);
TextStyle selectedListTitleDefault = TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);

Color selectedColor = Colors.black54;
Color defaultColor = Color(0xFF398AE5);
