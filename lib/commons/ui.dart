
import 'dart:io';

import 'package:finerit_app_flutter/apps/home/home_base.dart';
import 'package:finerit_app_flutter/apps/money/money_base.dart';
import 'package:finerit_app_flutter/apps/money/money_base_web.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void handleAvatar(BuildContext context){
  //TODO event for click the avatar
  //...
  print("handleAvatar");
}
void handle_head_event(BuildContext context)
{
//TODO head img event
  HomeAppState.scaffoldKey.currentState.openDrawer();
}
void handleMoney(BuildContext context,UserAuthModel userAuthModel) {
  //TODO show my money
  //...
  print("handle my money");

  Widget appWidget;
  bool iosPayShow=false;
  if(Platform.isIOS){
    NetUtil.request(
      'http://114.116.46.204:8003/ifshowpayment/',
          (data) {
        if(data["info"]=="false"){
          iosPayShow=false;
        }
        else if(data["info"]=="true"){
          iosPayShow=true;
        }
        appWidget=MoneyAppIOS(iosPayShow: iosPayShow,);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => appWidget,
          ),
        );
      },
      method: "get",
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );

  }else if(Platform.isAndroid){
    appWidget=MoneyApp();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => appWidget,
      ),
    );
  }

}