import 'package:finerit_app_flutter/apps/bbs/bbs_replay_3.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_attention.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_comments_card.dart';
import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/components/hint_wighet.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_comment_card.dart';
import 'package:finerit_app_flutter/beans/comment_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import "package:flutter/material.dart";
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileCommentApp extends StatefulWidget{
  ProfileCommentApp({Key key}): super (key: key);
  @override
  State<StatefulWidget> createState() => ProfileCommentAppState();
}

class ProfileCommentAppState extends State<ProfileCommentApp>{
  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();
  BaseComment selfComment;
  UserInfoModel userInfoModel;
  UserAuthModel userAuthModel;
  bool loading=false;
  int page=1;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    if(loading==false){
      selfComment=ScopedModel.of<BaseComment>(context,rebuildOnChange: true);
      userInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      init_comment_data();
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title:
        Text("评论", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: _get_main_widget(),
    );
  }
  Widget _get_main_widget(){
    if(selfComment.commentList.length==0&&loading==false){
      return SpinKitFadingCircle(color: Color.fromARGB(50, 0, 0, 0),size: 30,);
    }
    else if(selfComment.commentList.length==0){
      return new EasyRefresh(
        autoLoad: false,
        key: _easyRefreshKey,
        refreshHeader: MaterialHeader(
          key: _headerKey,
        ),
        refreshFooter: MaterialFooter(
          key: _footerKey,
        ),
        child: new ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index){
              return new Column(
                children: [
                  Container(
                    child: Blank(width: MediaQuery.of(context).size.width
                      ,height: MediaQuery.of(context).size.height
                      ,text: '你还没有发表过评论哦～',),
                  )
                ],
              );
            }
        ),
        onRefresh: () async {
          refresh_comment_data();
        },
        loadMore: () async {
          load_more_comment_data();
        },
      );
    }
    else{
      return new EasyRefresh(
        autoLoad: false,
        key: _easyRefreshKey,
        refreshHeader: MaterialHeader(
          key: _headerKey,
        ),
        refreshFooter: MaterialFooter(
          key: _footerKey,
        ),
        child: new ListView.builder(
            itemCount: selfComment.commentList.length,
            itemBuilder: (BuildContext context, int index){
              return new Column(
                children: [
                  get_comment_cards(index)
                ],
              );
            }
        ),
        onRefresh: () async {
          refresh_comment_data();
        },
        loadMore: () async {
          load_more_comment_data();
        },
      );
    }

  }
  Widget get_comment_cards(int index){
      //type不为0时，去掉Expanded
    return  ProfileCommentCard<BaseComment>(index: index,type: 1,);
  }
  Future refresh_comment_data(){
    NetUtil.get(Api.COMMENTS, (data) async{
      page=1;
      selfComment.commentList= CommentList.fromJson(data).data;
    },
      params: {'user_id':userInfoModel.userInfo.id,'page':0},
      headers: {"Authorization": "Token ${userAuthModel.session_token}}"},
    );
  }
  Future load_more_comment_data(){
    NetUtil.get(Api.COMMENTS, (data) async{
      selfComment.addAllComments(CommentList.fromJson(data).data);
      page=page+1;
    },
      params: {'user_id':userInfoModel.userInfo.id,'page':page},
      headers: {"Authorization": "Token ${userAuthModel.session_token}}"},
    );
  }
  Future init_comment_data() {
    NetUtil.get(Api.COMMENTS, (data) async{
      selfComment.commentList= CommentList.fromJson(data).data;
      if(!this.mounted){
        return;
      }
      setState(() {
        loading=true;
      });
    },
      params: {'user_id':userInfoModel.userInfo.id,'page':0},
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
  }
}