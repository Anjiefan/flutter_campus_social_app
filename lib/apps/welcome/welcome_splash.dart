import 'package:finerit_app_flutter/apps/welcome/welcome_contract.dart';
import 'package:finerit_app_flutter/apps/welcome/welcome_nickname_avatar.dart';
import 'package:finerit_app_flutter/commons/SharedPreferenceUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SplashApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashAppState();
}

class SplashAppState extends State<SplashApp> {
  final PageController _pageController = PageController();
  UserInfoModel userInfoModel;
  bool ifLogin = null;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, widget, UserAuthModel model) {
        userInfoModel =
            ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
        ifLogin = model.isLogin;
        return Scaffold(
          body: PageView(
            children: <Widget>[
              Stack(children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/welcome/cover1.png"))
              ]),
              Stack(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/welcome/cover2.png")),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 75,
                    bottom: 15,
                    child: Container(
                      width: 150,
                      height: 50,
                      child: InkWell(
                        onTap: () {
                          _handleEnter(model);
                        },
                        child: Material(
                          color: FineritColor.login_button,
                          //设置控件的背景色
                          child: Padding(
                            padding:
                                EdgeInsets.all(6.0), //只是为了给 Text 加一个内边距，好看点~
                            child: Center(
                              child: Text(
                                "进入云智校",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                          //设置矩形的圆角弧度，具体根据 UI 标注为准
                          shadowColor: Colors.grey,
                          //可以设置 阴影的颜色
                          elevation: 5.0, //安卓中的井深(大概就是阴影颜色的深度吧╮(╯▽╰)╭)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            controller: _pageController,
          ),
        );
      },
    );
  }

  void _handleEnter(UserAuthModel model) {
    print("_handleEnter");
    if (ifLogin == null) {
      print("ifLogin=null");
      return;
    }
    if (model.objectId != null &&
        model.password != null &&
        userInfoModel.userInfo == null) {
      //未初始化信息
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeNicknameAvatarApp(),
        ),
      );
    }
    if (ifLogin &&
        model.objectId != null &&
        model.password == null &&
        userInfoModel.userInfo == null) {
      //未设置密码
      Navigator.of(context).pushReplacementNamed('/welcome');
    }

    if (ifLogin) {
      if (model.state == CommonPageStatus.RUNNING &&
          userInfoModel.userInfo != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else if (model.state == CommonPageStatus.RUNNING && !ifLogin) {
        Navigator.of(context).pushReplacementNamed('/welcome');
      }
    } else {
      Navigator.of(context).pushReplacementNamed('/welcome');
    }
  }
}
