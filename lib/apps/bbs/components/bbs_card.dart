import 'dart:async';
import 'dart:io';

import 'package:finerit_app_flutter/extra_apps/chewie/lib/chewie.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_feedback_status_widget.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/apps/components/audio_file_list_tile.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_attention.dart';
import 'package:finerit_app_flutter/apps/components/icon_text_wighet.dart';
import 'package:finerit_app_flutter/apps/components/image_grid_view.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/digital_conversion.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route2.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';
class BBSCard<T extends Model> extends StatefulWidget{
  int index;
  BBSCard({
    key
    ,@required this.index
  }):super(key: key);
  @override
  State<StatefulWidget> createState()=>BBSCardState<T>(index: index);
}

class BBSCardState<T extends Model> extends State<BBSCard>{
  List<VideoPlayerController> _videoPlayerControllers=[];
  int index;
  BBSDetailItem obj;
  Widget widgetAchive;
  UserAuthModel _userAuthModel;
  BaseBBSModel _bbsModel;
  bool loading=false;
  BBSCardState({
    key
    ,this.index
  }):super();
  @override
  void dispose() {
    // TODO: implement dispose
    for(var _videoPlayerController in _videoPlayerControllers){
      if(_videoPlayerController!=null){
        _videoPlayerController.dispose();
      }
    }
    super.dispose();

  }
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    if(loading==false){
      _bbsModel = ScopedModel.of<T>(context,rebuildOnChange: true) as BaseBBSModel;
      _userAuthModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      loading=true;
    }
    obj=_bbsModel.getData()[index];

