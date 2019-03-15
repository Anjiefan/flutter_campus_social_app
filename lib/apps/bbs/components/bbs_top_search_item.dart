import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BBSTopSearchWidget extends StatelessWidget{
  BBSTopSearchWidget({Key key,
  @required this.index,
  @required this.bbsDetailItem}):super(key:key);
  int index;
  BBSDetailItem bbsDetailItem;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    StatusTopModel statusTopModel=ScopedModel.of<BaseBBSModel>(context,rebuildOnChange: true);
    return new Container(
        margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
        alignment: Alignment.topLeft,
        child:  GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>
                    ScopedModel<BaseBBSModel>(
                      model: statusTopModel,
                      child: ReplyPage(bbsDetailItem: bbsDetailItem,index:index),
                    )

            ));
          },
          child:  new Chip(
            label: new Text('@${bbsDetailItem.user.nickName}',style: new TextStyle(color: GlobalConfig.font_color)),
            backgroundColor: GlobalConfig.dark == true ? Colors.white10 : Colors.black12,
          ),
        )

    );
  }

}