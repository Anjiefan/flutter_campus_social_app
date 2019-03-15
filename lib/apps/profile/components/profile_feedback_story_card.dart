//PopupMenuButton

import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
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

class ProfileFeedBackWidgetStatus extends StatefulWidget{
  int index;
  BBSDetailItem obj;
  BaseBBSModel bbsModel;
  ProfileFeedBackWidgetStatus({
    Key key,
    this.index,
    this.obj,
    this.bbsModel
  }):super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FeedBackWidgetState(index: index,obj: obj,bbsModel: bbsModel,);
  }

}

class FeedBackWidgetState extends State<ProfileFeedBackWidgetStatus> {
  UserAuthModel _userAuthModel;
  final TextEditingController _controller = new TextEditingController();
  int index;
  BBSDetailItem obj;
  bool focus=true;
  bool loading=false;
  FeedBackWidgetState({
    Key key,
    this.index,
    this.obj,
    this.bbsModel
  }):super();
  BaseBBSModel bbsModel;
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
    return
      PopupMenuButton<String>(
        icon: Icon(MyFlutterApp4.delete, color: FineritColor.color1_normal,),
        onSelected: (String value) {
          switch(value){
            case "删除微文":
              showGeneralDialog(
                context: context,
                pageBuilder: (context, a, b) => handle_delete(),
                barrierDismissible: false,
                barrierLabel: '删除微文',
                transitionDuration: Duration(milliseconds: 400),
              );
              break;
            case "自己可见":
              handle_dislike();
              break;
            case "公开可见":
              handle_dislike_type();
              break;
          }
        },
        itemBuilder: (BuildContext context) =>
        <PopupMenuItem<String>>[
          const PopupMenuItem(
            value: "自己可见",
            child: Text("自己可见"),
          ),
          const PopupMenuItem(
            value: "公开可见",
            child: Text("公开可见"),
          ),
          const PopupMenuItem(
            value: "删除微文",
            child: Text("删除微文"),
          ),
        ],
      );
  }

  Widget handle_delete(){
    return AlertDialog(
      title: Text('删除微文'),
      content: Text("删除微文将无法恢复，确定删除吗？"),
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
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) {
                  return new NetLoading(
                    requestCallBack: handle_http_delete(),
                    outsideDismiss: true,
                    loadingText: '删除微文中...',
                  );

                });


          },
        ),
      ],
    );
  }
  Future handle_http_delete() async{
    await NetUtil2().delete(Api.BBS_BASE+obj.status.objectId+'/', (data) {
      requestToast("删除微文成功～");
      bbsModel.removeByIndex(index);
      Navigator.pop(context);
    },
        headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );

  }


  void handle_dislike(){
    requestToast("设置微文仅自己可见～");
  }
  void handle_dislike_type(){
    requestToast("设置微文公开可见～");
  }


}

