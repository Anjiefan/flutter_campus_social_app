import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/commons/digital_conversion.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
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

    Widget wighet= new Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 16.0,right: 16),
        margin: const EdgeInsets.only(bottom: 3),
        alignment: Alignment.center,
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
          child:  Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(bbsDetailItem.user.headImg ?? ''),
                    radius:20,
                  ),
                  padding: EdgeInsets.only(right: 2),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(bbsDetailItem.user.nickName ?? ''),
                      Text("${bbsDetailItem.status.text.length>10?bbsDetailItem.status.text.substring(0,10):bbsDetailItem.status.text}..." ?? '',style: TextStyle(color: Colors.black38),),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(""),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                    child: Row(

                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          child: Image.asset("assets/fire2.png"),
                        ),
                        Container(
                          child: Text(bbsDetailItem.score,style: TextStyle(fontWeight: FontWeight.bold),),
                        )
                      ],
                    )
                ),

              ],
            ),
          ),
        )

    );
    return wighet;
  }

}