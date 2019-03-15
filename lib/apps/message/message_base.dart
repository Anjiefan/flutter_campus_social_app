import 'package:finerit_app_flutter/apps/components/common_drawer.dart';
import 'package:finerit_app_flutter/apps/contact/contact_profile.dart';
import 'package:finerit_app_flutter/apps/message/message_detail_comments.dart';
import 'package:finerit_app_flutter/apps/message/message_detail_likes.dart';
import 'package:finerit_app_flutter/apps/message/model/message_model.dart';
import 'package:finerit_app_flutter/commons/datas.dart';
import 'package:finerit_app_flutter/commons/ui.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/icons/icons_route4.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import "package:flutter/material.dart";
import 'package:flutter/semantics.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:collection/collection.dart' show lowerBound;
import 'package:scoped_model/scoped_model.dart';

class MessageApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MessageAppState();
}

class MessageAppState extends State<MessageApp> {
  MainStateModel model;

  Widget _buildAppBar(MainStateModel model) {

    return AppBar(
      centerTitle: true,
      title: Text("消息", style: FineritStyle.style3,),
      leading: Builder(
        builder: (context) => IconButton(
          icon: new CircleAvatar(
            backgroundImage: new NetworkImage(model.userInfo.headImg),
          ),
          onPressed: () => handle_head_event(context),
        ),
      ),
      backgroundColor: Colors.white,
//      actions: <Widget>[
//        IconButton(
//          tooltip: "添加好友",
//          icon: const Icon(MyFlutterApp.create2,color: Colors.black,size: 15,),
//          color: FineritColor.color1_normal,
//          onPressed: _handleAddFriend,
//        ),
//      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    return Scaffold(
        appBar: _buildAppBar(model),
        body: Container(
          margin: EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      //喜欢
                      InkWell(
                        onTap: _handleShowLikeMe,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                height: 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                      alignment: FractionalOffset.topLeft,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(left: 8),
                                              width: 50.0,
                                              height: 50.0,
                                              child: Icon(
                                                MyFlutterApp.like,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.lightBlueAccent,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(45.0)),
                                              )),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                    ),
                                    new Flexible(
                                      child: Align(
                                        alignment: FractionalOffset.topLeft,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 16),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    width: 100,
                                                    child: Text(
                                                      "喜欢",
                                                      style: TextStyle(
                                                          color: FineritColor
                                                              .color2_normal,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                              ),
                                            ),
                                          ],
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: FractionalOffset.topRight,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            model.messageLikeCount == 0?
                                            Icon(
                                              MyFlutterApp4.right,
                                              color: Colors.black,
//                                              size: 36,
                                            ):
                                            Container(
                                              child: Center(child: Text(model.messageLikeCount.toString(), style: TextStyle(color: Colors.white),)),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.all(Radius.circular(30))
                                              ),
                                              margin: EdgeInsets.all(4),
                                              width: 20,
                                              height: 20,
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          color: Colors.transparent,
                          margin: EdgeInsets.only(left: 72),
                          child: Divider(
                            color: Colors.grey[300],
                            height: 1,
                          )),
                      //评论
                      InkWell(
                        onTap: _handleShowCommentMe,
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              height: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: FractionalOffset.topLeft,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(left: 8),
                                            width: 50.0,
                                            height: 50.0,
                                            child: Icon(
                                              MyFlutterApp.comment,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.lightBlueAccent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(45.0)),
                                            )),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    ),
                                  ),
                                  Flexible(
                                    child: Align(
                                      alignment: FractionalOffset.topLeft,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 16),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "评论",
                                                    style: TextStyle(
                                                        color: FineritColor
                                                            .color2_normal,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                            ),
                                          ),
                                        ],
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: FractionalOffset.topRight,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          model.messageCommentCount == 0?
                                          Icon(
                                              MyFlutterApp4.right,
                                            color: Colors.black,
                                          ):
                                              Container(
                                                child: Center(child: Text(model.messageCommentCount.toString(), style: TextStyle(color: Colors.white),)),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.all(Radius.circular(30))
                                                ),
                                                margin: EdgeInsets.all(4),
                                                width: 20,
                                                height: 20,
                                              ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
              //mid card
              //functions
            ],
          ),
        ));
  }




  void _handleAddFriend() {
    //TODO handle add friend
    //...
    print("handle add friend");
  }

  void _handleSystemMessage() {
    //TODO handle system message
    //...
    print("handle system message");
  }

  void _handleMessageFilter() {
    //TODO handle message filter
    //...
    print("handle message filter");
  }

  //显示喜欢我的
  void _handleShowLikeMe() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ScopedModel<BaseMessageLikeModel>(
                  child:  MessageLikeApp(),
                  model: MessageLikeStatusModel(),
                )
        ));
    model.messageLikeCount = 0;
  }

  //显示评论我的
  void _handleShowCommentMe() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ScopedModel<BaseMessageCommentModel>(
                  child:  MessageCommentApp(),
                  model: MessageCommentModel(),
                )
        ));
    model.messageCommentCount = 0;
  }
}
