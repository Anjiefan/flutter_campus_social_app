import 'package:finerit_app_flutter/apps/bbs/bbs_base.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/apps/components/asset.dart';
import 'package:finerit_app_flutter/apps/components/common_drawer.dart';
import 'package:finerit_app_flutter/apps/contact/contact_base.dart';
import 'package:finerit_app_flutter/apps/course/course_base.dart';
import 'package:finerit_app_flutter/apps/message/message_base.dart';
import 'package:finerit_app_flutter/apps/profile/profile_base.dart';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/icons/icons_route4.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeApp extends StatefulWidget {
  static const routeName = "/home";

  @override
  State<StatefulWidget> createState() => HomeAppState();
}

class HomeAppState extends State<HomeApp> with SingleTickerProviderStateMixin {
  var _textController = new TextEditingController();
  bool loading = false;
  MainStateModel model;
  static const CHANNEL_PUSH_CONFIRM =
      const EventChannel("com.finerit.campus/push/confirm");

  static const CHANNEL_PUSH_REGISTER =
      const MethodChannel("com.finerit.campus/push/register");

  static const CHANNEL_PUSH_INITIALIZE =
      const MethodChannel("com.finerit.campus/push/initialize");
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 2;

  BBSRecommendModel bbsRecommendModel;
  BBSCountryModel bbsCountryModel;
  BBSNeighborhoodModel bbsNeighborhoodModel;
  BBSSchoolModel bbsSchoolModel;
  BBSFriendModel bbsFriendModel;
  List _bodyOptions;

