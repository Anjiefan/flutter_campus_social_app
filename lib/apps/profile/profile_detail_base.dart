import 'package:finerit_app_flutter/apps/profile/profile_detail_edit.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileDetailBaseApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileDetailBaseAppState();
}

class ProfileDetailBaseAppState extends State<ProfileDetailBaseApp> {


  Widget _buildTopCard(MainStateModel model) {
    return Container(
      height: 80,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "头像",
                  ))),
          Align(
            alignment: FractionalOffset.centerRight,
            child: Container(
              margin: EdgeInsets.all(8.0),
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: NetworkImage(
                      model.userInfo.headImg),
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
          )
        ],
      ),
    );
  }

  Widget _buildNickNameBar(MainStateModel model) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "昵称",
                  ))),
          Align(
            alignment: FractionalOffset.centerRight,
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  model.userInfo.nickName,
                  style: TextStyle(color: Colors.grey, ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildNameBar(MainStateModel model) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "姓名",
                  ))),
          Align(
            alignment: FractionalOffset.centerRight,
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  model.userInfo.realName == ""?"未认证": model.userInfo.realName,
                  style: TextStyle(color: Colors.grey, ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildSchoolBar(MainStateModel model) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "学校",
                  ))),
          Align(
            alignment: FractionalOffset.centerRight,
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  model.userInfo.schoolName == ""?"未认证": model.userInfo.schoolName,
                  style: TextStyle(color: Colors.grey, ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildGenderBar(MainStateModel model) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "性别",
                  ))),
          Align(
            alignment: FractionalOffset.centerRight,
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  _getGenderText(model.userInfo.sex),
                  style: TextStyle(color: Colors.grey, ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildAgeBar(MainStateModel model) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "年龄",
                  ))),
          Align(
            alignment: FractionalOffset.centerRight,
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  model.userInfo.age == "0"?"未认证": model.userInfo.age,
                  style: TextStyle(color: Colors.grey, ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildBirthdayBar(MainStateModel model) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "出生日期",
                  ))),
          Align(
            alignment: FractionalOffset.centerRight,
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  model.userInfo.birth == "9999-12-31T23:59:59.999999"?"未认证": model.userInfo.birth.substring(0, 10),
                  style: TextStyle(color: Colors.grey, ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildAnimalBar(MainStateModel model) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "生肖",
                  ))),
          Align(
            alignment: FractionalOffset.centerRight,
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  model.userInfo.animals == ""?"未认证": model.userInfo.animals,
                  style: TextStyle(color: Colors.grey, ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildConstellationBar(MainStateModel model) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "星座",
                  ))),
          Align(
            alignment: FractionalOffset.centerRight,
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  model.userInfo.constellation == ""?"未认证": model.userInfo.constellation,
                  style: TextStyle(color: Colors.grey, ),
                )),
          )
        ],
      ),
    );
  }
  Widget _buildInviteNum(MainStateModel model) {
    return GestureDetector(
      child: new Container(
        height: 50,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Align(
                alignment: FractionalOffset.centerLeft,
                child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "邀请码",
                    ))),
            Align(
              alignment: FractionalOffset.centerRight,
              child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "点击复制 ${model.userInfo.id}",
                    style: TextStyle(color: Colors.grey, ),
                  )),
            ),
          ],
        ),
      ),
      onTap: (){
        copyToClipboard(model.userInfo.id);
        requestToast('复制成功');
      },
    );

  }

  Widget _buildMobileBar(MainStateModel model) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: FractionalOffset.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "手机号",
                  ))),
          Align(
            alignment: FractionalOffset.centerRight,
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  model.userInfo.phone,
                  style: TextStyle(color: Colors.grey, ),
                )),
          ),

        ],
      ),
    );
  }

  void copyToClipboard(String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  Widget _buildMidCard(MainStateModel model) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    _buildNickNameBar(model),
                    Divider(
                      height: 2,
                    ),
                    _buildInviteNum(model),
                    Divider(
                      height: 2,
                    ),
                    _buildMobileBar(model),
                    Divider(
                      height: 2,
                    ),
                    _buildNameBar(model),

                    Divider(
                      height: 2,
                    ),
                    _buildGenderBar(model),
                    Divider(
                      height: 2,
                    ),
                    _buildAgeBar(model),
                    Divider(
                      height: 2,
                    ),
                    _buildBirthdayBar(model),
                    Divider(
                      height: 2,
                    ),
                    _buildSchoolBar(model),
                    Divider(
                      height: 2,
                    ),
                    _buildAnimalBar(model),
                    Divider(
                      height: 2,
                    ),
                    _buildConstellationBar(model),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, widget, MainStateModel model) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              color: Colors.grey[800],
            ),
            title: Text(
              "详细资料",
              style: TextStyle(color: Colors.grey[800]),
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              InkWell(
                onTap: ()=>_handleEdit(model.userInfo.nickName),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("编辑资料", style: TextStyle(fontSize: 16, color: Colors.black),)),
                ),
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              _buildTopCard(model),
              _buildMidCard(model),
            ],
          ));
    });
  }

  String _getGenderText(String sex) {
    switch(sex){
      case "0":
        return "男";
      case "1":
        return "女";
      case "2":
        return "未认证";
    }
    return "";
  }

  void _handleEdit(String nickName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileDetailEditApp(nickName: nickName,),
      ),
    );
  }
}
