import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileFrendNumWidget extends StatelessWidget{
  ProfileFrendNumWidget({Key key,this.value,this.num}):super(key:key);
  int num;
  String value;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '$num',
          style:
          TextStyle(fontSize: 20, color: FineritColor.color1_normal),
        ),
        Text(
          value,
          style:
          TextStyle(fontSize: 16, color: FineritColor.color1_normal),
        ),
      ],
    );
  }

}