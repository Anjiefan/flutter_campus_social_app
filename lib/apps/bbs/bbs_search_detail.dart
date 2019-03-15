import 'package:finerit_app_flutter/apps/bbs/components/bbs_card.dart';
import 'package:finerit_app_flutter/apps/bbs/state/bbs_state.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';
class BBSSearchApp extends StatefulWidget{
  String value;
  BBSSearchApp({Key key,this.value}):super(key:key);
  @override
  State<StatefulWidget> createState() => BBSSearchAppState(value: value);
}

class BBSSearchAppState extends BBSState<BBSSearchApp>{
  final String state='全国';
  final String filter='及时动态';
  String value;
  String sid;
  BBSSearchAppState({Key key,this.value}):super();
  @override
  Widget get_cart_wighet(int index) {
    // TODO: implement get_cart_wighet
    return BBSCard<SearchStatusModel>(index:index);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    bbsModel=ScopedModel.of<SearchStatusModel>(context,rebuildOnChange: true);
    init_data();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title: Text("搜索微文", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: handle_main_wighet(),
    );
  }
  @override
  Future init_data() {
    // TODO: implement init_status_data
    if(bbsModel.getData()==null||bbsModel.getData().length==0){
      if(bbsModel.initData==false){
        NetUtil.get(Api.BBS_SEARCH, (data) {
          var itemList = BBSItemList.fromJson(data);
          sid=data['sid'];
          if(itemList.data.length!=0){
            bbsModel.setData(itemList.data);
          }
          if(!this.mounted){
            return;
          }
          setState(() {
            bbsModel.initData=true;
          });
          //TODO 界面显示数据
        },
            headers: {"Authorization": "Token ${userAuthModel.session_token}"},
            params: {"query": value,'sid':''});
      }
    }
  }
  @override
  Future refresh_data() {
    // TODO: implement refresh_data
    String sessionToken = userAuthModel.session_token;

    NetUtil.get(Api.BBS_SEARCH, (data) {
      var itemList = BBSItemList.fromJson(data);
      sid=data['sid'];
      bbsModel.setData([]);
      bbsModel.addAll(itemList.data);
      //TODO 界面显示数据
    },
        headers: {"Authorization": "Token $sessionToken"},
        params: {"query": value,'sid':''});
  }
  @override
  Future load_more_data() {
    // TODO: implement load_more_data
    NetUtil.get(Api.BBS_SEARCH, (data) {
      var itemList = BBSItemList.fromJson(data);
      sid=data['sid'];
      bbsModel.addAll(itemList.data);
      //TODO 界面显示数据
    },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        params: {"query": value,'sid':sid});
  }
}