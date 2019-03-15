import 'package:finerit_app_flutter/apps/profile/profile_friend_detail.dart';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileFrendCard extends StatelessWidget{
  UserAuthModel _userAuthModel;
  BaseFrendInfoModel frendInfoModel;
  ProfileFrendCard({Key key,
    @required this.userInfo,
    @required this.clickWidget,
    this.frendInfoModel
  }):super(key:key);
  User userInfo;
  Widget clickWidget;
  @override
  Widget build(BuildContext context) {
    _userAuthModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    return new Container(
        decoration:BoxDecoration(
          color: Colors.white,
          border: new Border(
            top: BorderSide(
                color: Colors.black12,
                width: 0.5
            ),
          ),
        ),
//        margin: const EdgeInsets.only( bottom:1.0),
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Container(
                height: 80,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child:
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              child: new Container(
                                child: new CircleAvatar(
                                    backgroundImage: new NetworkImage(userInfo.headImg),
                                    radius: 30.0
                                ),
                              ),
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder:
                                        (context) {
                                      if(frendInfoModel!=null){
                                        return ProfileFrendDetailApp(userInfo: userInfo,frendInfoModel: frendInfoModel);
                                      }
                                      else{
                                        return ProfileFrendDetailApp(userInfo: userInfo);
                                      }

                                    }
                                )
                                );

                              },
                            ),

                            new Container(
                              child: FittedBox(
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text("" + userInfo.nickName  , style: new TextStyle(color: FineritColor.color2_normal,fontSize: 20,)),
                                    new Divider(height:5),
                                    new Text( "" +userInfo.schoolName, style: new TextStyle(color: Colors.black54,fontSize: 15,),textAlign:TextAlign.right),
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.only(),
                            ),
                            Expanded(child: Text('')),
                            new Container(
                                width: 90,
                                height: 40,
                                decoration:BoxDecoration(
                                  color: Colors.white,
                                  border: new Border.all(color: Colors.black12),
                                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                                ),
                                alignment: Alignment.centerRight,
                                child: clickWidget
                            )
                          ],
                        )
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(),
              ),
              padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10
              ),
            ),
          ],
        )
    );
  }
  void handle_frend_nav(){}
}