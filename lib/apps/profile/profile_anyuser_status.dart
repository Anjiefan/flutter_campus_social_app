import 'package:finerit_app_flutter/apps/bbs/components/bbs_card.dart';
import 'package:finerit_app_flutter/apps/bbs/state/bbs_state.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/http_error.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';
class ProfileAnyuserStatusApp extends StatefulWidget{
  String userid;
  ProfileAnyuserStatusApp({Key key,this.userid}):super(key:key);
  @override
  State<StatefulWidget> createState() => ProfileAnyuserStatusAPPState(userid: userid);
}

class ProfileAnyuserStatusAPPState extends BBSState<ProfileAnyuserStatusApp>{
  final String state='他人';
  final String filter='及时动态';
  String userid;
  ProfileAnyuserStatusAPPState({
    Key key,
    this.userid
  }):super();
  @override
  Widget get_cart_wighet(int index) {
    // TODO: implement get_cart_wighet
    return BBSCard<BaseBBSModel>(index:index);
  }
  @override
  Widget build(BuildContext context) {
    if(loading==false){
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      bbsModel=ScopedModel.of<BaseBBSModel>(context,rebuildOnChange: true);
    }
    init_data();
    return Scaffold(

      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title: Text("他的动态", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: handle_main_wighet(),
    );
  }
  Future load_more_data(){
    NetUtil.get(Api.BBS_BASE, (data) {
      var itemList = BBSItemList.fromJson(data);
      page=page+1;
      bbsModel.addAll(itemList.data);
    },
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
      params: {"state": state, "filter": filter,'page':page,'userid':userid},
    );
  }
  Future refresh_data(){
    String sessionToken = userAuthModel.session_token;
    NetUtil.get(Api.BBS_BASE, (data) {
      var itemList = BBSItemList.fromJson(data);
      bbsModel.setData([]);
      bbsModel.addAll(itemList.data);
      if(!this.mounted){
        return;
      }
      setState(() {
        page=1;
      });
    },
      headers: {"Authorization": "Token $sessionToken"},
      params: {"state": state, "filter": filter,'page':0,'userid':userid},
    );
  }
  Future init_data() async {
    if(bbsModel.getData()==null||bbsModel.getData().length==0){
      if(bbsModel.initData==false){
        NetUtil.get(Api.BBS_BASE, (data) {
          var itemList = BBSItemList.fromJson(data);
          if(itemList.data.length!=0){
            bbsModel.setData(itemList.data);
          }
          if(!this.mounted){
            return;
          }
          setState(() {
            bbsModel.initData=true;
          });
        },
            headers: {"Authorization": "Token ${userAuthModel.session_token}"},
            params: {"state": state, "filter": filter,'page':0,'userid':userid},
            errorCallBack: (error){
              requestToast(HttpError.getErrorData(error).toString());
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
  @override
  void handle_filter(FilterMenuItem value) {
  }
}