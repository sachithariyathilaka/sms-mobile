import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/utillties/styles.dart';

class CollapsingListTile extends StatefulWidget{
  final String title;
  final IconData icon;
  AnimationController animationController;
  final bool isSelected;
  final Function onTap;
  CollapsingListTile({@required this.title, @required this.icon, @required this.animationController, this.isSelected = false, this.onTap});

  @override
  CollapsingListTileState createState() {
    return new CollapsingListTileState();
  }
  }

class CollapsingListTileState extends State<CollapsingListTile> with SingleTickerProviderStateMixin{
  Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    widthAnimation = Tween<double>(begin: 70.0, end: 220.0).animate(widget.animationController);
    sizedBoxAnimation = Tween<double>(begin: 10.0, end: 0).animate(widget.animationController);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected ? Colors.transparent.withOpacity(0.3) : Colors.transparent
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(widget.icon, color: Colors.white, size: 28.0),
            SizedBox(width: sizedBoxAnimation.value),
            (widthAnimation.value >= 220) ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.title, style: widget.isSelected ? selectedListTitleDefault : listTitleDefault),
            ) : Container(width: 0.0, height: 0.0)
          ],
        ),
      ),
    );
  }
}

