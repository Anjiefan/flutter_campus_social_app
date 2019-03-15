import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/components/image_grid_view.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconText extends StatelessWidget{
  IconData icon;
  String text;
  IconText({
    key
    ,@required this.icon
    ,@required this.text
  }):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      child: new Row(
        children: <Widget>[
          new Expanded(
              child:
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    width: 100,
                    child:new FlatButton(
                      onPressed: (){ print("icon");},
                      padding:EdgeInsets.only(),
                      child:
                      new Row(
                        children: <Widget>[
                          new Icon(icon, size: 10.0, color: FineritColor.color1_normal),
                          new Text(text,style: TextStyle(color: FineritColor.color1_normal,fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
      padding: const EdgeInsets.only(),
    );
  }

}