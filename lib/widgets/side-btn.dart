import 'package:flutter/material.dart';

class SideBtn extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double size;
  final bool isCircle;
  final Function onPressed;

  SideBtn({Key key,this.color,this.icon,this.size : 30,this.isCircle:false,this.onPressed}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
      final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
        primary: this.color,
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: isCircle
            ? CircleBorder()
            : const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
        side: BorderSide(color: this.color));
    return OutlinedButton(
      onPressed: onPressed,
      child: Icon(icon, size: size),
      style: outlineButtonStyle,
    );
  }
}