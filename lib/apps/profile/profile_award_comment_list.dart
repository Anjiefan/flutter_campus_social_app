import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_award_comment_item_widget.dart';
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

class ProfileAwardCommentApp extends StatefulWidget{
  ProfileAwardCommentApp({Key key}): super (key: key);
  @override
  State<StatefulWidget> createState() => ProfileAwardCommentAppState();
}
class ProfileAwardCommentAppState extends PageState<ProfileAwardCommentApp>{
  UserAuthModel userAuthModel;
  AwardCommentInfoModel awardInfoModel;
  PushMessageModel pushMessageModel;
  String type='昨日评论';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(loading==false){
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      awardInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      pushMessageModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      init_data();
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title:
        Text("昨日神评", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: _get_main_widget(),
    );
  }
  Widget _get_main_widget(){
    if(awardInfoModel.awardComments==null||awardInfoModel.awardComments.length==0&&loading==false){
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
                        ,text: '昨日神评还没有出炉哦～',),
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
            itemCount: awardInfoModel.awardComments.length,
            itemBuilder: (BuildContext context, int index){
              Widget widget=AwardCommentListItem(
                awardData: awardInfoModel.awardComments[index],
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
    if(awardInfoModel.awardCommentStr==null||!TimeUtil.RankingDay(awardInfoModel.awardCommentStr)){
      NetUtil.get(Api.AWARD_INFO, (data) {
        var itemList = AwardList.fromJson(data);

        loading=true;
        pushMessageModel.profileYesterdayCommentCount = 0;
        if(itemList.data.length!=0){
          awardInfoModel.awardCommentStr=itemList.data[0].awardTime;
          awardInfoModel.awardComments=itemList.data;
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
        awardInfoModel.addAllCommentAward(itemList.data);
      }
    },
      params: {'page':page,'type':type},
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
  }

  @override
  Future refresh_data() {
    // TODO: implement refresh_data
    if(awardInfoModel.awardCommentStr==null||!TimeUtil.RankingDay(awardInfoModel.awardCommentStr)){
      NetUtil.get(Api.AWARD_INFO, (data) {
        var itemList = AwardList.fromJson(data);
        if(itemList.data.length!=0){
          awardInfoModel.awardComments=itemList.data;
        }
      },
        params: {'page':0,'type':type},
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
      );
    }
  }

}