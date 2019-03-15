import 'package:finerit_app_flutter/apps/bbs/components/bbs_card.dart';
import 'package:finerit_app_flutter/apps/bbs/state/bbs_state.dart';
import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_like_status_card.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import "package:flutter/material.dart";
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
class ProfileLikeStatusApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => ProfileLikeStatusState();
}

class ProfileLikeStatusState extends BBSState<ProfileLikeStatusApp>{
  Widget get_cart_wighet(int index){
    return ProfileLikeBBSCard<BaseBBSModel>(index:index);
  }
  @override
  void handle_filter(FilterMenuItem value) {
  }
  @override
  Widget build(BuildContext context) {
    if(loading==false){
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      bbsModel=ScopedModel.of<BaseBBSModel>(context,rebuildOnChange: true);
      init_status_data();
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title: Text("喜欢", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: handle_main_wighet(),
    );
  }
  Widget handle_main_wighet(){
    if(bbsModel.getData()==null||bbsModel.getData().length==0){
      if(loading==true){
        return Container(
          child: new EasyRefresh(
            autoLoad: true,
            key: easyRefreshKey,
            refreshHeader: MaterialHeader(
              key: headerKey,
            ),
            refreshFooter: MaterialFooter(
              key: footerKey,
            ),
            child: new ListView.builder(
              //ListView的Item
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Column(
                      children: <Widget>[
                        Blank(width: MediaQuery.of(context).size.width
                          ,height: MediaQuery.of(context).size.height
                          ,text: '还没有让你心动的微文哦～',)
                      ],
                    ),
                  );
                }),
            onRefresh: () async {
              refresh_data();
            },
            loadMore: () async {
              load_more_data();
            },
          ),
        );
      }
      else{
        return SpinKitFadingCircle(color: Color.fromARGB(50, 0, 0, 0),size: 30,);
      }
    }
    else{
      return Container(
        child: new EasyRefresh(
          autoLoad: true,
          key: easyRefreshKey,
          refreshHeader: MaterialHeader(
            key: headerKey,
          ),
          refreshFooter: MaterialFooter(
            key: footerKey,
          ),
          child: new ListView.builder(
            //ListView的Item
              itemCount: bbsModel.getData().length,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Column(
                    children: <Widget>[
                      get_cart_wighet(index)
                    ],
                  ),
                );
              }),
          onRefresh: () async {
            refresh_data();
          },
          loadMore: () async {
            load_more_data();
          },
        ),
      );
    }
  }
  Future load_more_data(){
    NetUtil.get(Api.BBS_LIKE_STATUS, (data) {
      var itemList = BBSItemList.fromJson(data);
      page=page+1;
      bbsModel.addAll(itemList.data);
      //TODO 界面显示数据
    },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        params: {'page':page},
        );
  }
  Future refresh_data(){
    String sessionToken = userAuthModel.session_token;
    NetUtil.get(Api.BBS_LIKE_STATUS, (data) {
      var itemList = BBSItemList.fromJson(data);
      bbsModel.setData([]);
      bbsModel.addAll(itemList.data);
      if(!this.mounted){
        return;
      }
      setState(() {
        page=1;
      });
      //TODO 界面显示数据
    },
        headers: {"Authorization": "Token $sessionToken"},
        params: {'page':0},
        );
  }
  Future init_status_data() async {
    if(bbsModel.getData()==null||bbsModel.getData().length==0){
      if(bbsModel.initData==false){
        NetUtil.get(Api.BBS_LIKE_STATUS, (data) {
          var itemList = BBSItemList.fromJson(data);
          if(itemList.data.length!=0){
            bbsModel.setData(itemList.data);
          }
          if(!this.mounted){
            return;
          }
          setState(() {
            loading=true;
            bbsModel.initData=true;
          });
          //TODO 界面显示数据
        },
            headers: {"Authorization": "Token ${userAuthModel.session_token}"},
            params: {'page':0},
            errorCallBack: (error){
              if(!this.mounted){
                return;
              }
              setState(() {
                bbsModel.initData=true;
              });
            });
      }
    }
  }
}