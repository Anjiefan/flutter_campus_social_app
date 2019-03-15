import 'dart:io';

import 'package:finerit_app_flutter/apps/money/money_base.dart';
import 'package:finerit_app_flutter/apps/money/money_base_web.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_frendnum_widget.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/apps/profile/profile_award_comment_list.dart';
import 'package:finerit_app_flutter/apps/profile/profile_award_list.dart';
import 'package:finerit_app_flutter/apps/profile/profile_award_status_list.dart';
import 'package:finerit_app_flutter/apps/profile/profile_comment.dart';
import 'package:finerit_app_flutter/apps/profile/profile_detail_base.dart';
import 'package:finerit_app_flutter/apps/profile/profile_frend.dart';
import 'package:finerit_app_flutter/apps/profile/profile_heimingdan.dart';
import 'package:finerit_app_flutter/apps/profile/profile_like_status.dart';
import 'package:finerit_app_flutter/apps/profile/profile_story.dart';
import 'package:finerit_app_flutter/apps/profile/profile_task.dart';
import 'package:finerit_app_flutter/apps/profile/profile_verify_base.dart';
import 'package:finerit_app_flutter/apps/settings/settings_base.dart';
import 'package:finerit_app_flutter/beans/audit_info.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/dicts.dart';
import 'package:finerit_app_flutter/commons/ui.dart';
import 'package:finerit_app_flutter/icons/icons_route2.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/icons/icons_route3.dart';
import 'package:finerit_app_flutter/icons/icons_route4.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';


class ProfileApp extends StatefulWidget {
  static const routeName = "/profile";

  @override
  State<StatefulWidget> createState() => ProfileAppState();
}

