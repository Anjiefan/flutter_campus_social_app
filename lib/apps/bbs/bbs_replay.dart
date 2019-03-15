import 'package:finerit_app_flutter/apps/bbs/bbs_info.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_comments_card.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_detail_word_card.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/apps/components/hint_wighet.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/beans/comment_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/builders.dart';
import 'package:finerit_app_flutter/commons/sp_util.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
class ReplyPage extends StatefulWidget {
  BBSDetailItem bbsDetailItem;
  bool comment;
  int index;
  ReplyPage(
      {
        key,
        @required this.bbsDetailItem
        ,this.index
        ,this.comment=false
      }):super(key:key);
  @override
  ReplyPageState createState() => new ReplyPageState(bbsDetailItem: bbsDetailItem,index: index,comment: comment);
}

class ReplyPageState extends State<ReplyPage> {

  final TextEditingController _controller = new TextEditingController();
  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();
  BBSDetailItem bbsDetailItem;
  CommentdModel _commentdModel;
  BaseBBSModel _bbsModel;
  UserAuthModel _userAuthModel;
  bool loading=false;
  int index;
  int page=1;
  bool comment=false;

  ReplyPageState(
      {
        key,
        @required this.bbsDetailItem
        ,this.comment
        ,this.index
      }):super();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_controller != null){
      _controller.dispose();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentdModel=CommentdModel();

  }
  @override
  Widget build(BuildContext context) {
    ///这个不可以写在initState中，因为scoped_model实现的原理原因，卸载initState中有几率出现加载异常
    _userAuthModel= ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    _bbsModel = ScopedModel.of<BaseBBSModel>(context,rebuildOnChange: true);
    List<Widget> widgets=[
      BBSDetailWordCard(obj: bbsDetailItem,index: index,),
      Container(
        child: Hint(value: '获赞最多的评论将获得楼主的凡尔币奖励哦~',icon: MyFlutterApp.money,),
        padding: EdgeInsets.only(left: 4),
      ),
      new Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text('所有评论',style: TextStyle(color: Colors.black54),textAlign: TextAlign.left,),
            ),

          ],
        ),
        padding: const EdgeInsets.all(4.0),
      ),
    ];
    List<Widget> _widgets=[
      BBSDetailWordCard(obj: bbsDetailItem,index: index,),
      Hint(value: '获赞最多的评论将获得楼主的凡尔币奖励哦~',icon: MyFlutterApp.money,),
      new Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text('所有评论',style: TextStyle(color: Colors.black54),textAlign: TextAlign.left,),
            ),

          ],
        ),
        padding: const EdgeInsets.all(4.0),
      ),
      SpinKitFadingCircle(color: Color.fromARGB(50, 0, 0, 0),size: 30,)
    ];
    if( loading==false){
      _handle_comments();
    }

    return ScopedModel<BaseComment>(
      child: new Scaffold(
//          backgroundColor: Color.fromARGB(100, 240,255,255),
          appBar: new AppBar(
            centerTitle: true,
            leading: BackButton(color: Colors.grey[800],),
            title: Text("微文", style: TextStyle(color: Colors.grey[800]),),
            backgroundColor: Colors.white,
            actions: <Widget>[
              PopupMenuButton(
                icon: new Icon(MyFlutterApp.more, color: Colors.black,size: 30),
                onSelected: (String value) {
                  switch(value){
                    case "举报":
                      requestToast("举报成功，我们将会积极处理！");
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  new PopupMenuItem<String>(
                    value: '举报',
                    child:
                    new Text('举报',style: TextStyle(color: Colors.black)),
                  ),
                ],
                padding:const EdgeInsets.only(),

              ),
            ],
          ),
          body:
          Stack(
            children: <Widget>[
              GestureDetector(
                child:  new EasyRefresh(
                  autoLoad: false,
                  key: _easyRefreshKey,
                  refreshHeader: MaterialHeader(
                    key: _headerKey,
                  ),
                  refreshFooter: MaterialFooter(
                    key: _footerKey,
                  ),
                  child: new ListView.builder(
                      itemCount: _commentdModel.commentList.length==0?1:_commentdModel.commentList.length,
                      itemBuilder: (BuildContext context, int index){
                        if(index==0){
                          if(_commentdModel.commentList.length!=0){
                            widgets.add(
                                CommentCard<BaseComment>(index: index,)
                            );
                          }
                          else{
                            widgets.add(SizedBox(height: 50,));
                          }
                          if(index==_commentdModel.commentList.length-1){
                            widgets.add(SizedBox(height: 50,));
                          }
                        }
                        else{
                          widgets=[CommentCard<BaseComment>(index: index,)];
                          if(index==_commentdModel.commentList.length-1){
                            widgets.add(SizedBox(height: 50,));
                          }
                        }
                        return new Column(
                          children: loading==true?widgets:_widgets,
                        );
                      }
                  ),
                  onRefresh: () async {
                    NetUtil.get(Api.COMMENTS, (data) async{
                      _commentdModel.commentList= CommentList.fromJson(data).data;
                      page=1;
                    },
                      params: {'status_id':bbsDetailItem.status.objectId,'page':0},
                      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
                    );
                  },
                  loadMore: () async {
                    NetUtil.get(Api.COMMENTS, (data) async{
                      _commentdModel.addAllComments(CommentList.fromJson(data).data);
                      if(!this.mounted){
                        return;
                      }
                      setState(() {

                      });
                      page=page+1;
                    },
                      params: {'status_id':bbsDetailItem.status.objectId,'page':page},
                      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
                    );
                  },
                ),
                onTap: (){
                  if(!this.mounted){
                    return;
                  }
                  setState(() {
                    FocusScope.of(context).requestFocus(FocusNode());
                    comment=false;
                  });
                },
              ),
              new Positioned(
                bottom: 0,
                left:0,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    decoration: new BoxDecoration(
                        boxShadow:[new BoxShadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                        ),],
                        color: Colors.white,
                        border: Border(top: BorderSide(width: 0.3, color: Colors.black))
                    ),
                    child:Column(
                      children: <Widget>[
                        new Offstage(
                            offstage: comment,
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.all(2),
                              decoration: new BoxDecoration(
                                border: new Border.all(width: 2.0, color: Colors.black12),
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                              ),
                              child: FlatButton(
                                  onPressed: (){
                                    if(!this.mounted){
                                      return;
                                    }
                                    setState(() {
                                      comment=true;
                                    });
                                  },
                                  child:Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text('开始神评',style: TextStyle(color: Colors.black12),textAlign: TextAlign.left,),
                                  )
                              ),
                            )
                        ),
                        new Offstage(
                            offstage: !comment,
                            child:
                            new Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    new Theme(
                                      data: ThemeData(
                                        hintColor: Colors.black12,
                                      ),
                                      child:
                                      new Container(
                                        margin: EdgeInsets.all(8),
                                        decoration: new BoxDecoration(
                                          border: new Border.all(width: 2.0, color: Colors.black12),
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                                        ),
                                        height: 80,
                                        width: MediaQuery.of(context).size.width*0.8,
                                        child:TextField(
                                          controller: _controller,
                                          autofocus: false,
                                          decoration: new InputDecoration.collapsed(
                                            hintText: '开始评论...',
                                          ),
                                          cursorColor:Colors.black54,
                                          style:TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          child: IconButton(icon: Icon(Icons.crop_free,color: Colors.black12,), onPressed: (){
                                            requestToast("图片评论，语音评论，更多功能，2.0版本带给大家哦～");
                                          }),
                                        ),
                                        Container(
                                          child: IconButton(icon: Icon(Icons.arrow_forward,color: Colors.black12,), onPressed: (){
                                            _handle_send_comment();

                                          }),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[],
                                )
                              ],
                            )
                        ),
//                        new Offstage(
//                          offstage: !comment,
//                          child:  new Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            children: <Widget>[
//                              IconButton(
//                                icon: new Icon(Icons.keyboard_voice, color: Colors.black12),
//                                onPressed: (){
//                                  setState(() {
//                                  });
//                                },
//                              ),
//                              IconButton(
//                                icon: new Icon(Icons.photo, color: Colors.black12),
//                                onPressed: (){},
//                              ),
//                              IconButton(
//                                  icon: new Icon(Icons.all_out, color: Colors.black12),
//                                  onPressed: () {
//                                  }
//                              ),
//
//                              new IconButton(
//                                icon: Icon(Icons.collections, color:Colors.black12),
//                                onPressed: (){
//                                },
//                              ),
//                              new IconButton(
//                                icon: Icon(Icons.insert_emoticon, color: Colors.black12),
//                                onPressed: (){
//                                  setState(() {
//                                  });
//                                },
//                              )
//                            ],
//                          ),
//                        ),
                      ],
                    )
                ),
              ),
            ],
          )
      ),
      model: _commentdModel,
    );
  }

  void _handle_send_comment(){
    FocusScope.of(context).requestFocus(FocusNode());
    if(!this.mounted){
      return;
    }
    setState(() {
      comment=false;
    });
    NetUtil.post(Api.COMMENTS, (data) {
      requestToast("评论成功");
      _controller.clear();
      var id=data['objectId'];
      NetUtil.get(Api.COMMENTS+id+'/', (data) {
        _commentdModel.addBeginComment(DataComment.fromJson(data));
        NetUtil.get(Api.BBS_BASE+bbsDetailItem.status.objectId+'/', (data) {
          BBSDetailItem _bbsDetailItem=BBSDetailItem.fromJson(data);
          bbsDetailItem=_bbsDetailItem;
          _bbsModel.update(bbsDetailItem,index);
        },
          headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
        );
      },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
      );
      //TODO 界面显示数据
    },
        headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
        params: {"text": _controller.text, "status": bbsDetailItem.status.objectId});

  }
  void _handle_comments(){
    NetUtil.get(Api.COMMENTS, (data) async{
      _commentdModel.commentList= CommentList.fromJson(data).data;
      if(!this.mounted){
        return;
      }
      setState(() {
        loading=true;
      });
    },
      params: {'status_id':bbsDetailItem.status.objectId,'page':0},
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }
}

