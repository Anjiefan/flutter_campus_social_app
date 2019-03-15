

import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hint extends StatelessWidget{
  String value;
  IconData icon;
  Hint({
    key
    ,@required this.value
    ,@required this.icon
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
                height: 40,
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Row(

              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  child: new Container(
                    padding:EdgeInsets.only(),
                    child: new Row(
                      children: <Widget>[
                        new Icon(this.icon, size: 20.0, color: GlobalConfig.font_color),
                        new Text(this.value,style: TextStyle(color: GlobalConfig.font_color)),
                      ],
                    ),
                  ),
                ),
              ],

            ),
          ),
//          Icon(Icons.chevron_left,color: GlobalConfig.font_color,),

        ],

      ),
    );
  }

}

class TopHint extends StatelessWidget{
  String value;
  IconData icon;
  TopHint({
    key
    ,@required this.value
    ,@required this.icon
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.only(left: 5),
//      margin: EdgeInsets.only(top: 10),
      height: 30,
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Row(

              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  child: new Container(
                    padding:EdgeInsets.only(),
                    child: new Row(
                      children: <Widget>[
                        new Icon(this.icon, size: 20.0, color: Colors.black),
                        new Text(this.value,style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ],

            ),
          ),

        ],

      ),
    );
  }
}