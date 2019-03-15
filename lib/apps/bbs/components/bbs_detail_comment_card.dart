import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_attention.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_feedback_comment_widget.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/apps/components/icon_text_wighet.dart';
import 'package:finerit_app_flutter/apps/components/image_grid_view.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/beans/comment_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BBSDetailCommentCard<T extends Model> extends StatefulWidget{
  int index;
  BBSDetailCommentCard({
    key
    ,@required this.index
  }):super(key: key);
  @override
  State<StatefulWidget> createState()=>BBSDetailCommentCardState<T>(index: index);

}

class BBSDetailCommentCardState<T extends Model> extends State<BBSDetailCommentCard>{
  int index;
  DataComment obj;
  BaseComment _commentdModel;
  UserAuthModel _userAuthModel;
  BBSDetailCommentCardState({
    key
    ,this.obj
    ,this.index
  }):super();

  @override
  Widget build(BuildContext context) {
    _commentdModel=ScopedModel.of<T>(context,rebuildOnChange: true) as BaseComment;
    _userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    obj=_commentdModel.commentList[index];
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only( bottom:1.0),
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Container(
                child: new Row(
                  children: <Widget>[
                    UserHead(username: obj.comment.user.nickName
                        ,sincePosted: obj.sincePosted
                        ,headImg: obj.comment.user.headImg,
                    userInfo: obj.comment.user,),
                    BBSAttention(user: obj.comment.user),
                    FeedBackWidgetComment(obj:obj)
                  ],
                ),
                padding: const EdgeInsets.only(left: 15,top: 5),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15,right: 20),
              child: new Text(obj.comment.text,style: TextStyle(color: Colors.black54),),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  new Expanded(
                      child:
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                            width: 50,
                            child: new FlatButton(
                              onPressed: (){ _handle_like_oprate();},
                              padding:EdgeInsets.only(),
                              child: new Row(

                                children: <Widget>[
                                  obj.like==false?new Icon(MyFlutterApp.like, size: 25.0, color: Colors.black,):Icon(Icons.favorite, size: 25.0, color: FineritColor.color1_pressed,),
                                  new Text(obj.comment.likes.toString(),style: TextStyle(color:  FineritColor.color1_normal)),
                                ],
                              ),
                            ),
                          ),
                          new Container(
                            width: 50,
                            child: new FlatButton(
                              onPressed: (){ print("icon");},
                              padding:EdgeInsets.only(),
                              child: new Row(

                                children: <Widget>[
                                  new Icon(MyFlutterApp.comment, size: 25.0, color: FineritColor.color1_normal,),
                                  new Text(obj.comment.interactive.toString(),style: TextStyle(color:  FineritColor.color1_normal)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
  void _handle_like_oprate(){
    obj.like=!obj.like;
    if(obj.like){
      int likes=int.parse(obj.comment.likes)+1;
      obj.comment.likes=likes.toString();
    }
    else{
      int likes=int.parse(obj.comment.likes)-1;
      obj.comment.likes=likes.toString();
    }
    _commentdModel.updateComment(obj, index);
    NetUtil.get(Api.COMMENTS_LIKE+obj.comment.objectId+'/', (data) async{
      NetUtil.get(Api.COMMENTS+obj.comment.objectId+'/', (data) async{
        var _obj = DataComment.fromJson(data);
        _commentdModel.updateComment(_obj, index);
        //TODO 界面显示数据
      },
        headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
      );
    },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );

  }
}

