import 'package:finerit_app_flutter/beans/user_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/http_error.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/state/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class ProfileFrendState<T extends StatefulWidget> extends PageState{
  BaseFrendInfoModel frendInfoModel;
  UserAuthModel userAuthModel;
  bool initData=false;
  String type='朋友';
  Widget handle_main_wighet(){
    if(frendInfoModel.userInfos==null||frendInfoModel.userInfos.length==0){
      if(initData==true){
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
                itemCount: 0,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Column(
                      children: <Widget>[
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
              itemCount: frendInfoModel.userInfos.length,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
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
  Future refresh_data(){
    NetUtil.get(Api.MAKE_FRIENDS, (data) {
      UserInfoList itemList = UserInfoList.fromJson(data);
      page=1;
      frendInfoModel.userInfos=itemList.data;
    },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        params: {"type": type,'page':0},
        );
  }
  Future load_more_data(){
    NetUtil.get(Api.MAKE_FRIENDS, (data) {
      UserInfoList itemList = UserInfoList.fromJson(data);
      page=page+1;
      frendInfoModel.addAll(itemList.data);
    },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        params: {"type": type,'page':page},
        );
  }
  Widget get_cart_wighet(int index);
  Future init_data() {
    if(frendInfoModel.userInfos==null||frendInfoModel.userInfos.length==0){
      if(initData==false){
        NetUtil.get(Api.MAKE_FRIENDS, (data) {
          UserInfoList itemList = UserInfoList.fromJson(data);
          if(itemList.data.length!=0){
            frendInfoModel.userInfos=itemList.data;
          }
          if(!this.mounted){
            return;
          }
          setState(() {
            initData=true;
          });
          //TODO 界面显示数据
        },
            headers: {"Authorization": "Token ${userAuthModel.session_token}"},
            params: {"type": type,'page':0},
            errorCallBack: (error){
              requestToast(HttpError.getErrorData(error).toString());
              if(!this.mounted){
                return;
              }
              setState(() {
                initData=true;
              });
            });
      }
    }
  }
  @override
  Widget build(BuildContext context) {

    if(initData==false){
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      frendInfoModel=ScopedModel.of<BaseFrendInfoModel>(context,rebuildOnChange: true);
      init_data();
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title: Text(type=="朋友"?"好友":type, style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body:handle_main_wighet(),
    );
  }
}