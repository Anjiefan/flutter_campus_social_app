import 'dart:async';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route4.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class WelcomeCodeLoginApp extends StatefulWidget {
  final String phone;

  @override
  State<StatefulWidget> createState() => WelcomeCodeLoginAppState(phone: phone);

  WelcomeCodeLoginApp({Key key, @required this.phone}) : super(key: key);
}

class WelcomeCodeLoginAppState extends State<WelcomeCodeLoginApp> {
  final String phone;

  WelcomeCodeLoginAppState({Key key, @required this.phone}) : super();

  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;
  bool isSent = false;

  void reGetCountdown() {
    setState(() {
      if (_countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}秒重新获取';
      _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}秒重新获取';
          } else {
            isSent = false;
            _codeCountdownStr = '获取验证码';
            _countdownNum = 59;
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<MainStateModel>(

        builder: (context, widget,MainStateModel model) {
          return Scaffold(
              resizeToAvoidBottomPadding: false,
              backgroundColor: Colors.white,
              body: Stack(
                children: <Widget>[
                  Align(
                    alignment: FractionalOffset.topCenter,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          alignment: FractionalOffset.topLeft,
                          height: 20,
                          child: Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
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
                                onChanged: (String value){
                                  _handleVerifyCode(value,model);
                                },
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.grey,
                                maxLines: 1,
                                maxLength: 6,
                                style: TextStyle(color: Colors.grey, fontSize: 20),
                                decoration: InputDecoration(
                                  labelText: "手机验证码",
                                  icon: Icon(MyFlutterApp4.iphone),
                                  contentPadding: EdgeInsets.all(5),
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
//                                decoration: InputDecoration(
//                                    contentPadding: EdgeInsets.all(8),
//                                    labelText: "手机验证码",
//                                    icon: Icon(MyFlutterApp.phone)),
                              ),
                            )),
                        Container(
                          width: 150,
                          height: 45,
                          margin: EdgeInsets.only(top: 70),
                          child: InkWell(
                            onTap: isSent ? null : _handleSend,
                            child: Material(
                              color: isSent ? Colors.grey : FineritColor.login_button,
                              //设置控件的背景色
                              child: Padding(
                                padding: EdgeInsets.all(6.0), //只是为了给 Text 加一个内边距，好看点~
                                child: Center(
                                  child: Text(
                                    _codeCountdownStr,
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
    );

  }

  void _handleSend() {
    NetUtil.put(Api.LOGIN_CODE_URL, (data){
      requestToast('验证码已发送');
    }, params: {
      "phone_num": phone
    },);
    setState(() {
      isSent = true;
    });
    reGetCountdown();
  }

  void _handleVerifyCode(String text,MainStateModel model) {
    if (text.length != 6) {
      return;
    } else {
      print("verfying...");
      String code = text;
      NetUtil.post(Api.LOGIN_URL, (data) async {
        model.phone=phone;
        model.objectId=data["objectId"];
        model.login(data["session_token"]);
        NetUtil.get(Api.USER_INFO+model.objectId+'/', (data) async {
          User userInfo = User.fromJson(data);
          model.userInfo=userInfo;
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => route == null);
        }, headers: {"Authorization": "Token ${model.session_token}"},);

      }, params: {'code': code, 'phone_num': phone},);

    }
  }
}
