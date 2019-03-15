import 'package:finerit_app_flutter/apps/profile/profile_friend_detail.dart';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';

class UserHead extends StatelessWidget{
  UserHead({Key key,this.username,this.sincePosted,this.headImg,this.userInfo}):super(key:key);
  String username;
  String sincePosted;
  String headImg;
  User userInfo;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Expanded(
        child:
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfileFrendDetailApp(userInfo: userInfo,),
                ));
              },
              child: new Container(
                child: new CircleAvatar(
                    backgroundImage: new NetworkImage(headImg),
                    radius: 20.0
                ),
              ),
            ),
            new Container(
              child:
              new FittedBox(
                child: new Column(
                    children: <Widget>[
                      new Text("  " + username  , style: new TextStyle(color: FineritColor.color2_normal)),
                      new Divider(height:5),
                      new Text( "  " +sincePosted, style: new TextStyle(color: Colors.black54,fontSize: 10,),textAlign:TextAlign.right),

                    ],
                    crossAxisAlignment:CrossAxisAlignment.start
                ),
              ),
              padding: EdgeInsets.only(),
            ),

          ],
        )
    );
  }
}