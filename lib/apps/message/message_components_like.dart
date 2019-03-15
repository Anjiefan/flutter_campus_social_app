import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_replay_2.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/apps/components/image_grid_view.dart';
import 'package:finerit_app_flutter/apps/message/model/message_model.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/beans/comment_list.dart';
import 'package:finerit_app_flutter/beans/message_like_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';

class MessageLikeCard<T extends Model> extends StatefulWidget {
  int index;

  MessageLikeCard({key, @required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MessageLikeCardState<T>(index: index);
}

class MessageLikeCardState<T extends Model> extends State<MessageLikeCard> {
  int index;
  MessageLikeItem obj;
  Widget widgetAchive;
  UserAuthModel _userAuthModel;
  BaseMessageLikeModel _messageLikeModel;
  BaseBBSModel _bbsModel;
  UserInfoModel userInfoModel;
  MessageLikeCardState({key, this.index}) : super();

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
//    _bbsModel = ScopedModel.of<T>(context,rebuildOnChange: true) as BaseBBSModel;
    _userAuthModel = ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
    _messageLikeModel = ScopedModel.of<T>(context, rebuildOnChange: true)
        as BaseMessageLikeModel;
    userInfoModel=ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
    obj = _messageLikeModel.getData()[index];
    widgetAchive = new Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: new FlatButton(
          onPressed: () {
            obj.comment == null
                ? _handle_detail_status(obj.status.objectId)
                : _handle_detail_comment(obj);
          },
          child: new Column(
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
              Row(
                children: <Widget>[
                  Icon(
                    MyFlutterApp.like,
                    color: FineritColor.color1_normal,
                  ),
                  Container(
                    child: Text("喜欢了你的" + (obj.comment == null?"微文":"评论")),
                  ),
                ],
              ),
              new Container(
                  alignment: Alignment.topCenter,
                  child: Row(
                    verticalDirection: VerticalDirection.up,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: <Widget>[
                      Text("${userInfoModel.userInfo.nickName}："
                      ,style: TextStyle(color: Colors.pink),),
                      Expanded(
                        child: new Text(
                            obj.comment == null?
                            obj.status.text:
                            obj.comment.text
                            ,
                            style: new TextStyle(
                                 color: GlobalConfig.font_color)),
                      )
                    ],
                  )
              ),
              new Container(
                child: ImageGridView(
                  imageList: obj.status.images,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      obj.status.address != ''
                          ? Icon(
                              Icons.add_location,
                              size: 20,
                              color: Colors.black12,
                            )
                          : Container(),
                      obj.status.address != ''
                          ? Text(
                              obj.status.address,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black12),
                            )
                          : Container(),
                    ],
                  )),
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
                      children: <Widget>[],
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

  void _handle_detail_status(String status_id) {
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

  void _handle_detail_comment(obj) {
    NetUtil.get(
      Api.COMMENTS + obj.comment.objectId + '/',
      (data) async {
        var _obj = DataComment.fromJson(data);
        MessageLikeCommentModel commentModel = MessageLikeCommentModel();
        commentModel.commentList = [_obj];
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ScopedModel<BaseComment>(
                  child: Reply2Page<BaseComment>(
                    index: 0,
                  ),
                  model: commentModel,
                )));
      },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }
}
