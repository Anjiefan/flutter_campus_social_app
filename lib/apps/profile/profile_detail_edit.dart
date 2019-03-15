import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:finerit_app_flutter/apps/profile/profile_verify_base.dart';
import 'package:finerit_app_flutter/beans/audit_info.dart';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route4.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/providers/user_info.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileDetailEditApp extends StatefulWidget {
  final String nickName;

  @override
  State<StatefulWidget> createState() => ProfileDetailEditAppState(nickName: nickName);

  ProfileDetailEditApp({
    Key key,
    @required this.nickName,
  }) : super(key: key);
}

class ProfileDetailEditAppState extends State<ProfileDetailEditApp> {
  MainStateModel model;
  final String nickName;
  ProfileDetailEditAppState({@required this.nickName});

  final TextEditingController _controller = new TextEditingController();


  @override
  void initState() {
    super.initState();
    _controller.text = nickName;
  }

  @override
  Widget build(BuildContext context) {
    model = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    return new ScopedModelDescendant<MainStateModel>(
        builder: (context, widget, MainStateModel model) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              color: Colors.grey[800],
            ),
            title: Text(
              "编辑资料",
              style: TextStyle(color: Colors.grey[800]),
            ),
            backgroundColor: Colors.white,
          ),
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Align(
                alignment: FractionalOffset.topCenter,
                child: Column(
                  children: <Widget>[
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
                                    height: 89.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff7c94b6),
                                      image: DecorationImage(
                                        image: _image == null
                                            ? NetworkImage(
                                                model.userInfo.headImg)
                                            : FileImage(_image),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
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
                                        labelText: "修改头像和昵称",
                                        icon: Icon(MyFlutterApp4.article),
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
//                                          labelText: "修改头像和昵称",
//                                          icon: Icon(Icons.star)),
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
                        onTap: () {
                          _handleNicknameAndAvatar(model);
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
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: InkWell(
                            onTap: _handleVerify,
                            child: Text(
                              "认证其他关键信息，获取专属权益",
                              style: TextStyle(color: Colors.blue),
                            )))
                  ],
                ),
              ),
            ],
          ));
    });
  }

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(!this.mounted){
      return;
    }
    setState(() {
      _image = image;
    });
  }

  Future _handleNicknameAndAvatar(MainStateModel model) async {
    String sessionToken = model.session_token;
    String objectId = model.objectId;
    String phone = model.phone;
    if(_image == null){
      NetUtil.put(
          Api.REGISTER_NICKNAME_AVATAR + "$objectId/",
              (data) {
            NetUtil.get(
                Api.USER_INFO + model.objectId + '/',
                    (data) async {
                  User userInfo = User.fromJson(data);
                  model.userInfo = userInfo;
                },
                headers: {"Authorization": "Token ${model.session_token}"},
                );
            requestToast( "编辑资料成功！");
            Navigator.pop(context);
          },
          params: {
            "phone": phone,
            "nick_name": _controller.text,
            "head_img": model.userInfo.headImg
          },
          headers: {"Authorization": "Token $sessionToken"},
          );
    }else{
      String uploadUrl = await NetUtil.putFile(_image, (value) {
        Map uploadInfo = json.decode(value);
        String realUrl = uploadInfo["url"];
        print("realUrl=$realUrl");
        NetUtil.put(
            Api.REGISTER_NICKNAME_AVATAR + "$objectId/",
                (data) {
              NetUtil.get(
                  Api.USER_INFO + model.objectId + '/',
                      (data) async {
                    User userInfo = User.fromJson(data);
                    model.userInfo = userInfo;
                  },
                  headers: {"Authorization": "Token ${model.session_token}"},
                  );
              requestToast( "编辑资料成功！");
              Navigator.pop(context);
            },
            params: {
              "phone": phone,
              "nick_name": _controller.text,
              "head_img": realUrl
            },
            headers: {"Authorization": "Token $sessionToken"},
            );
      });
      if (uploadUrl == "FILE_TYPE_NOT_SUPPORTED") {
        requestToast( "头像上传失败：文件类型不受支持");
      } else if (uploadUrl == "FILE_UPLOAD_ERROR") {
        requestToast( "头像上传失败：上传服务暂不可用");
      }
    }


  }

  void _handleAvatarPicker() {
    getImage();
  }

  void _handleVerify() {
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
}
