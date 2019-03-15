import 'dart:async';

import 'package:finerit_app_flutter/apps/course/course_education.dart';
import 'package:finerit_app_flutter/apps/course/course_search_educat.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/SharedPreferenceUtil.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/commons/ui.dart';
import 'package:finerit_app_flutter/extra_apps/daike_animation/src/radial_menu.dart';
import 'package:finerit_app_flutter/extra_apps/daike_animation/src/radial_menu_item.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CourseAppState();
}
class CourseAppState extends State<CourseApp> with SingleTickerProviderStateMixin{

//  handleCourseWeb(Object url) async {
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }
  MainStateModel model;
  static const CHANNEL_CHAT_QQ = const MethodChannel("com.finerit.campus/chat/qq");
  static const CHANNEL_CHAT_WX = const MethodChannel("com.finerit.campus/chat/wx");
  static const CHANNEL_CHAT_WB = const MethodChannel("com.finerit.campus/chat/wb");
  Future handleCourseWeb(String url) async {
    String password=model.password;
    NetUtil.get(Api.GET_SESSION_ID, (data) async {
      print(data["sessionid"]);
      url=url+data["sessionid"];
      print(url);
//      Navigator.push(context,
//          MaterialPageRoute(builder: (context) => CourseWebApp(url: url,))
//      );

      if (await canLaunch(url)) {
      await launch(url);
      } else {
      throw 'Could not launch $url';
      }
    }, params: {'password':password },headers: {"Authorization": "Token ${model.session_token}"});

  }

  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    model = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    int _countdownNum =0;
    Timer _countdownTimer;
    // TODO: implement build
    return Scaffold(
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          CourseEducationShuakeApp(),
          CourseEducationSearchApp(),

        ],
      ),
//      drawer: new Drawer(
//        child: CommonDrawer(headImg: model.userInfo.headImg,nickName: model.userInfo.nickName),
//      ),
      appBar: new AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new CircleAvatar(
              backgroundImage: new NetworkImage(
                  model.userInfo.headImg),
            ),
            onPressed: () => handle_head_event(context),
          ),

        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(MyFlutterApp.more, color: Colors.grey[800],),
            onSelected: (String value) {
              handle_operate_for_chat(value);
            },
            itemBuilder: (BuildContext context) =>
            <PopupMenuItem<String>>[
              const PopupMenuItem(
                value: "跳转微信",
                child: Text("微信公众号"),
              ),
              const PopupMenuItem(
                value: "跳转微博",
                child: Text("官方微博"),
              ),
              const PopupMenuItem(
                value: "站长QQ",
                child: Text("联系站长"),
              ),
            ],
          ),
        ],
        title:  new TabBar(
          tabs: <Widget>[
            Tab(text: "代课教程"),
            Tab(text: "搜题教程"),
          ],
          indicatorColor: Colors.grey[400],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey[400],
          controller: _tabController,
        ),
        backgroundColor: Colors.white,

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: new RadialMenu(
          key: GlobalConfig.menu_key,
          items: <RadialMenuItem<String>>[
            const RadialMenuItem<String>(
              backgroundColor: Colors.white70,
              value: "https://finerit.com/?type=1&id=",
              child: const IconButton(
                icon:CircleAvatar(
                    backgroundImage:AssetImage('assets/course/zhihuishu.png'),
                    radius:30
                ),
                onPressed: null,
                iconSize: 50,
                padding:EdgeInsets.all(0),
              ),

            ),
            const RadialMenuItem<String>(
              backgroundColor: Colors.white70,
              value: "https://finerit.com/?type=1&id=",
              child: const IconButton(
                icon:CircleAvatar(
                    backgroundImage:AssetImage('assets/course/zhidao.png'),
                    radius:30
                ),
                onPressed: null,
                iconSize: 50,
                padding:EdgeInsets.all(0),
              ),

            ),
            const RadialMenuItem<String>(
              backgroundColor: Colors.white70,
              value: "https://finerit.com/?type=2&id=",
              child: const IconButton(
                icon:CircleAvatar(
                    backgroundImage:AssetImage('assets/course/erya.png'),
                    radius:30
                ),
                onPressed: null,
                padding:EdgeInsets.all(0),
                iconSize: 50,
              ),

            ),
            const RadialMenuItem<String>(
              backgroundColor: Colors.white70,
              value: "https://finerit.com/?type=2&id=",
              child: const IconButton(
                icon:CircleAvatar(
                    backgroundImage:AssetImage('assets/course/xuexitong.png'),
                    radius:30
                ),
                onPressed: null,
                padding:EdgeInsets.all(0),
                iconSize: 50,
              ),

            ),
            const RadialMenuItem<String>(
              backgroundColor: Colors.white70,
              value: "https://www.finerit.com/?type=2&id=",
              child: const IconButton(
                icon:CircleAvatar(
                    backgroundImage:AssetImage('assets/course/souti.png'),
                    radius:30
                ),
                onPressed: null,
                padding:EdgeInsets.all(0),
                iconSize: 50,
              ),

            ),
          ],
          radius: 120.0,
          onSelected: (Object url){
            handleCourseWeb(url);
            _countdownTimer=new Timer.periodic(new Duration(seconds: 2), (timer) {
              if(!this.mounted){
                return;
              }
              setState(() {
                if (_countdownNum !=2) {
                  _countdownNum=2;
                  GlobalConfig.menu_key.currentState.reset();
                } else {
                  _countdownNum==0;
                  _countdownTimer.cancel();
                  _countdownTimer=null;
                }
              });
            });
          },
        ),
      ),
    );
  }

  String headImg = "";
  String nickName = "";

  Future handle_operate_for_chat(String value) async {
    switch(value){
      case "站长QQ":
        CHANNEL_CHAT_QQ.invokeMethod("chatqq");
        break;
      case "跳转微信":
        Clipboard.setData(new ClipboardData(text: "凡尔智慧校园"));
        CHANNEL_CHAT_WX.invokeMethod("chatwx");
        break;
      case "跳转微博":
        CHANNEL_CHAT_WB.invokeMethod("chatwb");
        break;

    }

  }

  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    SharedPreferenceUtil.getHeadImg().then((value) {
      if(!this.mounted){
        return;
      }
      setState(() {
        headImg = value;
      });
    });
    SharedPreferenceUtil.getNickName().then((value) {
      if(!this.mounted){
        return;
      }
      setState(() {
        nickName = value;
      });
    });
  }
}