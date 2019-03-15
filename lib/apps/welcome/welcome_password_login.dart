
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/apps/welcome/welcome_sms_login.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/NetUtil2.dart';
import 'package:finerit_app_flutter/commons/net_load.dart';
import 'package:finerit_app_flutter/icons/icons_route2.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class WelcomePasswordLoginApp extends StatefulWidget {
  final String phone;

  @override
  State<StatefulWidget> createState() => WelcomePasswordLoginAppState(phone: phone);

  WelcomePasswordLoginApp({Key key, @required this.phone}) : super(key: key);
}

class WelcomePasswordLoginAppState extends State<WelcomePasswordLoginApp> {
  final TextEditingController _controller = new TextEditingController();
  final String phone;
  bool _obscureText = true;

  WelcomePasswordLoginAppState({Key key, @required this.phone}) : super();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_controller!=null){
      _controller.dispose();
    }
  }
  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<MainStateModel>(

        builder: (context, widget,MainStateModel model) {
          return
            Scaffold(
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
                            margin: EdgeInsets.only(top: 50, right: 20,left: 10),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.7,
                            alignment: FractionalOffset.topLeft,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.grey,
                                  accentColor: Colors.grey,
                                  hintColor: Colors.grey),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: _controller,
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.grey,
                                      maxLines: 1,
                                      maxLength: 16,
                                      style: TextStyle(color: Colors.grey, fontSize: 20),
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                        labelText: "密码",
                                        icon: Icon(MyFlutterApp2.lock),
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
//                                      decoration: InputDecoration(
//                                          contentPadding: EdgeInsets.all(8),
//                                          labelText: "密码",
//                                          icon: Icon(MyFlutterApp2.lock)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: _obscureText
                                          ? Icon(
                                        MyFlutterApp.eyeclose,
                                        size: 16,
                                        color: Colors.black54,
                                      )
                                          : Icon(
                                        MyFlutterApp.eyes,
                                        size: 13,
                                        color: Colors.black54,
                                      ),
                                      onPressed: _showAndHidePassword,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30, right: 14),
                            height: 20,
                            child: Stack(
                              children: <Widget>[
                                InkWell(
                                  onTap: _handleVerifyCodeLogin,
                                  child: Align(
                                      alignment: FractionalOffset.topRight,
                                      child:
                                      Text("验证码登录", style: TextStyle(color: Colors.black54))),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 45,
                            margin: EdgeInsets.only(top: 40),
                            child: InkWell(
                              onTap: (){
//                                showDialog(
//                                    context: context,
//                                    barrierDismissible: false,
//                                    builder: (_) {
//                                      return new NetLoading(
//                                        requestCallBack: _handleLogin(model),
//                                        loadingText: "登陆中...",
//                                        outsideDismiss: false,
//                                      );
//                                    });
                                _handleLogin(model);
                              },
                              child: Material(
                                color: FineritColor.login_button,
                                //设置控件的背景色
                                child: Padding(
                                  padding: EdgeInsets.all(6.0), //只是为了给 Text 加一个内边距，好看点~
                                  child: Center(
                                    child: Text(
                                      "确定",
                                      style: TextStyle(color: Colors.white, fontSize: 18.0),
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

  Future _handleLogin(MainStateModel model) async {
     await NetUtil2().post(Api.LOGIN_URL, (data) async {
      model.password=_controller.text;
      model.phone=phone;
      model.objectId=data["objectId"];
      model.login(data["session_token"]);
      await NetUtil2().get(Api.USER_INFO+model.objectId+'/', (data) {
        User userInfo = User.fromJson(data);
        model.userInfo=userInfo;
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => route == null);
      }, headers: {"Authorization": "Token ${model.session_token}"});
    }, params: {'password': _controller.text, 'phone_num': phone}, );
  }

  void _showAndHidePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _handleVerifyCodeLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeCodeLoginApp(phone: phone,),
      ),
    );
  }
}
