import 'dart:io';

import 'package:finerit_app_flutter/extra_apps/chewie/lib/chewie.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/apps/components/audio_file_list_tile.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_attention.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_feedback_status_widget.dart';
import 'package:finerit_app_flutter/apps/components/image_grid_view.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/digital_conversion.dart';
import 'package:finerit_app_flutter/icons/icons_route2.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';

class BBSDetailWordCard extends StatefulWidget{
  BBSDetailItem obj;
  int index;
  BBSDetailWordCard({
    key
    ,@required this.obj
    ,this.index
  }):super(key: key);
  @override
  State<StatefulWidget> createState() =>BBSDetailWordCardState(obj:obj,index: index);

}

class BBSDetailWordCardState extends State<BBSDetailWordCard>{
  List<VideoPlayerController> _videoPlayerControllers=[];
  BBSDetailItem obj;
  int index;
  UserAuthModel _userAuthModel;
  BaseBBSModel _bbsModel;
  BBSDetailWordCardState({
    key
    ,@required this.obj
    ,this.index
  }):super();
  @override
  void dispose() {
    // TODO: implement
    for(var _videoPlayerController in _videoPlayerControllers){
      if(_videoPlayerController!=null){
        _videoPlayerController.dispose();
      }
    }
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    _bbsModel = ScopedModel.of<BaseBBSModel>(context,rebuildOnChange: true);
    _userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    obj=_bbsModel.getData()[index];
    return new Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: new Container(
                  child: new Row(
                    children: <Widget>[
                      UserHead(username: obj.user.nickName
                          ,sincePosted: obj.sincePosted
                          ,headImg: obj.user.headImg,
                      userInfo: obj.user,),
                      BBSAttention(user: obj.user),
                      FeedBackWidgetStatus(index: index,obj: obj,bbsModel: _bbsModel,)
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 15,top: 5),
                ),
                decoration: new BoxDecoration(
                    color: GlobalConfig.card_background_color,
                    border: new BorderDirectional(bottom: new BorderSide(color: Colors.white10))
                ),
              ),
              new Container(
                color: Colors.white,
                alignment: Alignment.topLeft,
                child: new Text(obj.status.text,
                    style: new TextStyle(height: 1.4, fontSize: 13.0, color: Colors.black54), textAlign: TextAlign.start
                ),
                padding: EdgeInsets.only(left: 15,right: 20),
              ),
              obj.status.video!=""?_get_vedio_wighet():Container(),
              obj.status.music!=""?
              Container(
                decoration: new BoxDecoration(
                  border: new Border.all(width: 1, color: Colors.black26),
                  borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                ),

                margin: EdgeInsets.only(top: 5,bottom: 10,left: 10),
                child: AudioFileListTile(baseFilePath: obj.status.music,state:0,detailFilePath:obj.status.musicName),
              ):Container(),
              new Container(
                  padding: EdgeInsets.only(left: 15),
                  child: ImageGridView(imageList: obj.status.images,),
              ),
              Container(
                  margin: EdgeInsets.only(left: 15),
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
                  margin: EdgeInsets.only(left: 15),
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
              new Container(
//                height: 30,
                color: Colors.white,
                child: new Row(
                  children: <Widget>[
                    Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Container(
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
                                _handle_like_oprate();
                              },
                            ),

                            new Container(
                              width: 60,
                              child: new Row(

                                children: <Widget>[
                                  new Icon(MyFlutterApp.comment, size: 25.0, color: FineritColor.color1_normal,),
                                  new Text(DigitalConversion.longDigitalToShort(obj.comments),style: TextStyle(color: FineritColor.color1_normal)),
                                ],
                              ),
                            ),
                            new Container(
                              width: 60,
                              child: new Row(

                                children: <Widget>[
                                  new Icon(MyFlutterApp.look, size: 25.0, color: FineritColor.color1_normal),
                                  new Text(DigitalConversion.longDigitalToShort(obj.browses),style: TextStyle(color: FineritColor.color1_normal)),
                                ],
                              ),
                            ),

                          ],
                        )
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15),
              ),
            ],
          ),
        )
    );
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
        padding: EdgeInsets.only(left: 15,right: 20),
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
        padding: EdgeInsets.only(left: 15,right: 20),
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
        padding: EdgeInsets.only(left: 15,right: 20),
      );

    }


  }
  void _handle_like_oprate(){
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

}