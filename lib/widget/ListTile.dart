import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class listTile extends StatefulWidget{
  final String title;
  final IconData icon;
  final Function onTap;
  listTile({@required this.title, @required this.icon, this.onTap});

  @override
  listTileState createState() {
    return new listTileState();
  }
}

class listTileState extends State<listTile>{

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0, bottom: 0.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              color: Colors.white
          ),
          width: MediaQuery.of(context).size.width - 70.0,
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            children: <Widget>[
              Icon(widget.icon, color: Color(0xFF527DAA), size: 24.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(widget.title, style: TextStyle(fontSize: 20.0, color: Color(0xFF527DAA)),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}