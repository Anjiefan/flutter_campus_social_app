import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_award_comment_item_widget.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_award_status_item_widget.dart';
import 'package:finerit_app_flutter/beans/award_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/state/page_state.dart';
import "package:flutter/material.dart";
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileAnyUserAwardApp extends StatefulWidget{
  String userid;
  ProfileAnyUserAwardApp({Key key,this.userid}): super (key: key);
  @override
  State<StatefulWidget> createState() => ProfileAnyUserAwardAppState(userid: userid);
}
class ProfileAnyUserAwardAppState extends PageState<ProfileAnyUserAwardApp>{
  UserAuthModel userAuthModel;
  AwardInfoModel awardInfoModel;
  String userid;
  String type='他人';
  ProfileAnyUserAwardAppState({Key key,this.userid}): super();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(loading==false){
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      awardInfoModel=ScopedModel.of<AwardInfoModel>(context,rebuildOnChange: true);
      init_data();
    }
    return Scaffold(
      
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title:
        Text("获奖历程", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: _get_main_widget(),
    );
  }
  Widget _get_main_widget(){
    if(awardInfoModel.awards==null||awardInfoModel.awards.length==0){
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
                        ,text: '他还没有获奖经历呢～',),
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
            itemCount: awardInfoModel.awards.length,
            itemBuilder: (BuildContext context, int index){
              Widget widget=awardInfoModel.awards[index].comment==null?AwardStatusListItem(
                awardData: awardInfoModel.awards[index],
              ):AwardCommentListItem(
                awardData: awardInfoModel.awards[index],
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
    NetUtil.get(Api.AWARD_INFO, (data) {
      var itemList = AwardList.fromJson(data);
      if(!this.mounted){
        return;
      }
      setState(() {
        loading=true;
      });
      if(itemList.data.length!=0){
        awardInfoModel.awards=itemList.data;
      }
    },
      params: {'page':0,'type':type,'userid':userid},
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
  }

  @override
  Future load_more_data() {
    NetUtil.get(Api.AWARD_INFO, (data) {
      var itemList = AwardList.fromJson(data);
      if(itemList.data.length!=0){
        page=page+1;
        awardInfoModel.addAllAward(itemList.data);
      }
    },
      params: {'page':page,'type':type,'userid':userid},
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
  }

  @override
  Future refresh_data() {
    // TODO: implement refresh_data
    NetUtil.get(Api.AWARD_INFO, (data) {
      var itemList = AwardList.fromJson(data);
      if(itemList.data.length!=0){
        awardInfoModel.awards=itemList.data;
      }
    },
      params: {'page':0,'type':type,'userid':userid},
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
  }

}