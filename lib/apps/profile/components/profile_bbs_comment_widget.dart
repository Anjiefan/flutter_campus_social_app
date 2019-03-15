import 'package:finerit_app_flutter/apps/bbs/bbs_replay_2.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/beans/award_list.dart';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/beans/comment_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AwardCommentCard extends StatefulWidget{
  User user;
  CommentAward commentAward;
  String sincePosted;
  AwardCommentCard({
    key,
    this.user,
    this.commentAward,
    this.sincePosted
  }):super(key: key);
  @override
  State<StatefulWidget> createState()=>AwardCommentCardState(user: user
      ,commentAward: commentAward
      ,sincePosted: sincePosted);
}

class AwardCommentCardState<T extends Model> extends State<AwardCommentCard>{
  User user;
  UserAuthModel _userAuthModel;
  CommentAward commentAward;
  String sincePosted;
  AwardCommentCardState({
    key,
    this.user,
    this.commentAward,
    this.sincePosted
  }):super();
  @override
  Widget build(BuildContext context) {
    _userAuthModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    return new Container(
        margin: const EdgeInsets.only( bottom:3.0),
        child: FlatButton(
          onPressed: (){
            handle_comment_detail();
          },
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Container(
//                height: 30,
                  child: new Row(
                    children: <Widget>[
                      UserHead(username: user.nickName
                          ,sincePosted: sincePosted
                          ,headImg: user.headImg,
                      userInfo: user,),
                    ],
                  ),
                  padding: const EdgeInsets.only(top: 10),
                ),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                child: new Text(commentAward.text,style: TextStyle(color: Colors.black54),),
                padding: const EdgeInsets.only(left: 37),
              ),
            ],
          ),
        )
    );

  }
  void handle_comment_detail(){
    AwardCommentModel commentModel=AwardCommentModel();
    NetUtil.get(Api.COMMENTS+commentAward.objectId+"/", (data) async{
      DataComment comment= DataComment.fromJson(data);
      commentModel.commentList=[comment];
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=> ScopedModel<BaseComment>(
            child: Reply2Page<BaseComment>(index: 0,),
            model: commentModel,
          )
      ));
    },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }
}