class ProfileAppState extends State<ProfileApp> {
  FrendNumInfoModel _frendInfoModel;
  UserAuthModel _userAuthModel;
  RankingInfoModel rankingInfoModel;
  MainStateModel model;
  static const CHANNEL_SHARE=
  const MethodChannel("com.finerit.campus/share/invoke");
  static const FANKUI_CHANAL_NUM=
  const MethodChannel("com.finerit.campus/fankui/num");
  static const FANKUI_CHANAL_INVOKE=
  const MethodChannel("com.finerit.campus/fankui/invoke");
  int fankuiNum=0;
  Widget _buildAppBar() {
    return AppBar(
      leading: Container(),
      centerTitle: true,
      title: Text("我", style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.white,
//      actions: <Widget>[
//        IconButton(icon: Icon(MyFlutterApp.settings, color: FineritColor.color1_normal), onPressed: (){
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => SettingsApp(),
//            ),
//          );
//        })
//      ],
    );
  }

  bool loadingFrendInfo = false;
  String headImg = "";
  String nickName = "";
  bool iosPayShow=false;
  UserInfoModel userInfoModel;
  @override
  initState() {
    super.initState();
  }
  Future initFankuiNum() async {
    int _fankuiNum=await FANKUI_CHANAL_NUM.invokeMethod("fankuinum");
    setState(() {
      fankuiNum = _fankuiNum;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (loadingFrendInfo == false) {
      _frendInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      _userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      userInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      rankingInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      model = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      initFrendNumInfo();
      initFankuiNum();
      if(Platform.isIOS){
        initIfShowIosPayInfo();
      }
      loadingFrendInfo = true;
    }
    return Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //top card
              _buildTopCard(model),
              //mid card
              _buildMidCard(),

              new Container(
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.white,
                  child: FlatButton(
                    onPressed: (){
                      _handle_nav_task_list();
                    }
                    , child:
                  new Row(
                    children: <Widget>[
                      Container(
                        child:new Icon(MyFlutterApp.newtask,color: Color(0xff3333cc),),
                        margin: EdgeInsets.only(right: 5),
                      ),
                      Container(child:
                      new Text("新手任务", style: new TextStyle(color: Color(0xff3333333)))
                      ),
                      model.profileTaskCount != 0
                          ? Container(
                        child: Center(
                            child: Text(
                              model.profileTaskCount.toString(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12),
                            )),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                            BorderRadius.all(Radius.circular(30))),
                        margin: EdgeInsets.all(4),
                        width: 15,
                        height: 15,
                      )
                          : Container()
                    ],
                  ),
                  )
              ),
              new Container(
                  margin: EdgeInsets.only(top: 2),
                  color: Colors.white,
                  child: FlatButton(
                    onPressed: () {
                      _handle_nav_ranking_list();
                    },
                    child: new Row(
                      children: <Widget>[
                        Container(
                          child: new Icon(
                            MyFlutterApp3.rank,
                            color: Color(0xff3333cc),
                          ),
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Container(
                            child: new Text("昨日榜单",
                                style: new TextStyle(
                                    color: Color(0xff3333333)))),
                        model.profileYesterdayRankingCount != 0
                            ? Container(
                                child: Center(
                                    child: Text(
                                      model.profileYesterdayRankingCount.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                margin: EdgeInsets.all(4),
                                width: 15,
                                height: 15,
                              )
                            : Container()
                      ],
                    ),
                  )),
              new Container(
                  margin: EdgeInsets.only(top: 2),
                  color: Colors.white,
                  child: FlatButton(
                    onPressed: () {
                      _handle_nav_comment_award_list();
                    },
                    child: new Row(
                      children: <Widget>[
                        Container(
                          child: new Icon(
                            MyFlutterApp3.godcomments,
                            color: Color(0xff3333cc),
                          ),
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Container(
                          child: new Text("昨日神评",
                              style: new TextStyle(
                                  color: Color(0xff3333333))),
                        ),
                        model.profileYesterdayCommentCount != 0
                            ? Container(
                                child: Center(
                                    child: Text(
                                      model.profileYesterdayCommentCount.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                margin: EdgeInsets.all(4),
                                width: 15,
                                height: 15,
                              )
                            : Container()
                      ],
                    ),
                  )),
              new Container(
                  margin: EdgeInsets.only(top: 2),
                  color: Colors.white,
                  child: FlatButton(
                    onPressed: () {
                      _handle_nav_award_list();
                    },
                    child: new Row(
                      children: <Widget>[
                        Container(
                          child: new Icon(
                            MyFlutterApp3.winning_course,
                            color: Color(0xff3333cc),
                          ),
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Container(
                            child: new Text("获奖历程",
                                style: new TextStyle(
                                    color: Color(0xff3333333)))),
                        model.profileAwardHistoryCount != 0
                            ? Container(
                                child: Center(
                                    child: Text(
                                  model.profileAwardHistoryCount.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                margin: EdgeInsets.all(4),
                                width: 15,
                                height: 15,
                              )
                            : Container()
                      ],
                    ),
                  )),
              new Container(
                  margin: EdgeInsets.only(top: 2),
                  color: Colors.white,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>
                            ScopedModel<BaseFrendInfoModel>(
                              child: ProfileDisLikeUserApp(),
                              model: DislikeUserInfoModel(),
                            )

                      ));
                    },
                    child: new Row(
                      children: <Widget>[
                        Container(
                          child: new Icon(
                            MyFlutterApp4.addfriend,
                            color: Color(0xff3333cc),
                          ),
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Container(
                            child: new Text("勿扰名单",
                                style: new TextStyle(
                                    color: Color(0xff3333333)
                                ))),
                      ],
                    ),
                  )),
              new Container(
                  margin: EdgeInsets.only(top: 2),
                  color: Colors.white,
                  child: FlatButton(
                    onPressed: () {
                      _handle_share();
                    },
                    child: new Row(
                      children: <Widget>[
                        Container(
                          child: new Icon(
                            MyFlutterApp3.share,
                            color: Color(0xff3333cc),
                          ),
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Container(
                            child: new Text("乐在分享",
                                style: new TextStyle(
                                    color: Color(0xff3333333)))),
                      ],
                    ),
                  )),
              new Container(
                  margin: EdgeInsets.only(top: 2),
                  color: Colors.white,
                  child: FlatButton(
                    onPressed: () {
                      handle_fankui();
                    },
                    child: new Row(
                      children: <Widget>[
                        Container(
                          child: new Icon(
                            MyFlutterApp3.feedback,
                            color: Color(0xff3333cc),
                          ),
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Container(
                            child: new Text("在线反馈",
                                style: new TextStyle(
                                    color: Color(0xff3333333)
                                ))),
                        fankuiNum != 0
                            ? Container(
                          child: Center(
                              child: Text(
                                fankuiNum.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          margin: EdgeInsets.all(4),
                          width: 15,
                          height: 15,
                        )
                            : Container()
                      ],
                    ),
                  )),

              //functions
            ],
          ),
        ));
  }
  
  void handle_fankui(){
    setState(() {
      fankuiNum=0;
    });
    FANKUI_CHANAL_INVOKE.invokeMethod("fankui",[userInfoModel.userInfo.phone]);
  }
  void _handle_nav_task_list(){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context)=>
          ProfileTaskApp(),
    ));
  }
  void _handle_nav_comment_award_list() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfileAwardCommentApp(),
    ));
  }

  void _handle_nav_ranking_list() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfileAwardStatusApp(),
    ));
  }

  void _handle_nav_award_list() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfileAwardApp(),
    ));
  }

  Container _buildTopCard(MainStateModel model) {
    return Container(
      margin: EdgeInsets.all(0),
      height: 160,
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 0.3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //basic profile
            _buildBasicProfile(model),
            //social bar
            _buildSocialBar(),
          ],
        ),
      ),
    );
  }

  Container _buildMidCard() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 0, right: 0),
      height: 85,
      child: Card(
        elevation: 0.3,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: _buildGirdView(),
      ),
    );
  }

  Container _buildSocialBar() {
    return Container(
      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _frendInfoModel.frend_num!=null?
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>
                      ScopedModel<BaseFrendInfoModel>(
                        child: ProfileFrendApp(),
                        model: FrendInfoModel(),
                      )
                  )
              );
            },
            child: ProfileFrendNumWidget(num: _frendInfoModel.frend_num,value: '好友',),
          ) : SpinKitFadingCircle(color: Color.fromARGB(50, 0, 0, 0),size: 30,),
          new Container(
              margin: EdgeInsets.only(top: 24),
              height: 20,
              child: VerticalDivider(
                color: Colors.grey,
                width: 4,
              )),
          _frendInfoModel.follower_num!=null?
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>
                      ScopedModel<BaseFrendInfoModel>(
                        child: ProfileFollowerApp(),
                        model: FolowerInfoModel(),
                      )
                  )
              );
            },
            child: ProfileFrendNumWidget(num: _frendInfoModel.follower_num,value: '粉丝',),
          ) : SpinKitFadingCircle(color: Color.fromARGB(50, 0, 0, 0),size: 30,),
          new Container(
              margin: EdgeInsets.only(top: 24),
              height: 20,
              child: VerticalDivider(
                color: Colors.grey,
                width: 4,
              )),
          _frendInfoModel.followee_num!=null?
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>
                      ScopedModel<BaseFrendInfoModel>(
                        child: ProfileFolloweeApp(),
                        model: FoloweeInfoModel(),
                      )
                  )
              );
            },
            child: ProfileFrendNumWidget(num: _frendInfoModel.followee_num,value: '关注',),
          ) : SpinKitFadingCircle(color: Color.fromARGB(50, 0, 0, 0),size: 30,),
        ],
      ),
    );
  }

  Container _buildBasicProfile(MainStateModel model) {
    return Container(
      decoration: new BoxDecoration(
        color: Color.fromARGB(100, 51, 153, 204)
//        image: new DecorationImage(
//          image: new AssetImage(
//              'assets/backimg.jpg'),
//          centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
//        ),
      ),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 8),
                width: 90.0,
                height: 90.0,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: NetworkImage(model.userInfo.headImg),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: Colors.white,
                    width: 4.0,
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          new Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Column(

                  children: <Widget>[
                    Text(
                      userInfoModel.userInfo.nickName,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Container(
                        width: 98,
                        height: 18,
                        margin: EdgeInsets.only(top: 8.0),
                        decoration: BoxDecoration(
//                                  color: Colors.red,
                          color: Colors.blue[700].withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: handleVerify,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: model.userInfo.ifAuth == true?Icon(
                                  MyFlutterApp2.auth,
                                  size: 14,
                                  color: Colors.black,
                                ):
                                Icon(
                                  MyFlutterApp2.notauth,
                                  size: 14,
                                  color: Colors.black,
                                ),
                                margin: EdgeInsets.all(2.0),
                              ),
                              Container(
                                child: Text(
                                  "实名认证",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                margin: EdgeInsets.only(left: 2.0, bottom: 2.0),
                              ),
                              Container(
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.black,
                                  size: 16,
                                ),
                                margin: EdgeInsets.only(left: 6.0),
                              )
                            ],
                          ),
                        )),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          new Column(
            children: <Widget>[
              Container(
                width: 70,
                margin: EdgeInsets.only(left: 9.0, bottom: 2),
                child: InkWell(
                  onTap: _handleAvatar,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text("详细资料",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                        margin: EdgeInsets.only(bottom: 2),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }

  Container _buildGirdView() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: handleMyStory,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            MyFlutterApp3.article,
                            size: 30,
                            color: FineritColor.color1_normal,
                          ),
                        ),
                        Text(
                          "我的微文",
                          style: TextStyle(color: FineritColor.color1_normal),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: handleMyGallery,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            MyFlutterApp3.comment2,
                            size: 30,
                            color: FineritColor.color1_normal,
                          ),
                        ),
                        Text(
                          "我的评论",
                          style: TextStyle(color: FineritColor.color1_normal),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: handleMyComments,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          MyFlutterApp3.like2,
                          size: 30,
                          color: FineritColor.color1_normal,
                        ),
                        Text(
                          "我的喜欢",
                          style: TextStyle(color: FineritColor.color1_normal),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: _handleMoney,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          MyFlutterApp4.wallet2 ,
                          size: 30,
                          color: FineritColor.color1_normal,
                        ),
                        Text(
                          "我的钱包",
                          style: TextStyle(color: FineritColor.color1_normal),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void initFrendNumInfo() {
    NetUtil.get(
      Api.FRENDS_NUM_INFO,
      (data) {

        _frendInfoModel.setFrendInfo(
            data['follower_num'], data['followee_num'], data['frend_num']);
      },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }
  void initIfShowIosPayInfo(){
    //TODO 判断是否显示支付
    NetUtil.request(
      'http://114.116.46.204:8003/ifshowpayment/',
          (data) {
        if(data["info"]=="false"){
          iosPayShow=false;
        }
        else if(data["info"]=="true"){
          iosPayShow=true;
        }
      },
      method: "get",
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }

  void handleVerify() {
    NetUtil.get(
        Api.AUDITS_VERIFY + model.userInfo.id + '/',
            (data) async {
          AuditInfo info = AuditInfo.fromJson(data);
          print(info);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileVerifyBaseApp(auditInfo: info,),
            ),
          );
        },
        headers: {
          "Authorization": "Token ${model.session_token}",
        },
        errorCallBack: (errorMsg){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileVerifyBaseApp(auditInfo: null,),
            ),
          );
        }
    );

  }

  void handleFriends() {
    print("handle friends");
  }

  void handleLikes() {
    print("handle likes");
  }

  void handleMyStory() {
    print("handle my story");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScopedModel<BaseBBSModel>(
                  child: ProfileStoryApp(),
                  model: SelfStatusModel(),
                )));
  }

  void handleMyGallery() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScopedModel<BaseComment>(
                  child: ProfileCommentApp(),
                  model: SelfCommentModel(),
                )));
  }

  void handleMyComments() {
    //TODO show my comments
    print("handle my comments");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScopedModel<BaseBBSModel>(
                  child: ProfileLikeStatusApp(),
                  model: StatusLikeModel(),
                )));
  }

  void handleSettings() {
    print("handle settings page");
    Navigator.pushNamed(context, "/settings");
  }

  void _handleAvatar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileDetailBaseApp(),
      ),
    );
  }

  void _handleMoney() {
    Widget appWidget;
    if(Platform.isIOS){
      appWidget=MoneyAppIOS(iosPayShow: iosPayShow,);
    }else if(Platform.isAndroid){
      appWidget=MoneyApp();
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => appWidget,
      ),
    );
  }

  Future _handle_share() async{
    var event=await CHANNEL_SHARE.invokeMethod("doShare");
    if(event=="-1"){
      print("转发失败");
      return ;
    }
    String task=Dicts.TASK_STARE_CHIVE[event];
    if(task==null){
      return ;
    }
    NetUtil.get(Api.SHARE, (data) {
        print(data);
        print("分享成功！");
    },
        headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
        params: {"taskid":task},
    );


  }
}
