import 'dart:async';

import 'package:finerit_app_flutter/extra_apps/chewie/lib/chewie.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_replay_2.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/apps/components/audio_file_list_tile.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_attention.dart';
import 'package:finerit_app_flutter/apps/components/icon_text_wighet.dart';
import 'package:finerit_app_flutter/apps/components/image_grid_view.dart';
import 'package:finerit_app_flutter/apps/message/model/message_model.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/beans/comment_list.dart';
import 'package:finerit_app_flutter/beans/message_comment_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';

class MessageCommentCard<T extends Model> extends StatefulWidget {
  int index;

  MessageCommentCard({key, @required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      MessageCommentCardState<T>(index: index);
}

class MessageCommentCardState<T extends Model>
    extends State<MessageCommentCard> {
  int index;
  MessageCommentItem obj;
  Widget widgetAchive;
  UserAuthModel _userAuthModel;
  BaseMessageCommentModel _messageCommentModel;
  BaseBBSModel _bbsModel;
  UserInfoModel userInfoModel;
  MessageCommentCardState({key, this.index}) : super();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userInfoModel =
        ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
    _messageCommentModel =
        ScopedModel.of<T>(context, rebuildOnChange: true) as BaseMessageCommentModel;
    _userAuthModel =
        ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
    obj = _messageCommentModel.getData()[index];

    widgetAchive = new Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(

                child: new Container(
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              UserHead(
                                username: obj.user.nickName,
                                sincePosted: obj.sincePosted,
                                headImg: obj.user.headImg,
                                userInfo: obj.user,
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                decoration: new BoxDecoration(
                    color: GlobalConfig.card_background_color,
                    border: new BorderDirectional(
                        bottom: new BorderSide(color: Colors.white10))),
              ),
              FlatButton(child: Text("点击回复：${obj.text}"), onPressed: (){
                NetUtil.get(Api.COMMENTS+obj.objectId+'/', (data) async{
                  DataComment _obj = DataComment.fromJson(data);
                  MessageToCommentModel messageCommentModel=MessageToCommentModel();
                  messageCommentModel.commentList=[_obj];
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=> ScopedModel<BaseComment>(
                      child: Reply2Page<BaseComment>(index: 0,comment: true,),
                      model: messageCommentModel,
                    )
                  ));
                  //TODO 界面显示数据
                },
                  headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
                );

              }
              ,),
              FlatButton(
                child:  new Container(

                    alignment: Alignment.center,
                    child: Row(
                      verticalDirection: VerticalDirection.up,
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: <Widget>[
                        Text("${userInfoModel.userInfo.nickName}："
                          ,style: TextStyle(color: Colors.pink),),
                        Expanded(
                          child: new Text(
                              obj.status.text
                              ,
                              style: new TextStyle(
                                  color: GlobalConfig.font_color)),
                        )
                      ],
                    )
                ),
                onPressed: (){
                  _handle_detail_status(obj.status.objectId, index);
                },
              ),

              new Container(
                child: ImageGridView(
                  imageList: obj.status.images,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              new Container(
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          width: 100,
                          child: new Row(
                            children: <Widget>[
                              new Icon(MyFlutterApp.money,
                                  size: 20.0,
                                  color: FineritColor.color1_normal),
                              new Text(
                                  ' ' + obj.status.fineritCode.split(".")[0],
                                  style: TextStyle(
                                      color: FineritColor.color1_normal)),
                            ],
                          ),
                        ),
                      ],
                    )),
    new Expanded(
                        child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                      ],
                    )),
                  ],
                ),
                padding: const EdgeInsets.only(),
              )
            ],
          ),
        ));
    return widgetAchive;
  }

  void _handle_detail_status(String status_id, int index) {
    print(status_id);
    NetUtil.get(
      Api.BBS_BASE + status_id + '/',
      (data) async {
        BBSDetailItem bbsDetailItem = BBSDetailItem.fromJson(data);
        BBSMessageCommentMeModel _bbsModel = BBSMessageCommentMeModel();
        _bbsModel.setData([bbsDetailItem]);
        print("here");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ScopedModel<BaseBBSModel>(
                  model: _bbsModel,
                  child: ReplyPage(bbsDetailItem: bbsDetailItem, index: 0),
                )));
      },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }
}
