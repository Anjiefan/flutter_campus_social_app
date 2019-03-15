import 'package:finerit_app_flutter/apps/profile/profile_detail_base.dart';
import 'package:finerit_app_flutter/apps/profile/profile_verify_base.dart';
import 'package:finerit_app_flutter/beans/audit_info.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/ui.dart';
import 'package:finerit_app_flutter/icons/icons_route2.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/icons/icons_route3.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerHeader extends StatelessWidget{
  String headImg;
  String nickName;
  DrawerHeader({
    key
    ,@required this.headImg
    ,@required this.nickName
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    return new UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color.fromARGB(100, 51, 153, 204)
//        image: new DecorationImage(
//          fit: BoxFit.fill,
//          image: new NetworkImage(
//              'https://i01picsos.sogoucdn.com/1fea12e6f0307e7e'),
//        ),
      ),
      accountName: new Text(
        nickName,
      ),
      accountEmail: new Text(
        "",
      ),
      currentAccountPicture: GestureDetector(
        onTap:  (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileDetailBaseApp(),
              )
          );
        },
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(
              headImg),
        ),
      ),
      onDetailsPressed: () {},
//      otherAccountsPictures: <Widget>[
//        new CircleAvatar(
//          backgroundImage: new NetworkImage(
//              headImg),
//        ),
//      ],
    );
  }
}

class CommonDrawer extends StatefulWidget{
  String headImg;
  String nickName;
  CommonDrawer({
    Key key,
    @required this.headImg,
    @required this.nickName
  }):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CommonDrawerState(headImg: headImg, nickName: nickName);
  }
}


class CommonDrawerState extends State<CommonDrawer>{
  String headImg;
  String nickName;
  bool loading=false;
  String money='';
  UserAuthModel userAuthModel;
  CommonDrawerState({
    key
    ,@required this.headImg
    ,@required this.nickName
  }):super();
  Future initMoneyInfo() async {
    NetUtil.post(
      Api.DISPLAY_MONEY_URL,
          (data) {
            if(!this.mounted){
              return;
            }
        setState(() {
          money = data["money"].toString();
          loading=true;
        });
      },
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
  }
  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<MainStateModel>(
        builder: (context, widget,MainStateModel model){

          if(loading==false){
            userAuthModel=model;
            initMoneyInfo();
          }
          var _money='';
          try{
            _money=double.parse(money).toStringAsFixed(2);
          }
          catch(e){
            print(e);
          }
          return new ListView(padding: const EdgeInsets.only(), children: <Widget>[
            DrawerHeader(headImg: headImg,nickName: nickName,),
            new ClipRect(
              child: new ListTile(
                leading: new CircleAvatar(
                    child: model.userInfo.ifAuth?new Icon(MyFlutterApp3.auth):new Icon(MyFlutterApp2.notauth),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
                title: new Text('身份认证'),
                onTap: () {
                  handleVerify(model);
                },
              ),
            ),
            new ListTile(
              leading: new CircleAvatar(
                  child: new Icon(MyFlutterApp3.wallet2,size: 30,),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black),
              title: new Text('我的钱包'),
              subtitle: new Text("当前余额：${_money} 凡尔币"),
              onTap: ()  {
                handleMoney(context,userAuthModel);
              },
            ),
            new ListTile(
                leading: new CircleAvatar(
                    child: new Icon(MyFlutterApp3.unlock),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
                title: new Text('修改密码'),
                onTap: () async {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/changepassword", (route) => route == null);
                }
            ),
            new ListTile(
                leading: new CircleAvatar(
                    child: new Icon(MyFlutterApp3.alteruser),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
                title: new Text('切换账号'),
                onTap: () async {
                  await model.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/welcome", (route) => route == null);
                }
            ),
          ]);
        }
    );


  }
  void handleVerify(MainStateModel model) {
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