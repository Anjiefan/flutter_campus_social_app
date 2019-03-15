import 'package:finerit_app_flutter/apps/bbs/components/bbs_attention.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_feedback_comment_widget.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/beans/comment_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/sp_util.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
class Reply3Page extends StatefulWidget {
  DataComment obj;
  bool comment;
  Reply3Page(
      {
        key
        ,this.obj
        ,this.comment=false
      }):super(key:key);
  @override
  ReplyPageState createState() => new ReplyPageState(obj: obj,comment: comment);
}

class ReplyPageState extends State<Reply3Page> {
  final TextEditingController _controller = new TextEditingController();
  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();
  bool loading=false;
  List<DataComment> commentList=[];
  DataComment obj;
  bool comment=false;
  UserAuthModel _userAuthModel;
  int page=1;
  ReplyPageState(
      {
        key
        ,this.obj
        ,this.comment
      }):super();
  @override
  Widget build(BuildContext context) {
    _userAuthModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    List<Widget> widgets=[
      get_bbs_comment_detail_wighet(obj),
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
      get_bbs_comment_detail_wighet(obj),
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
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        leading: BackButton(color: Colors.grey[800],),
        title: Text("评论", style: TextStyle(color: Colors.grey[800]),),
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
      body:Stack(
        children: <Widget>[
          GestureDetector(
            child: new EasyRefresh(
              autoLoad: false,
              key: _easyRefreshKey,
              refreshHeader: MaterialHeader(
                key: _headerKey,
              ),
              refreshFooter: MaterialFooter(
                key: _footerKey,
              ),
              child: new ListView.builder(
                  itemCount: commentList.length==0?1:commentList.length,
                  itemBuilder: (BuildContext context, int index){
                    if(index==0){
                      if(commentList.length!=0){
                        widgets.add(get_comment_wighet(commentList[index],index));
                      }
                      else{
                        widgets.add(SizedBox(height: 50,));
                      }
                      if(index==commentList.length-1){
                        widgets.add(SizedBox(height: 50,));
                      }
                    }
                    else{
                      widgets=[get_comment_wighet(commentList[index],index)];
                      if(index==commentList.length-1){
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
                    commentList= CommentList.fromJson(data).data;
                    page=1;
                  },
                    params: {'status_id':obj.comment.status.objectId,
                      'comment_id':obj.comment.objectId,'page':0},
                    headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
                  );
                },
                loadMore: () async {
                  NetUtil.get(Api.COMMENTS, (data) async{
                    commentList.addAll(CommentList.fromJson(data).data);
                    page=page+1;
                  },
                    params: {'status_id':obj.comment.status.objectId,
                      'comment_id':obj.comment.objectId,'page':page},
                    headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
                  );
                },
            ),
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
              if(!this.mounted){
                return;
              }
              setState(() {
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
//                    new Offstage(
//                      offstage: !comment,
//                      child:  new Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          IconButton(
//                            icon: new Icon(Icons.keyboard_voice, color: Colors.black12),
//                            onPressed: (){
//                              setState(() {
//                              });
//                            },
//                          ),
//                          IconButton(
//                            icon: new Icon(Icons.photo, color: Colors.black12),
//                            onPressed: (){},
//                          ),
//                          IconButton(
//                              icon: new Icon(Icons.all_out, color: Colors.black12),
//                              onPressed: () {
//                              }
//                          ),
//
//                          new IconButton(
//                            icon: Icon(Icons.collections, color:Colors.black12),
//                            onPressed: (){
//                            },
//                          ),
//                          new IconButton(
//                            icon: Icon(Icons.insert_emoticon, color: Colors.black12),
//                            onPressed: (){
//                              setState(() {
//                              });
//                            },
//                          )
//                        ],
//                      ),
//                    ),
                  ],
                )
            ),
          ),
        ],
      )

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
        if(!this.mounted){
          return;
        }
        setState(() {
          commentList.insert(0, DataComment.fromJson(data));
        });
        NetUtil.get(Api.COMMENTS+obj.comment.objectId+'/', (data) async{
          if(!this.mounted){
            return;
          }
          setState(() {
            obj=DataComment.fromJson(data);
          });
          //TODO 界面显示数据
        },
          headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
        );

      },
        headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
      );

