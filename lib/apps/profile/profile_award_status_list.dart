import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/components/hint_wighet.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_award_comment_item_widget.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_award_status_item_widget.dart';
import 'package:finerit_app_flutter/beans/award_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/time_utils.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/state/page_state.dart';
import "package:flutter/material.dart";
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileAwardStatusApp extends StatefulWidget{
  ProfileAwardStatusApp({Key key}): super (key: key);
  @override
  State<StatefulWidget> createState() => ProfileAwardStatusAppState();
}
class ProfileAwardStatusAppState extends PageState<ProfileAwardStatusApp>{
  UserAuthModel userAuthModel;
  AwardStatusInfoModel awardInfoModel;
  String type='昨日微文';
  PushMessageModel pushMessageModel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(loading==false){
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      awardInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      pushMessageModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      init_data();
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title:
        Text("昨日榜单", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: _get_main_widget(),
          ),
          new Positioned(
            top: 0,
            left:0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: TopHint(value: '为每日最火爆的前2%的微文发放奖励~',icon: Icons.data_usage,),
            ),
          ),
        ],
      )

    );
  }
  Widget _get_main_widget(){
    if(awardInfoModel.awardStatuss==null||awardInfoModel.awardStatuss.length==0){
      if(loading==false){
        return SpinKitFadingCircle(color: Color.fromARGB(50, 0, 0, 0),size: 30,);
      }
      else{
        return new EasyRefresh(
          autoLoad: false,
          key: easyRefreshKey,
          refreshHeader: MaterialHeader(
            key: headerKey,
          ),
          refreshFooter: MaterialFooter(
            key: footerKey,
          ),
          child: new ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index){
                return new Column(
                  children: [
                    Container(
                      child: Blank(width: MediaQuery.of(context).size.width
                        ,height: MediaQuery.of(context).size.height
                        ,text: '昨日榜单还没有出炉哦～',),
                    )
                  ],
                );
              }
          ),
          onRefresh: () async {
            refresh_data();
          },
          loadMore: () async {
            load_more_data();
          },
        );
      }
    }
    else{
      return new EasyRefresh(
        autoLoad: false,
        key: easyRefreshKey,
        refreshHeader: MaterialHeader(
          key: headerKey,
        ),
        refreshFooter: MaterialFooter(
          key: footerKey,
        ),
        child: new ListView.builder(
            itemCount: awardInfoModel.awardStatuss.length,
            itemBuilder: (BuildContext context, int index){
              Widget widget=AwardStatusListItem(
                awardData: awardInfoModel.awardStatuss[index],type: 0,
              );
              return new Column(
                children: [
                  widget
                ],
              );
            }
        ),
        onRefresh: () async {
          refresh_data();
        },
        loadMore: () async {
          load_more_data();
        },
      );
    }

  }
  @override
  Future init_data() {
    // TODO: implement init_data
    if(awardInfoModel.awardStatusStr==null||!TimeUtil.RankingDay(awardInfoModel.awardStatusStr)){
      NetUtil.get(Api.AWARD_INFO, (data) {
        var itemList = AwardList.fromJson(data);
        loading=true;
        pushMessageModel.profileYesterdayRankingCount = 0;
        if(itemList.data.length!=0){
          awardInfoModel.awardStatusStr=itemList.data[0].awardTime;
          awardInfoModel.awardStatuss=itemList.data;
        }
      },
        params: {'page':0,'type':type},
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
      );
    }

  }

  @override
  Future load_more_data() {
    NetUtil.get(Api.AWARD_INFO, (data) {
      var itemList = AwardList.fromJson(data);
      if(itemList.data.length!=0){
        page=page+1;
        awardInfoModel.addAllStatusAward(itemList.data);
      }
    },
      params: {'page':page,'type':type},
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
  }

  @override
  Future refresh_data() {
    // TODO: implement refresh_data
    if(awardInfoModel.awardStatusStr==null||!TimeUtil.RankingDay(awardInfoModel.awardStatusStr)){
      NetUtil.get(Api.AWARD_INFO, (data) {
        var itemList = AwardList.fromJson(data);
        if(itemList.data.length!=0){
          awardInfoModel.awardStatuss=itemList.data;
        }
      },
        params: {'page':0,'type':type},
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
      );
    }
  }

}