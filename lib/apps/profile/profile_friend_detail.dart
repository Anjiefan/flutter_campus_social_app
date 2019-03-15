import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/apps/profile/profile_anyuser_status.dart';
import 'package:finerit_app_flutter/apps/profile/profile_award_other.dart';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/http_error.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import "package:flutter/material.dart";
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:scoped_model/scoped_model.dart';
class ProfileFrendDetailApp extends StatefulWidget {
  BaseFrendInfoModel frendInfoModel;
  User userInfo;
  ProfileFrendDetailApp({Key key
    ,this.userInfo
    ,this.frendInfoModel
    }):super(key:key);
  @override
  State<StatefulWidget> createState() => ProfileFrendDetailAppState(userInfo: userInfo,frendInfoModel: frendInfoModel);
}

class ProfileFrendDetailAppState extends State<ProfileFrendDetailApp>{
  final TextEditingController _controller = new TextEditingController();
  User userInfo;
  BaseFrendInfoModel frendInfoModel;
  ProfileFrendDetailAppState({Key key
    ,this.userInfo
    ,this.frendInfoModel
    }):super();
  bool detailinfo=true;
  bool iffrend=false;
  UserAuthModel userAuthModel;
  FrendNumInfoModel frendNumInfoModel;
  bool loading=false;
  @override
  void dispose() {
    // TODO: implement dispose
    if(_controller!=null){
      _controller.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build


    if(loading==false){
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      frendNumInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      init_user_iffrend();
    }
    String sex=userInfo.sex=="0"?"男":"女";
    Widget icon=Container();

    if(detailinfo){
      icon=Icon(Icons.keyboard_arrow_right,color: Colors.purple);
    }
    else if(!detailinfo){
      icon=Icon(Icons.expand_more,color: Colors.purple,);
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        backgroundColor: Colors.white,
        actions: <Widget>[

          PopupMenuButton(
            icon: new Icon(MyFlutterApp.more, color: Colors.black,size: 30),
            onSelected: (String value) {
              switch(value){
                case "举报":
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (context, a, b) => handle_report(context),
                    barrierDismissible: false,
                    barrierLabel: '举报',
                    transitionDuration: Duration(milliseconds: 400),
                  );
                  break;
                case "拉黑":
                  add_deslike_user();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              const PopupMenuItem(
                value: "举报",
                child: Text("举报"),
              ),
              const PopupMenuItem(
                value: "拉黑",
                child: Text("拉黑"),
              ),
            ],
            padding:const EdgeInsets.only(),

          ),
        ],
      ),
      body:Container(

        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(15),
                    color: Colors.white,
                    child: new CircleAvatar(
                        backgroundImage: new NetworkImage(userInfo.headImg),
                        radius: 30.0
                    ),
                  ),
                  Expanded(
                    child: Text(userInfo.nickName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  !iffrend?Container(
                    child: FlatButton(onPressed: (){
                      handle_frend_with_him();
                    }
                    , child: Row(
                          children: <Widget>[
                            Icon(Icons.add),
                            Text("关注")
                          ],
                        )),
                  ):Container(
                    child: FlatButton(onPressed: (){
                      handle_unfrend_with_him();
                    }
                        , child: Row(
                          children: <Widget>[
                            Icon(Icons.close),
                            Text("取关")
                          ],
                        ))),
                ],
              ),
            ),
            new Container(
                margin: EdgeInsets.only(top: 2),
                color: Colors.white,
                child: FlatButton(
                  onPressed: () {
                    if(!this.mounted){
                      return;
                    }
                    setState(() {
                      detailinfo=!detailinfo;
                    });
                  },
                  child: new Row(
                    children: <Widget>[
                      Container(
                        child: icon,
                        margin: EdgeInsets.only(right: 5),
                      ),
                      Container(
                          child:  new Text("用户资料", style: new TextStyle(color: FineritColor.color2_normal))),

                    ],
                  ),
                )),
            Offstage(
              offstage:detailinfo,
              child: userInfo.ifAuth?Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    new Text("真实姓名：${userInfo.realName}"),
                    new Text("性别：${sex}"),
                    new Text("年龄：${userInfo.age}"),
                    new Text("生肖：${userInfo.animals}"),
                    new Text("星座：${userInfo.constellation}"),
                  ],
                ),
              ):Container(),
            ),
            Offstage(
              offstage:userInfo.ifAuth||detailinfo,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("此用户尚未认证，无法获取真实信息！"),
                  ],
                ),
              ),
            ),
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
                          MyFlutterApp.winning_course,
                          color: Colors.purple,
                        ),
                        margin: EdgeInsets.only(right: 5),
                      ),
                      Container(
                          child: new Text("获奖历程",
                              style: new TextStyle(
                                  color: FineritColor.color2_normal))),

                    ],
                  ),
                )),
            new Container(
                margin: EdgeInsets.only(top: 2),
                color: Colors.white,
                child: FlatButton(
                  onPressed: () {
                    _handle_nav_status();
                  },
                  child: new Row(
                    children: <Widget>[
                      Container(
                        child: new Icon(
                          MyFlutterApp.article,
                          color: Colors.purple,
                        ),
                        margin: EdgeInsets.only(right: 5),
                      ),
                      Container(
                          child: new Text("校园圈",
                              style: new TextStyle(
                                  color: FineritColor.color2_normal))),

                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void init_user_iffrend(){
    NetUtil.get(Api.IFFRIEND, (data) async{
      loading=true;
      if(data['frend']=='1'){
        if(!this.mounted){
          return;
        }
        setState(() {
          iffrend=true;
        });
      }
      else if(data['frend']=="0"){
        if(!this.mounted){
          return;
        }
        setState(() {
          iffrend=false;
        });
      };
    },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        params: {"userid":userInfo.id},

    );
  }
  void handle_frend_with_him(){
    NetUtil.put(Api.MAKE_FRIENDS+userInfo.id+'/', (data) async{
      if(data['info']=='success'){
        requestToast("关注成功");
        init_user_iffrend();
        //更新粉丝、朋友数量
        NetUtil.get(Api.FRENDS_NUM_INFO, (data) {
          frendNumInfoModel.setFrendInfo(data['follower_num'], data['followee_num'], data['frend_num']);
        },
          headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        );
      }
    },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        errorCallBack: (error){
          if(error.containsKey('leancloud_error')&&error['leancloud_error']=="You can't follow yourself."){
            requestToast("无法关注自己");
          }
        }
    );
  }
  void handle_unfrend_with_him(){
    showGeneralDialog(
      context: context,
      pageBuilder: (context, a, b) => AlertDialog(
        title: Text("取消关注"),
        content: Text("确定不再关注此人吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('确定'),
            onPressed: () {
              NetUtil.delete(Api.MAKE_FRIENDS+userInfo.id+'/', (data) async{
                if(!this.mounted){
                  return;
                }
                setState(() {
                  iffrend=!iffrend;
                });
                if(data['info']=='success'){
                  if(frendInfoModel!=null){
                    frendInfoModel.remove(userInfo);
                  }
                  requestToast("取关成功");
                  init_user_iffrend();
                  //更新粉丝、朋友数量
                  NetUtil.get(Api.FRENDS_NUM_INFO, (data) {
                    frendNumInfoModel.setFrendInfo(data['follower_num'], data['followee_num'], data['frend_num']);
                  },
                    headers: {"Authorization": "Token ${userAuthModel.session_token}"},
                  );
                }
              },
                headers: {"Authorization": "Token ${userAuthModel.session_token}"},
              );
              Navigator.pop(context);
            },

          ),
        ],
      ),
      barrierDismissible: false,
      barrierLabel: '取消关注',
      transitionDuration: Duration(milliseconds: 400),
    );
  }
  void _handle_nav_award_list() {
    AnyAwardInfoModel anyAwardInfoModel=AnyAwardInfoModel();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ScopedModel<AwardInfoModel>(
          model: anyAwardInfoModel
          , child: ProfileAnyUserAwardApp(userid: userInfo.id,)),
    ));
  }
  void _handle_nav_status(){
    AnySelfStatusModel anySelfStatusModel=AnySelfStatusModel();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ScopedModel<BaseBBSModel>(
        model: anySelfStatusModel,
        child: ProfileAnyuserStatusApp(userid: userInfo.id,),
      ),
    ));
  }
  void add_deslike_user(){
    showGeneralDialog(
      context: context,
      pageBuilder: (context, a, b) => AlertDialog(
        title: Text("提示"),
        content: Text("添加黑名单后，他的微文和信息您将不再可见。"),
        actions: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('确定'),
            onPressed: () {
              Navigator.pop(context);
              NetUtil.post(Api.DISLIKE_USER, (data) async{
                requestToast("添加黑名单成功");
              },
                  params: {'dislikeuser':userInfo.id},
                  headers: {"Authorization": "Token ${userAuthModel.session_token}"},
              );
            },
          ),
        ],
      ),
      barrierDismissible: false,
      barrierLabel: '移除黑名单',
      transitionDuration: Duration(milliseconds: 400),
    );
  }

  Widget handle_report(var context){

    return AlertDialog(
      title: Text('举报'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: (MediaQuery.of(context).size.height / 2) * 0.4,
        child: Column(

          children: <Widget>[
            UserHead(username: userInfo.nickName
              ,sincePosted: ''
              ,headImg: userInfo.headImg,
              userInfo: userInfo,),
            new Theme(
              data: ThemeData(
                hintColor: Colors.black12,
              ),
              child:
              new Container(
                decoration: new BoxDecoration(
                  border: new Border.all(width: 2.0, color: Colors.black12),
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                ),
                height: 80,
                width: MediaQuery.of(context).size.width*1,
                child:TextField(
                  controller: _controller,
                  autofocus: true,
                  decoration: new InputDecoration.collapsed(
                    hintText: '举报原因...',
                  ),
                  cursorColor:Colors.black54,
                  style:TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('确认'),
          onPressed: () async {
            handle_send_reportinfo();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
  void  handle_send_reportinfo()  {
    NetUtil.post(Api.REPORTS, (data) {
      requestToast("举报成功，我们将会积极处理！");
    },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        params: {'userid':userInfo.id,'reason':_controller.text},
        errorCallBack:(data){
          requestToast(HttpError.getErrorData(data).toString());
        }
    );

  }
}