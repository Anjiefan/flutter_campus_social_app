//PopupMenuButton

import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/beans/comment_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/NetUtil2.dart';
import 'package:finerit_app_flutter/commons/http_error.dart';
import 'package:finerit_app_flutter/commons/net_load.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/icons/icons_route3.dart';
import 'package:finerit_app_flutter/icons/icons_route4.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileFeedBackWidgetComment extends StatefulWidget{
  DataComment obj;
  ProfileFeedBackWidgetComment({
    Key key,
    this.obj,
  }):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FeedBackWidgetState(obj: obj);
  }

}

class FeedBackWidgetState extends State<ProfileFeedBackWidgetComment> {
  UserAuthModel _userAuthModel;
  final TextEditingController _controller = new TextEditingController();
  DataComment obj;
  bool focus=true;
  FeedBackWidgetState({
    Key key,
    this.obj,
  }):super();
  bool loading=false;
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
    if(loading==false){
      _userAuthModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      loading=true;
    }

    // TODO: implement build
//    return
//      PopupMenuButton<String>(
//        icon: Icon(MyFlutterApp4.warning, color: FineritColor.color1_normal,),
//        onSelected: (String value) {
//          switch(value){
//            case "举报":
//              showGeneralDialog(
//                context: context,
//                pageBuilder: (context, a, b) => handle_report(context),
//                barrierDismissible: false,
//                barrierLabel: '举报',
//                transitionDuration: Duration(milliseconds: 400),
//              );
//              break;
//          }
//        },
//        itemBuilder: (BuildContext context) =>
//        <PopupMenuItem<String>>[
//          const PopupMenuItem(
//            value: "举报",
//            child: Text("举报"),
//          ),
//        ],
//      );
    return IconButton(icon: Icon(MyFlutterApp4.delete),onPressed: (){
      requestToast("考虑到非法评论检测暂不成熟，目前不允许删除评论。");
    },);
  }


  Widget handle_report(var context){

    return AlertDialog(
      title: Text('举报'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: (MediaQuery.of(context).size.height / 2) * 0.6,
        child: Column(

          children: <Widget>[
            UserHead(username: obj.comment.user.nickName
              ,sincePosted: obj.sincePosted
              ,headImg: obj.comment.user.headImg,
              userInfo: obj.comment.user,),
            new Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: 20),
                child: new Text(
//                    obj.status.text,
                    obj.comment.text.length>20?obj.comment.text.substring(0,20)+'...':obj.comment.text,
                    style: new TextStyle(height: 1.3, color: GlobalConfig.font_color)
                )

            ),
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
                  cursorColor:Colors.black38,
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
//            showDialog(
//                context: context,
//                barrierDismissible: true,
//                builder: (_) {
//                  return new NetLoading(
//                    requestCallBack: handle_send_reportinfo(context),
//                    outsideDismiss: true,
//                    loadingText: '发送举报信息中...',
//                  );
//
//                });
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
        headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
        params: {'commentid':obj.comment.objectId,'userid':obj.comment.user.id,'reason':_controller.text},
        errorCallBack:(data){

          requestToast(HttpError.getErrorData(data).toString());
        }
    );

  }

}

