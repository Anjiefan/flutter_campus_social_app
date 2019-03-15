import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil2.dart';
import 'package:finerit_app_flutter/commons/net_load.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class WelcomeNicknameAvatarApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() =>
      WelcomeNicknameAvatarAppState();

}

class WelcomeNicknameAvatarAppState extends State<WelcomeNicknameAvatarApp> {
  final TextEditingController _controller = new TextEditingController();
  bool _obscureText = true;

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
                          height: 190,
                          alignment: FractionalOffset.topLeft,
                          child: Theme(
                            data: ThemeData(
                                primaryColor: Colors.grey,
                                accentColor: Colors.grey,
                                hintColor: Colors.grey),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: _handleAvatarPicker,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 8),
                                        width: 90.0,
                                        height: 90.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff7c94b6),
                                          image: DecorationImage(
                                            image: _image == null
                                                ? NetworkImage(
                                                "https://www.finerit.com/media/head.png")
                                                : FileImage(_image),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(50.0)),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 4.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
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
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 20),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(7),
                                              labelText: "设置头像和昵称",
                                              icon: Icon(Icons.star)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 50,
                          margin: EdgeInsets.only(top: 40),
                          child: InkWell(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) {
                                    return new NetLoading(
                                      requestCallBack: _handleNicknameAndAvatar(model),
                                      loadingText: "设置用户基础信息...",
                                      outsideDismiss: true,
                                    );
                                  });

                            },
                            child: Material(
                              color: FineritColor.login_button,
                              //设置控件的背景色
                              child: Padding(
                                padding: EdgeInsets.all(6.0), //只是为了给 Text 加一个内边距，好看点~
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
    );

  }

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future _handleNicknameAndAvatar(MainStateModel model) async {
    String sessionToken = model.session_token;
    String objectId = model.objectId;
    String phone = model.phone;

    if(_image == null){//使用默认图片
      await NetUtil2().put(Api.REGISTER_NICKNAME_AVATAR+"$objectId/", (data) async {
        await NetUtil2().get(Api.USER_INFO+model.objectId+'/', (data) async {
          User userInfo = User.fromJson(data);
          model.userInfo=userInfo;
          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => route == null);
        }, headers: {"Authorization": "Token ${model.session_token}"});
      }, params: {
        "phone": phone,
        "nick_name": _controller.text,
        "head_img": "https://www.finerit.com/media/head.png"
      }, headers: {"Authorization": "Token $sessionToken"});
    }else{//选取了新的图片
      String uploadUrl = await NetUtil2().putFile(_image, (value) async {
        Map uploadInfo = json.decode(value);
        String realUrl = uploadInfo["url"];
        print("realUrl=$realUrl");
        await NetUtil2().put(Api.REGISTER_NICKNAME_AVATAR+"$objectId/", (data) async {
          await NetUtil2().get(Api.USER_INFO+model.objectId+'/', (data) async {
            User userInfo = User.fromJson(data);
            model.userInfo=userInfo;
            Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => route == null);
          }, headers: {"Authorization": "Token ${model.session_token}"});
        }, params: {
          "phone": phone,
          "nick_name": _controller.text,
          "head_img": realUrl
        }, headers: {"Authorization": "Token $sessionToken"});
      });

      if(uploadUrl == "FILE_TYPE_NOT_SUPPORTED"){
        requestToast( "头像上传失败：文件类型不受支持");
      }else if(uploadUrl == "FILE_UPLOAD_ERROR"){
        requestToast("头像上传失败：上传服务暂不可用");
      }
    }


  }
  void _handleAvatarPicker() {
    getImage();
  }
}