  @override
  void initState() {
    super.initState();
    bbsRecommendModel = BBSRecommendModel();
    bbsCountryModel = BBSCountryModel();
    bbsNeighborhoodModel = BBSNeighborhoodModel();
    bbsSchoolModel = BBSSchoolModel();
    bbsFriendModel = BBSFriendModel();
    _bodyOptions = [
      CourseApp(),
      ContactApp(),
      BBSApp(
        bbsCountryModel: bbsCountryModel,
        bbsFriendModel: bbsFriendModel,
        bbsNeighborhoodModel: bbsNeighborhoodModel,
        bbsRecommendModel: bbsRecommendModel,
        bbsSchoolModel: bbsSchoolModel,
      ),
      MessageApp(),
      ProfileApp(),
    ];
    CHANNEL_PUSH_CONFIRM
        .receiveBroadcastStream()
        .listen(_onPushEvent, onError: _onError);
    //加载用户信息
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_textController != null) {
      _textController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {

//    init_invitation(context);
    if (loading == false) {
      model = ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
      loadUserInfo();
      model.initCount();
      init_invitation(context);
      loading = true;
    }
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: _bodyOptions.elementAt(_selectedIndex),
      ),
      drawer: new Drawer(
          child: CommonDrawer(
              headImg: model.userInfo != null ? model.userInfo.headImg : "",
              nickName: model.userInfo != null ? model.userInfo.nickName : "")
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
            primaryColor: FineritColor.color1_pressed,
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: new TextStyle(color: FineritColor.color1_normal))),
        child: BottomNavigationBar(
          iconSize: 30,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(MyFlutterApp4.playnext,size: 25,), title: Text('代课')),
            BottomNavigationBarItem(
                icon: Icon(MyFlutterApp4.addressbook,size: 25,), title: Text('通讯录')),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp4.house,size: 25,),
              title: Text("校园圈"),
            ),
            BottomNavigationBarItem(
                icon: Stack(
                  children: <Widget>[
                    Icon(
                      MyFlutterApp4.message,size: 25,
                    ),
                    Positioned(
                      // draw a red marble
                      top: 4.0,
                      right: 0.0,
                      child: (model.messageCommentCount +
                                  model.messageLikeCount) ==
                              0
                          ? Container()
                          : Container(
                              child: Center(
                                  child: Text(
                                (model.messageCommentCount +
                                            model.messageLikeCount) >
                                        99
                                    ? "..."
                                    : (model.messageCommentCount +
                                            model.messageLikeCount)
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              width: 14,
                              height: 14,
                            ),
                    )
                  ],
                ),
                title: Text('消息')),
            BottomNavigationBarItem(
                icon: Stack(
                  children: <Widget>[
                    Icon(MyFlutterApp4.mine,size: 25,),
                    Positioned(  // draw a red marble
                      top: 4.0,
                      right: 0.0,
                      child:
                      (model.profileTaskCount + model.profileAwardHistoryCount + model.profileYesterdayCommentCount + model.profileYesterdayRankingCount) == 0?Container():
                      Container(
                        child: Center(child: Text((model.profileTaskCount + model.profileAwardHistoryCount + model.profileYesterdayCommentCount + model.profileYesterdayRankingCount) > 99?"..." :
                        (model.profileTaskCount + model.profileAwardHistoryCount + model.profileYesterdayCommentCount + model.profileYesterdayRankingCount).toString(), style: TextStyle(color: Colors.white, fontSize: 10),)),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        width: 14,
                        height: 14,
                      ),
                    )
                  ],
                ),
                title: Text('我')),
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Future _onItemTapped(int index) async {
    if(!this.mounted){
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  _onError(Object error) {}

  _onRegisterError(Object error) {}

  //TODO 处理收到的推送消息
  Future _onPushEvent(Object event) async {
    String type = (event as List)[0];
    String title = (event as List)[1];
    String content = (event as List)[2];
    String createTime = (event as List)[3];
    String action = (event as List)[4];
    String sender = (event as List)[5];
    print("_onPushEvent");
    print("type: $type,"
        "title: $title,"
        "content: $content,"
        "createTime: $createTime,"
        "action: $action,"
        "sender: $sender");
    switch (type) {
      case "message_like_me":
        //喜欢我的推送
        model.messageLikeCount = model.messageLikeCount + 1;
        break;
      case "message_comment_me":
        //评论我的推送
        model.messageCommentCount = model.messageCommentCount + 1;
        break;
      case "profile_yesterday_comment":
        //昨日神评推送
        model.profileYesterdayCommentCount =
            model.profileYesterdayCommentCount + 1;
        break;
      case "profile_yesterday_ranking":
        //昨日榜单推送
        model.profileYesterdayRankingCount =
            model.profileYesterdayRankingCount + 1;
        break;
      case "profile_comment_money":
        //获得神评奖励->获奖历程推送
        model.profileAwardHistoryCount = model.profileAwardHistoryCount + 1;
        break;
      case "profile_ranking_money":
        //获得排行榜名次奖励->获奖历程推送
        model.profileAwardHistoryCount = model.profileAwardHistoryCount + 1;
        break;
      case "task":
        //新手任务完成->新手任务推送
        model.profileTaskCount = model.profileTaskCount + 1;
        break;
      case 'profile_verify_success':
        NetUtil.get(Api.USER_INFO+model.objectId+'/', (data) {
          User userInfo = User.fromJson(data);
          model.userInfo=userInfo;
        }, headers: {"Authorization": "Token ${model.session_token}"});
        break;
    }
  }

  Future loadUserInfo() async {
//    String sessionToken = await SharedPreferenceUtil.getSessionToken();
//    String objectId = await SharedPreferenceUtil.getObjectId();
//    NetUtil.get(Api.USER_INFO + "$objectId/", (data) {
//      SharedPreferenceUtil.setNickName(data["nick_name"]);
//      SharedPreferenceUtil.setHeadImg(data["head_img"]);
//      SharedPreferenceUtil.setUserInfo(User.fromJson(data));
//      print("userInfoLoaded");
//
//    }, headers: {"Authorization": "Token $sessionToken"});
    CHANNEL_PUSH_INITIALIZE.invokeMethod("initializeLCPush");
    CHANNEL_PUSH_REGISTER.setMethodCallHandler((handler) {
      if (handler.method == "updateInstallationId") {
        String installationId = handler.arguments as String;
        NetUtil.post(Api.UPDATE_USER_INSTALLATION_ID, (data) {
          print("UPDATE_USER_INSTALLATION_ID: $installationId");
        },
            params: {'installation_id': installationId},
            headers: {"Authorization": "Token ${model.session_token}"});
      }
    });
  }

  void init_invitation(var context) {
    NetUtil.get(
      Api.INVITATION,
      (data) {

        if (data['info'] == '首次登录') {
//          showGeneralDialog(
//            context: context,
//            pageBuilder: (context, a, b) => AlertDialog(
//              title: Text('提示'),
//              content: Container(
//                width: MediaQuery.of(context).size.width * 0.8,
//                height: (MediaQuery.of(context).size.height / 2) * 0.3,
//                child: Column(
//                  children: <Widget>[
//                    Text("使用邀请码将使您获得2凡尔币，邀请人获得1凡尔币~"),
//                    SizedBox(height: 20,),
//                    new Theme(
//                      data: ThemeData(
//                        hintColor: Colors.black26,
//                      ),
//                      child:
//                      new Container(
//                        decoration: new BoxDecoration(
//                          border: new Border.all(width: 2.0, color: Colors.black54),
//                          color: Colors.white,
//                          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
//                        ),
//                        height: 30,
//                        width: MediaQuery.of(context).size.width*1,
//                        child:TextField(
//                          controller: _textController,
//                          autofocus: true,
//                          decoration: new InputDecoration.collapsed(
//                            hintText: '输入邀请码...',
//                          ),
//                          cursorColor:Colors.black26,
//                          style:TextStyle(color: Colors.black54),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              actions: <Widget>[
//                FlatButton(
//                  child: Text('取消'),
//                  onPressed: () {
//
//                    NetUtil.get(Api.INVITATION, (data) {
//                      requestToast(data['info']);
//                    }, headers: {
//                      "Authorization": "Token ${model.session_token}"
//                    }, params: {
//                      'invitationid': 'dont_use'
//                    });
//                    Navigator.pop(context);
//                  },
//                ),
//                FlatButton(
//                  child: Text('确认'),
//                  onPressed: () async {
//
//                    if (_textController.text == '') {
//                      requestToast('请输入邀请码');
//                      Navigator.pop(context);
//                      return;
//                    }
//                    NetUtil.get(Api.INVITATION, (data) {
//                      requestToast(data['info']);
//
//                    }, headers: {
//                      "Authorization": "Token ${model.session_token}"
//                    }, params: {
//                      'invitationid': '${_textController.text}'
//                    });
//                    Navigator.pop(context);
//
//                  },
//                ),
//              ],
//            ),
//            barrierDismissible: false,
//            barrierLabel: '邀请码',
//            transitionDuration: Duration(milliseconds: 400),
//          );
          showGeneralDialog(
            context: context,
            pageBuilder: (context, a, b) => AlertDialog(
              title: Text('提示'),
              content:
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: (MediaQuery.of(context).size.height / 2) * 0.3,
                child: Column(
                  children: <Widget>[
                    Text("使用邀请码将使您获得2凡尔币，邀请人获得1凡尔币~"),
                    SizedBox(height: 20,),
                    new Theme(
                      data: ThemeData(
                        hintColor: Colors.black26,
                      ),
                      child:
                      new Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width*1,
                        child:TextField(
                          controller: _textController,
                          autofocus: true,
                          cursorColor:Colors.black26,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            hintText: "输入邀请码...",
                            errorBorder:UnderlineInputBorder(
                              borderSide:
                              BorderSide( width: 0.5,color: Colors.black26),

                            ),
                            disabledBorder:UnderlineInputBorder(
                              borderSide:
                              BorderSide( width: 0.5,color: Colors.black26),

                            ),
                            enabledBorder:UnderlineInputBorder(
                              borderSide:
                              BorderSide( width: 0.5,color: Colors.black26),

                            ),
                            focusedBorder:UnderlineInputBorder(
                              borderSide:
                              BorderSide( width: 0.8,color: Colors.black26),

                            ),
                            border:UnderlineInputBorder(
                              borderSide:
                              BorderSide(width: 0.5,color: Colors.black26),

                            ),
                          ),
                          style:TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('取消'),
                  onPressed: () {

                    NetUtil.get(Api.INVITATION, (data) {
                      requestToast(data['info']);
                    }, headers: {
                      "Authorization": "Token ${model.session_token}"
                    }, params: {
                      'invitationid': 'dont_use'
                    });
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('确认'),
                  onPressed: () async {

                    if (_textController.text == '') {
                      requestToast('请输入邀请码');
                      Navigator.pop(context);
                      return;
                    }
                    NetUtil.get(Api.INVITATION, (data) {
                      requestToast(data['info']);

                    }, headers: {
                      "Authorization": "Token ${model.session_token}"
                    }, params: {
                      'invitationid': '${_textController.text}'
                    });
                    Navigator.pop(context);

                  },
                ),
              ],
            ),
            barrierDismissible: false,
            barrierLabel: '邀请码',
            transitionDuration: Duration(milliseconds: 400),
          );
//          showDialog(
//              context: context,
//              builder: (context) {
//                return StatefulBuilder(builder: (context, state) {
//                  return new FinerAssetGiffyDialog(
//                    title: Text(
//                      '使用邀请码',
//                      textAlign: TextAlign.center,
//                      style:
//                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
//                    ),
//                    description: Container(
//                      child: Column(
//                        children: <Widget>[
//                          Text("使用邀请码将使您获得2凡尔币，邀请人获得1凡尔币~"),
//                          TextField(
//                            controller: _textController,
//                            maxLines: 1,
//                            autofocus: true,
//                            cursorColor: FineritColor.color2_normal,
//                            decoration: InputDecoration(
//                              contentPadding: EdgeInsets.all(10.0),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    buttonOkText: Text('确定'),
//                    buttonCancelText: Text('取消'),
//                    onCancelButtonPressed: () async {
//                      NetUtil.get(Api.INVITATION, (data) {
//                        Navigator.pop(context);
//                        requestToast(data['info']);
//                      }, headers: {
//                        "Authorization": "Token ${model.session_token}"
//                      }, params: {
//                        'invitationid': 'dont_use'
//                      });
//                    },
//                    onOkButtonPressed: () async {
//                      if (_textController.text == '') {
//                        requestToast('请输入邀请码');
//                        return;
//                      }
//                      NetUtil.get(Api.INVITATION, (data) {
//                        requestToast(data['info']);
//                        Navigator.pop(context);
//                      }, headers: {
//                        "Authorization": "Token ${model.session_token}"
//                      }, params: {
//                        'invitationid': '${_textController.text}'
//                      });
//                    },
//                  );
//                });
//              });
        }
      },
      headers: {"Authorization": "Token ${model.session_token}"},
    );
  }
}
