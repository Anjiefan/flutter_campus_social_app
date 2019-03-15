import 'dart:io';

import 'package:finerit_app_flutter/extra_apps/chewie/lib/chewie.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_user_head_wighet.dart';
import 'package:finerit_app_flutter/apps/components/audio_file_list_tile.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_attention.dart';
import 'package:finerit_app_flutter/apps/components/image_grid_view.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/beans/award_list.dart';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';

class ProfileBBSCard extends StatefulWidget{
  StatusAward status;
  User user;
  String sincePosted;
  int type;
  ProfileBBSCard({
    key,
    this.status,
    this.sincePosted,
    this.user,
    this.type=0,
  }):super(key: key);
  @override
  State<StatefulWidget> createState()=>ProfileBBSCardState(status: status,user: user,sincePosted: sincePosted,type: type);

}

class ProfileBBSCardState<T extends Model> extends State<ProfileBBSCard>{
  List<VideoPlayerController> _videoPlayerControllers=[];
  StatusAward status;
  String sincePosted;
  Widget widgetAchive;
  int type;
  UserAuthModel _userAuthModel;
  User user;
  ProfileBBSCardState({
    key,
    this.status,
    this.sincePosted,
    this.user,
    this.type=0
  }):super();
  @override
  void dispose() {
    // TODO: implement dispose
    for(var _videoPlayerController in _videoPlayerControllers){
      _videoPlayerController.dispose();
    }
    super.dispose();

  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _userAuthModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);

    Widget vedioWidget;
    if(status.video!=""){
      vedioWidget=_get_vedio_wighet();
    }
    widgetAchive=new Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Container(
          decoration:BoxDecoration(
              color: Colors.white,
              boxShadow:[new BoxShadow(
                color: Colors.black38,
                blurRadius: 0.1,
              ),],
            borderRadius:BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              new FlatButton(

                onPressed: (){
                  _handle_detail_status();
                },
                padding: EdgeInsets.all(5),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      child: new Container(
                        child: new Row(
                          children: <Widget>[
                            UserHead(username: user.nickName
                                , sincePosted: sincePosted
                                ,headImg: user.headImg,
                            userInfo: user,),
                            type==0?BBSAttention(user: user):Container(),
                          ],
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
                            status.text.length>100?status.text.substring(0,100)+'...':status.text,
                            style: new TextStyle(height: 1.3, color: GlobalConfig.font_color)
                        )
                    ),
                    new Container(
                      child: ImageGridView(imageList: status.images,),
                    ),
                   status.video!=""?
                   vedioWidget:Container(),
                    status.music!=""?
                    Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(width: 1, color: Colors.black26),
                        borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                      ),
                      margin: EdgeInsets.only(top: 5,bottom: 10),
                      child: AudioFileListTile(baseFilePath: status.music,state:0,detailFilePath:status.musicName),
                    ):Container(),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            status.school!=''?Icon(Icons.account_balance,size: 20,color: Colors.black12,):Container(),
                            status.school!=''?Text(status.school,style: TextStyle(
                                fontSize: 10,
                                color: Colors.black12
                            ),):Container(),
                          ],
                        )

                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            status.address!=''?Icon(Icons.add_location,size: 20,color: Colors.black12,):Container(),
                            status.address!=''?Text(status.address,style: TextStyle(
                                fontSize: 10,
                                color: Colors.black12
                            ),):Container(),
                          ],
                        )
                    ),


                  ],
                ),
              ),
            ],
          ),
        )

    );
    return widgetAchive;
  }

  Widget _get_vedio_wighet(){
    VideoPlayerController _videoPlayerController=VideoPlayerController.network(status.video);
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
  void _handle_detail_status(){
    NetUtil.get(Api.BBS_BASE+status.objectId+'/', (data) async{
      BBSDetailItem bbsDetailItem = BBSDetailItem.fromJson(data);
      AwardStatusModel awardStatusModel=AwardStatusModel();
      awardStatusModel.setData([bbsDetailItem]);
      for(var _videoPlayerController in _videoPlayerControllers){
        if(_videoPlayerController!=null){
          _videoPlayerController.pause();
        }
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>
              ScopedModel<BaseBBSModel>(
                model: awardStatusModel,
                child: ReplyPage(bbsDetailItem: bbsDetailItem,index:0),
              )
      ));
    },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
    );
  }
}

