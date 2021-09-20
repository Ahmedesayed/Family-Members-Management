import 'package:flutter/material.dart';
import 'package:fmm/models/colors.dart';

class FloatingActionBtn extends StatelessWidget {
  const FloatingActionBtn({Key key, this.onPress,this.icon}) : super(key: key);

  final Function onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(0, 0.95),
        child: Container(
            constraints: BoxConstraints(maxHeight: 120, maxWidth: 120),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color.fromRGBO(225, 244, 235, 1)),
            child: RawMaterialButton(
              elevation: 2.0,
              shape: CircleBorder(),
              fillColor: CustomColors.primaryColor,
              onPressed: onPress,
              child: Icon(
                icon,
                color: Colors.white,
                size: 40.0,
              ),
              constraints: BoxConstraints.tightFor(
                width: 65.0,
                height: 65.0,
              ),
            )),
      );;
  }
}