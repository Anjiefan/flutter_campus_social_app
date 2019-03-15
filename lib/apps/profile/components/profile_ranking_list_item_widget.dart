import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/beans/ranking_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RankingListItem extends StatelessWidget{
  RankingListItem({Key key,
    @required this.index,
    @required this.rankingData}):super(key:key);
  int index;
  RankingData rankingData;
  UserAuthModel userAuthModel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    return new Container(
      color: Colors.white,
//        padding: EdgeInsets.only(left: 8.0),
        margin: const EdgeInsets.only(top: 3),
        alignment: Alignment.topLeft,
        child:  GestureDetector(
          onTap: (){
            handle_status_detail_page(context);
          },
          child:
          new Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(5),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new CircleAvatar(
                          child: Text('${index+1}',style: TextStyle(fontSize: 20),),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black),

                    ],
                  ),
                  padding: EdgeInsets.only(right: 2),
                ),
                Container(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(rankingData.user.headImg ?? ''),
                    radius:20,
                  ),
                  padding: EdgeInsets.only(right: 15),
                ),
                Container(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(rankingData.user.nickName ?? ''),
                      Text("${rankingData.status.text.substring(0,13)}..." ?? '',style: TextStyle(color: Colors.black38),),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Icon(MyFlutterApp.money),
                      Text('${double.parse(rankingData.rankingMoney).toStringAsPrecision(4)}')
                    ],
                  ),
                )
              ],
            ),
          ),
        )

    );
  }
  void handle_status_detail_page(BuildContext context){
    NetUtil.get(Api.BBS_BASE+rankingData.status.objectId+'/', (data) async{
      BBSDetailItem bbsDetailItem = BBSDetailItem.fromJson(data);
      RankingStatusModel rankingStatusModel=RankingStatusModel();
      rankingStatusModel.setData([bbsDetailItem]);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>
              ScopedModel<BaseBBSModel>(
                model: rankingStatusModel,
                child: ReplyPage(bbsDetailItem: bbsDetailItem,index:rankingStatusModel.getData().length-1),
              )
      ));
    },
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
    }

}