import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/components/hint_wighet.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_frend_card.dart';
import 'package:finerit_app_flutter/apps/profile/profile_search_page.dart';
import 'package:finerit_app_flutter/apps/profile/state/profile_frend_state.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import "package:flutter/material.dart";
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:scoped_model/scoped_model.dart';
class ProfileFrendApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileFrendAppState();
}

class ProfileFrendAppState extends ProfileFrendState<ProfileFrendApp> {
  String type='朋友';
  bool initData=false;
  @override
  Widget get_cart_wighet(int index) {
    return ProfileFrendCard(
      userInfo: frendInfoModel.userInfos[index],
      clickWidget: FlatButton(
        onPressed: (){
          delete_frend();
        },
        child: Text('删除好友',style: TextStyle(color:Colors.black38),)
    )
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
                            ,text: '结交实名认证的好友就可以聊天了～',),
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
                  widgets.add(TopHint(value: '双方均实名认证后可使用通讯系统聊天哦~',icon: Icons.data_usage,));
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
  void delete_frend(){
    showGeneralDialog(
      context: context,
      pageBuilder: (context, a, b) => AlertDialog(
        title: Text("删除好友"),
        content: Text("删除好友将同时取消彼此的关注哦，确定删除吗?"),
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
            },

          ),
        ],
      ),
      barrierDismissible: false,
      barrierLabel: '举报',
      transitionDuration: Duration(milliseconds: 400),
    );

  }
}

class ProfileFollowerApp extends StatefulWidget {
  ProfileFollowerApp({Key key}):super();
  @override
  State<StatefulWidget> createState() => ProfileFollowerAppState();
}

class ProfileFollowerAppState extends ProfileFrendState<ProfileFollowerApp> {
  String type='粉丝';
  bool initData=false;
  FrendNumInfoModel frendNumInfoModel;
  ProfileFollowerAppState({Key key}):super();
  @override
  Widget build(BuildContext context) {

    if(initData==false){
      frendNumInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      frendInfoModel=ScopedModel.of<BaseFrendInfoModel>(context,rebuildOnChange: true);
      init_data();
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title: Text(type, style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileSearchPage(),
              ));
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              child: Text("添加关注",style: TextStyle(color: Colors.black)),
            ),
          )
        ],
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
                            ,text: '你还没有粉丝呢～',),
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
                  widgets.add(TopHint(value: '互相关注即可成为好友哦~',icon: Icons.data_usage,));
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
              follower(index);
            },
            child: Text('关注',style: TextStyle(color:Colors.black38),)
        ),


    );
  }
  void follower(int index){
    NetUtil.put(Api.MAKE_FRIENDS+frendInfoModel.userInfos[index].id+'/', (data) async{
      if(data['info']=='success'){
        requestToast("关注成功");
        frendInfoModel.remove(frendInfoModel.userInfos[index]);
        //更新粉丝、朋友数量
        NetUtil.get(Api.FRENDS_NUM_INFO, (data) {
          frendNumInfoModel.setFrendInfo(data['follower_num'], data['followee_num'], data['frend_num']);
        },
          headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        );
      }
    },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        errorCallBack: (error){
          if(error.containsKey('leancloud_error')&&error['leancloud_error']=="You can't follow yourself."){
            requestToast("无法关注自己");
          }
        }
    );
  }
}

class ProfileFolloweeApp extends StatefulWidget {
  ProfileFolloweeApp({Key key}):super(key:key);
  @override
  State<StatefulWidget> createState() => ProfileFolloweeAppState();
}

class ProfileFolloweeAppState extends ProfileFrendState<ProfileFolloweeApp> {
  String type='关注';
  bool initData=false;
  FrendNumInfoModel frendNumInfoModel;
  BaseFrendInfoModel frendInfoModel;
  ProfileFolloweeAppState({Key key}):super();
  @override
  Widget build(BuildContext context) {
    if(initData==false){
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      frendNumInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      frendInfoModel=ScopedModel.of<BaseFrendInfoModel>(context,rebuildOnChange: true);
      init_data();
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title: Text(type, style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileSearchPage(),
              ));
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              child: Text("添加关注",style: TextStyle(color: Colors.black)),
            ),
          )
        ],
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
                            ,text: '你还没有关注的人呢～',),
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
                  widgets.add(TopHint(value: '互相关注即可成为好友哦~',icon: Icons.data_usage,));
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
              unfollower(index);
            },
            child: Text('取消关注',style: TextStyle(color:Colors.black38),),

        ),
      frendInfoModel: frendInfoModel,
    );
  }
  void unfollower(int index){
    showGeneralDialog(
      context: context,
      pageBuilder: (context, a, b) => AlertDialog(
        title: Text("取消关注"),
        content: Text("确定不再关注此人吗?"),
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
              NetUtil.delete(Api.MAKE_FRIENDS+frendInfoModel.userInfos[index].id+'/', (data) async{
                if(data['info']=='success'){
                  requestToast("取关成功");
                  frendInfoModel.remove(frendInfoModel.userInfos[index]);
                  //更新粉丝、朋友数量
                  NetUtil.get(Api.FRENDS_NUM_INFO, (data) {
                    frendNumInfoModel.setFrendInfo(data['follower_num'], data['followee_num'], data['frend_num']);
                  },
                    headers: {"Authorization": "Token ${userAuthModel.session_token}"},
                  );
                }
              },
                headers: {"Authorization": "Token ${userAuthModel.session_token}"},
              );
              Navigator.pop(context);
            },

          ),
        ],
      ),
      barrierDismissible: false,
      barrierLabel: '取消关注',
      transitionDuration: Duration(milliseconds: 400),
    );

  }

}