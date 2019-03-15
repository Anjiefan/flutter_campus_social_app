import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_frend_card.dart';
import 'package:finerit_app_flutter/apps/profile/state/profile_frend_state.dart';
import 'package:finerit_app_flutter/beans/user_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/http_error.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
class ProfileDisLikeUserApp extends StatefulWidget {
  ProfileDisLikeUserApp({Key key}):super();
  @override
  State<StatefulWidget> createState() => ProfileDisLikeUserAppState();
}
class ProfileDisLikeUserAppState extends ProfileFrendState<ProfileDisLikeUserApp> {
  bool initData=false;
  ProfileDisLikeUserAppState({Key key}):super();
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
        title: Text('黑名单', style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body:handle_main_wighet(),
    );
  }
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
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Column(
                      children: <Widget>[
                        Container(
                          child: Blank(width: MediaQuery.of(context).size.width
                            ,height: MediaQuery.of(context).size.height
                            ,text: '您还没有拉黑的用户哦',),
                        )
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
                List<Widget> widgets=[];
                if(index==0){
                  widgets.add(get_cart_wighet(index));
                }
                else{
                  widgets.add(get_cart_wighet(index));
                }
                return new Container(
                  child: new Column(
                    children: widgets,
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
  @override
  Widget get_cart_wighet(int index) {
    return ProfileFrendCard(userInfo: frendInfoModel.userInfos[index],
      clickWidget: FlatButton(
          onPressed: (){
            remove_deslike(index);
          },
          child: Text('移除',style: TextStyle(color:Colors.black38),)
      ),
    );
  }
  void remove_deslike(int index){
    showGeneralDialog(
      context: context,
      pageBuilder: (context, a, b) => AlertDialog(
        title: Text("提示"),
        content: Text("移除黑名单后，他的微文和信息您将重新可见。"),
        actions: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('确定'),
            onPressed: () {
              Navigator.pop(context);
              NetUtil.delete(Api.DISLIKE_USER+frendInfoModel.userInfos[index].id+'/', (data) async{
                if(data['info']=='success'){
                  requestToast("移除黑名单成功");
                  frendInfoModel.remove(frendInfoModel.userInfos[index]);
                  //更新粉丝、朋友数量
                }
              },
                  headers: {"Authorization": "Token ${userAuthModel.session_token}"},
              );
            },
          ),
        ],
      ),
      barrierDismissible: false,
      barrierLabel: '移除黑名单',
      transitionDuration: Duration(milliseconds: 400),
    );
  }
  Future refresh_data(){
    NetUtil.get(Api.DISLIKE_USER, (data) {
      UserInfoList itemList = UserInfoList.fromJson(data);
      page=1;
      frendInfoModel.userInfos=itemList.data;
    },
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
      params: {'page':0},
    );
  }
  Future load_more_data(){
    NetUtil.get(Api.DISLIKE_USER, (data) {
      UserInfoList itemList = UserInfoList.fromJson(data);
      page=page+1;
      frendInfoModel.addAll(itemList.data);
    },
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
      params: {'page':page},
    );
  }
  Future init_data() {
    if(frendInfoModel.userInfos==null||frendInfoModel.userInfos.length==0){
      if(initData==false){
        NetUtil.get(Api.DISLIKE_USER, (data) {
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
}