    Widget vedioWidget;
    if(obj.status.video!=""){
      vedioWidget=_get_vedio_wighet();
    }
    widgetAchive=new Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5.0),
        child: Column(
          children: <Widget>[
            new FlatButton(

              onPressed: (){
                _handle_detail_status(obj,index);
              },
              padding:EdgeInsets.only(left: 10,top: 10,right: 8),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    alignment: Alignment.topRight,
                    child: new Container(
                      alignment: Alignment.topRight,
                      child: new Row(
                        children: <Widget>[
                          UserHead(username: obj.user.nickName
                            ,sincePosted: obj.sincePosted
                            ,headImg: obj.user.headImg,
                            userInfo: obj.user,),
                          BBSAttention(user: obj.user),
                          FeedBackWidgetStatus(index: index,obj: obj,bbsModel: _bbsModel,)
                        ],
                        verticalDirection: VerticalDirection.up,

                      ),
                    ),
                    decoration: new BoxDecoration(
                        color: GlobalConfig.card_background_color,
                        border: new BorderDirectional(bottom: new BorderSide(color: Colors.white10))
                    ),
                  ),
                  new Container(
                      alignment: Alignment.bottomLeft,
                      child: new Text(
                          obj.status.text.length>100?obj.status.text.substring(0,100)+'...':obj.status.text,
                          style: new TextStyle(height: 1.3, color: GlobalConfig.font_color)
                      )
                  ),
                  new Container(
                    child: ImageGridView(imageList: obj.status.images,),
                  ),
                  obj.status.video!=""?
                  vedioWidget:Container(),
                  obj.status.music!=""?
                  Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(width: 1, color: Colors.black26),
                      borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                    ),

                    margin: EdgeInsets.only(top: 5,bottom: 10),
                    child: AudioFileListTile(baseFilePath: obj.status.music,state:0,detailFilePath:obj.status.musicName),
                  ):Container(),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          obj.status.school!=''?Icon(MyFlutterApp2.school,size: 10,color: Colors.black54,):Container(),
                          obj.status.school!=''?Text(obj.status.school,style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54
                          ),):Container(),
                        ],
                      )

                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          obj.status.address!=''?Icon(MyFlutterApp2.address,size: 10,color: Colors.black54,):Container(),
                          obj.status.address!=''?Text(obj.status.address,style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54
                          ),):Container(),
                        ],
                      )
                  ),


                ],
              ),
            ),
            new Container(

              child: new Row(
                children: <Widget>[
                  Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(left: 7),
                          width: 100,
                          child: new Row(
                            children: <Widget>[
                              new Icon(MyFlutterApp.money, size: 20.0, color: FineritColor.color1_normal),
                              new Text(' '+obj.status.fineritCode.split(".")[0],style: TextStyle(color: FineritColor.color1_normal)),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  new Expanded(
                      child:
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(

                            child: new Container(
                              width: 60,
                              child: new Row(
                                children: <Widget>[

                                  obj.like==false?new Icon(MyFlutterApp.like, size: 25.0, color: Colors.black,):Icon(Icons.favorite, size: 25.0, color: FineritColor.color1_pressed,),
                                  new Text(DigitalConversion.longDigitalToShort(obj.likes),style: TextStyle(color: FineritColor.color1_normal)),
                                ],
                              ),
                            ),
                            onTap:(){
                              _handle_like_oprate(obj,index);
                            },
                          ),
                          GestureDetector(
                            child: new Container(
                                width: 60,
                                child: new Row(
                                  children: <Widget>[
                                    new Icon(MyFlutterApp.comment, size: 25.0, color: FineritColor.color1_normal,),
                                    new Text(DigitalConversion.longDigitalToShort(obj.comments),style: TextStyle(color: FineritColor.color1_normal)),
                                  ],
                                )
                            ),
                            onTap: (){
                              _handle_detail_status_to_comment(obj,index);
                            },
                          ),

                          new Container(
                              width: 60,
                              child: new Row(
                                children: <Widget>[
                                  new Icon(MyFlutterApp.look, size: 25.0, color: FineritColor.color1_normal),
                                  new Text(""+DigitalConversion.longDigitalToShort(obj.browses),style: TextStyle(color: FineritColor.color1_normal)),
                                ],
                              )

                          ),

                        ],
                      )
                  ),
                ],
              ),
              padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10),
            ),
          ],
        )

    );
    return widgetAchive;
  }




  Widget _get_vedio_wighet(){
    VideoPlayerController _videoPlayerController=VideoPlayerController.network(obj.status.video);
    _videoPlayerControllers.add(_videoPlayerController);

    if(Platform.isIOS){
      return  Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 5),
        height: MediaQuery.of(context).size.height/1.6,
        width: MediaQuery.of(context).size.width/1.6 ,
        child: Chewie(
          _videoPlayerController,
          aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
          autoPlay: false,
          autoInitialize:true,
          looping: false,

        ),
      );
    }else if(Platform.isAndroid){
      return  Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 5),
        height: MediaQuery.of(context).size.height/1.6,
        width: MediaQuery.of(context).size.width/1.3 ,
        child: Chewie(
          _videoPlayerController,
          aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
          autoPlay: false,
          autoInitialize:true,
          looping: false,

        ),
      );
    }
    else{
      return  Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 5),
        height: MediaQuery.of(context).size.height/1.6,
        width: MediaQuery.of(context).size.width/1.3 ,
        child: Chewie(
          _videoPlayerController,
          aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
          autoPlay: false,
          autoInitialize:true,
          looping: false,

        ),
      );

    }


  }
  void _handle_like_oprate(BBSDetailItem obj,int index){
    obj.like=!obj.like;
    if(obj.like){
      int likes=int.parse(obj.likes)+1;
      obj.likes=likes.toString();
    }
    else{
      int likes=int.parse(obj.likes)-1;
      obj.likes=likes.toString();
    }
    _bbsModel.update(obj, index);
    NetUtil.get(Api.BBS_STATUS_LIKE+obj.status.objectId+'/', (data) async{
      NetUtil.get(Api.BBS_BASE+obj.status.objectId+'/', (data) async{

        var _obj = BBSDetailItem.fromJson(data);
        _bbsModel.update(_obj, index);
        //TODO 界面显示数据
      },
        headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
      );
    },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );

  }
  void _handle_detail_status(BBSDetailItem obj,int index){
    NetUtil.get(Api.BBS_BASE+obj.status.objectId+'/', (data) async{
      BBSDetailItem bbsDetailItem = BBSDetailItem.fromJson(data);
      for(var _videoPlayerController in _videoPlayerControllers){
        if(_videoPlayerController!=null){
          _videoPlayerController.pause();
        }
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>
              ScopedModel<BaseBBSModel>(
                model: _bbsModel,
                child: ReplyPage(bbsDetailItem: bbsDetailItem,index:index),
              )
      ));
    },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }
  void _handle_detail_status_to_comment(BBSDetailItem obj,int index){
    NetUtil.get(Api.BBS_BASE+obj.status.objectId+'/', (data) async{
      BBSDetailItem bbsDetailItem = BBSDetailItem.fromJson(data);
      for(var _videoPlayerController in _videoPlayerControllers){
        if(_videoPlayerController!=null){
          _videoPlayerController.pause();
        }
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>
              ScopedModel<BaseBBSModel>(
                model: _bbsModel,
                child: ReplyPage(bbsDetailItem: bbsDetailItem,index:index,comment: true,),
              )
      ));
    },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }

}