      //TODO 界面显示数据
    },
        headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
        params: {"text": _controller.text
          , "status":obj.comment.status.objectId
          ,"comments":obj.comment.objectId
        });

  }
  Widget get_bbs_comment_detail_wighet(DataComment obj){
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only( bottom:3.0),
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Container(
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child:
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            UserHead(username: obj.comment.user.nickName
                                ,sincePosted: obj.sincePosted
                                ,headImg: obj.comment.user.headImg,
                              userInfo: obj.comment.user,
                            ),

                          ],
                        )
                    ),

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
                              onPressed: (){ _base_handle_like_oprate();},
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
  Widget get_comment_wighet(DataComment obj,int index){
    return new Container(
        color: Colors.white,
        margin: const EdgeInsets.only( bottom:1.0),
        child: new FlatButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=> Reply3Page(obj: obj)
            ));
          },
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: new Container(
//                height: 30,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child:
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              UserHead(username: obj.comment.user.nickName
                                  ,sincePosted: obj.sincePosted
                                  ,headImg: obj.comment.user.headImg,
                              userInfo: obj.comment.user,),

                            ],

                          )

                      ),
                      BBSAttention(user: obj.comment.user),
                      FeedBackWidgetComment(obj:obj)

                    ],
                  ),
                  padding: const EdgeInsets.only(),
                ),
              ),
              new Container(
//                height: 30,
                child: Container(
                  child: new Text(obj.comment.text,style: TextStyle(color: Colors.black54),),
                ),
                padding: const EdgeInsets.only(left: 37,bottom: 15),
              ),
              new Container(
                  child: Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Container(
                                width: 50,
                                child: new FlatButton(
                                  onPressed: (){ _handle_like_oprate(obj, index);},
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
                                  onPressed: (){
                                    Navigator.pop(context);
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context)=> Reply3Page(obj: obj,comment: true,)
                                    ));
                                  },
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
                  )
              )
            ],
          ),
        )
    );
  }
  void _base_handle_like_oprate(){
    obj.like=!obj.like;
    if(obj.like){
      int likes=int.parse(obj.comment.likes)+1;
      obj.comment.likes=likes.toString();
    }
    else{
      int likes=int.parse(obj.comment.likes)-1;
      obj.comment.likes=likes.toString();
    }
    if(!this.mounted){
      return;
    }
    setState(() {
     obj=obj;
    });
    NetUtil.get(Api.COMMENTS_LIKE+obj.comment.objectId+'/', (data) async{
      NetUtil.get(Api.COMMENTS+obj.comment.objectId+'/', (data) async{
        //TODO 界面显示数据
      },
        headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
      );
    },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }
  void _handle_like_oprate(DataComment obj,int index){
    obj.like=!obj.like;
    if(obj.like){
      int likes=int.parse(obj.comment.likes)+1;
      obj.comment.likes=likes.toString();
    }
    else{
      int likes=int.parse(obj.comment.likes)-1;
      obj.comment.likes=likes.toString();
    }
    if(!this.mounted){
      return;
    }
    setState(() {
      commentList[index]=obj;
    });
    NetUtil.get(Api.COMMENTS_LIKE+obj.comment.objectId+'/', (data) async{
      NetUtil.get(Api.COMMENTS+obj.comment.objectId+'/', (data) async{
        if(!this.mounted){
          return;
        }
        setState(() {
          commentList[index]=DataComment.fromJson(data);
        });
        //TODO 界面显示数据
      },
        headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
      );
    },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );

  }
  void _handle_comments(){
    NetUtil.get(Api.COMMENTS, (data) async{
      commentList= CommentList.fromJson(data).data;
      if(!this.mounted){
        return;
      }
      setState(() {
        loading=true;
      });
    },
      params: {'status_id':obj.comment.status.objectId,'comment_id':obj.comment.objectId},
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }
}

