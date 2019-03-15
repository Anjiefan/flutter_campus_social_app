import 'package:finerit_app_flutter/apps/welcome/welcome_contract.dart';
import 'package:finerit_app_flutter/apps/welcome/welcome_password_login.dart';
import 'package:finerit_app_flutter/apps/welcome/welcome_password_register.dart';
import 'package:finerit_app_flutter/apps/welcome/welcome_register.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/NetUtil2.dart';
import 'package:finerit_app_flutter/commons/SharedPreferenceUtil.dart';
import 'package:finerit_app_flutter/commons/net_load.dart';
import 'package:finerit_app_flutter/commons/permissions.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/icons/icons_route4.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeBaseApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WelcomeBaseAppState();
}

class WelcomeBaseAppState extends State<WelcomeBaseApp> {
  final TextEditingController _controller = new TextEditingController();
  bool loading=false;
  UserAuthModel _userAuthModel;
  @override
  void initState() {
    super.initState();
    FinerPermission.requestWriteExternalStoragePermission();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {

    if(loading==false){
      _userAuthModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      WidgetsBinding.instance.addPostFrameCallback(

              (_) {
                bool value=_userAuthModel.prefs.get('is_read_licence');
                  if (value == null || value == false) {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, a, b) => AlertDialog(
                        title: Text("提示"),
                        content: Text("您还没有同意用户协议，请您阅读后同意才可使用软件！"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('确定'),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomeContractApp(),
                                ),
                              );
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

      );
      loading=true;
    }
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Align(
              alignment: FractionalOffset.topCenter,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 64),
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('assets/base/finer.png'))),
                        child: Text(""),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Divider(
                        height: 2,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/base/right.png',
                            width: 20,
                            height: 10,
                          ),
                          Text(
                            " 云端下的智慧校园 ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Image.asset(
                            'assets/base/left.png',
                            width: 20,
                            height: 10,
                          ),
                        ],
                      ),
                      Divider(
                        height: 2,
                      )
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 50, right: 20, left: 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      alignment: FractionalOffset.topLeft,
                      child: Theme(
                        data: ThemeData(
                            primaryColor: Colors.grey,
                            accentColor: Colors.grey,
                            hintColor: Colors.grey),
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.grey,
                          maxLines: 1,
                          maxLength: 11,
                            cursorWidth:1,
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                              labelText: "手机号码",
                              icon: Icon(MyFlutterApp4.iphone),
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
                        ),
                      )),
                  Container(
                    width: 150,
                    height: 45,
                    margin: EdgeInsets.only(top: 70),
                    child: InkWell(
                      onTap: () {
                        _handleConfirm();
//                        showDialog(
//                            context: context,
//                            barrierDismissible: false,
//                            builder: (_) {
//                              return new NetLoading(
//                                requestCallBack: _handleConfirm(),
//                                loadingText: "检测账号是否存在...",
//                                outsideDismiss: false,
//                              );
//                            });
                      },
                      child: Material(
                        color: FineritColor.login_button,
                        //设置控件的背景色
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          //只是为了给 Text 加一个内边距，好看点~
                          child: Center(
                            child: Text(
                              "确定",
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
                ],
              ),
            ),
          ],
        ));
  }

  Future<bool> _handleConfirm() async {
    String phone = _controller.text;
    if (phone == "") {
      requestToast("请输入手机号");
      return false;
    }
//    String phone = "13091667316";
    await NetUtil2().get(Api.VALIDATE_PHONE_URL + phone + "/", (data) {
      print(data["info"]);
      if (data["info"] == "fail") {
        //手机号注册
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeRegisterApp(phone: phone),
          ),
        );
        return true;
      } else if (data["info"] == "success") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePasswordLoginApp(phone: phone),
          ),
        );
        return true;
      } else if (data["info"] == "not real success") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePasswordRegisterApp(phone: phone),
          ),
        );
        return true;
      }
      return true;
    });
  }

  Future _handleLicense() async {
//    String url = 'https://www.finerit.com/media/xieyi.html';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeContractApp(),
      ),
    );
  }
}
