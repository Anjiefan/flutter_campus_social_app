import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:finerit_app_flutter/extra_apps/chewie/lib/chewie.dart';
import 'package:finerit_app_flutter/apps/components/audio_file_list_tile.dart';
import 'package:finerit_app_flutter/apps/components/audio_recorder_wighet.dart';
import 'package:finerit_app_flutter/apps/components/network_dialog.dart';
import 'package:finerit_app_flutter/commons/NetUtil2.dart';
import 'package:finerit_app_flutter/commons/http_error.dart';
import 'package:finerit_app_flutter/commons/net_load.dart';
import 'package:finerit_app_flutter/commons/permissions.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/extra_apps/audio/audio_recorder.dart';
import 'package:finerit_app_flutter/icons/icons_route2.dart';
import 'package:finerit_app_flutter/icons/icons_route4.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:finerit_app_flutter/apps/components/flare.dart';
import 'package:finerit_app_flutter/apps/components/image_grid_view.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/load_locale_imgs.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:multi_image_picker/asset.dart';
import 'package:multi_image_picker/cupertino_options.dart';
import 'package:multi_image_picker/picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:finerit_app_flutter/extra_apps/location/lib/amap_location.dart';
import 'package:video_player/video_player.dart';
class Talk extends StatefulWidget{
  List<BaseBBSModel> bbsModels;
  Talk({Key key,this.bbsModels}) : super(key: key);
  @override
  _TalkState createState() => new _TalkState(bbsModels: bbsModels);
}

class _TalkState extends State<Talk> with SingleTickerProviderStateMixin{
  List<BaseBBSModel> bbsModels;
  var _textController = new TextEditingController();
  var _scrollController = new ScrollController();
  bool talkFOT = false;
  bool otherFOT = false;
  FocusNode _focusNode;
  bool ifFocus=true;
  Animation animationTalk;
  AnimationController controller;
  VideoPlayerController _videoPlayerController;
  List<VideoPlayerController> _videoPlayerControllers=[];
  var cameras;
  bool _value = false;
  List<Asset> images = List<Asset>();
  File _image;
  String _error;
  double finerCode=0;
  List<Asset> resultList;
  String error;
  AMapLocation _loc;
  Future<Null> init_cameras() async{
    cameras = await availableCameras();
  }
  String _vedioPath;
  String _voiceName;
  File _vedio;
  String _voicePath;
  bool change=false;
  VoiceModel _voiceModel;
  _TalkState({this.bbsModels}):super();
  @override
  void initState() {
    init_cameras();
    _textController.addListener((){
      if(change){
        change=false;
        return ;
      }
      if(talkFOT&&_focusNode.hasFocus==false){
        if(!this.mounted){
          return;
        }
        setState(() {
          talkFOT=false;
        });
      }
    });
    AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    controller = new AnimationController(duration: new Duration(seconds: 1), vsync: this);
    animationTalk = new Tween(begin: 1.0, end: 1.5).animate(controller)
      ..addStatusListener((state){
        if(state == AnimationStatus.completed) {
          controller.reverse();
        } else if (state == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    _focusNode=FocusNode();
    super.initState();

  }
  @override
  void dispose() {
    if(controller!=null){
      controller.dispose();
    }
    if(_textController!=null){
      _textController.dispose();
    }
    for(var _videoPlayerController in _videoPlayerControllers){
      if(_videoPlayerController!=null){
        _videoPlayerController.dispose();
      }
    }
    AMapLocationClient.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final model = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    _voiceModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    return new WillPopScope(
      onWillPop: (){
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
      },
      child:  new Scaffold(
          appBar: AppBar(
            leading:IconButton(
                icon:Text('取消',style: TextStyle(color: FineritColor.color2_normal),),
                color: FineritColor.color1_normal,
                onPressed: (){
                  _voiceModel.voiceFile=null;
                  Navigator.of(context).pop();
                }

            ),
            backgroundColor:Colors.white ,
            centerTitle: true,
            title:Text('发布微文',style: TextStyle(color: FineritColor.color2_normal)),
            actions: <Widget>[
              IconButton(
                icon:Text('发布',style: TextStyle(color: FineritColor.color2_normal),),
                color: FineritColor.color1_normal,
                onPressed: (){
                  if(model.ifAgreeEULA==null||model.ifAgreeEULA==false){
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, a, b) => AlertDialog(
                        title: Text('发布微文不得包含以下内容'),
                        content: Container(
//                          width: MediaQuery.of(context).size.width * 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '（一）煽动抗拒、破坏宪法和法律、行政法规实施的',
                              ),
                              Text(
                                  '（二）煽动颠覆国家政权，推翻社会主义制度的'
                              ),
                              Text(
                                  '（三）煽动分裂国家、破坏国家统一的'
                              ),
                              Text(
                                  '（四）煽动民族仇恨、民族歧视，破坏民族团结的'
                              ),
                              Text(
                                  '（五）捏造或者歪曲事实，散布谣言，扰乱社会秩序的'
                              ),
                              Text(
                                  '（六）宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的'
                              ),
                              Text(
                                  '（七）公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的'
                              ),
                              Text(
                                  '（八）损害国家机关信誉的；（九）其他违反宪法和法律行政法规的'
                              ),
                              Text(
                                  '（九）其他违反宪法和法律行政法规的'
                              ),
                              Text(
                                  '（十）进行商业广告行为的'
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('取消'),
                            onPressed: () {
                              requestToast('拒绝同意协议，您将无法发布微文');
                              Navigator.pop(context);

                            },
                          ),
                          FlatButton(
                            child: Text('确认'),
                            onPressed: () async {
                              model.ifAgreeEULA=true;
                              requestToast('已同意协议，可以发布微文');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      barrierDismissible: false,
                      barrierLabel: '删除微文',
                      transitionDuration: Duration(milliseconds: 400),
                    );

                  }
                  else{
                    showDialog(
                        context: context,builder: (context){
                      return StatefulBuilder(
                          builder: (context, state) {
                            return new FinerFlareGiffyDialog(
                              flarePath: 'assets/space_demo.flr',
                              flareAnimation: 'loading',
                              title:Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 5,right: 5),
                                child:  Column(
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        Icon(Icons.camera),
                                        Text("带凡尔币悬赏能增大文章曝光率哦！"
                                          ,textAlign: TextAlign.center,
                                          style: TextStyle( fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        Icon(Icons.local_atm),
                                        Text("每日热度最高的前2%的文章所有者"
                                          ,textAlign: TextAlign.center,
                                          style: TextStyle( fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text('将获取大量凡尔币奖励！' ,textAlign: TextAlign.left,
                                        style: TextStyle( fontWeight: FontWeight.w600),),
                                    )
                                  ],
                                ),
                              ),

                              description:new SliderTheme(
                                data: SliderTheme.of(context).copyWith(
//                activeTickMarkColor:Colors.yellowAccent,
                                  activeTrackColor: Colors.yellowAccent,//实际进度的颜色
//                inactiveTickMarkColor:Colors.black
                                  thumbColor: Colors.black,//滑块中心的颜色
                                  inactiveTrackColor:Colors.red,//默认进度条的颜色
                                  valueIndicatorColor: Colors.blue,//提示进度的气派的背景色
                                  valueIndicatorTextStyle: new TextStyle(//提示气泡里面文字的样式
                                    color: Colors.white,
                                  ),
                                  inactiveTickMarkColor:Colors.blue,//divisions对进度线分割后 断续线中间间隔的颜色
                                  overlayColor: Colors.pink,//滑块边缘颜色
                                ),
                                child: new Container(
                                  margin: EdgeInsets.only(left: 5,right: 5),
                                  width: 340.0,
                                  child: new Row(
                                    children: <Widget>[
                                      new Text('0'),
                                      new Expanded(
                                        flex: 1,
                                        child: new Slider(
                                          value: finerCode,
                                          label: '$finerCode',
                                          divisions: 150,
                                          onChanged: (double){
                                            state(() {
                                              finerCode=double.floorToDouble();//转化成double
                                            });
                                          },
                                          min: 0,
                                          max: 150,
                                        ),
                                      ),
                                      new Text('150'),
                                    ],
                                  ),
                                ),
                              ),
                              buttonOkText:Row(
                                children: <Widget>[
                                  Icon(Icons.local_atm),
                                  Text('${finerCode.toInt()}')
                                ],
                              ),
                              buttonCancelText: Text('取消'),
                              onOkButtonPressed: () async {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (_) {
                                      return new NetLoading(
                                        requestCallBack: _handle_send_status(model),
                                        outsideDismiss: true,
                                        loadingText: '发布微文中...',
                                      );

                                    });

                              },
                            );
                          }
                      );
                    }
                    );
                  }

                },
              ),
            ],
          ),
          body:  GestureDetector(
            onTap: (){
              if(!this.mounted){
                return;
              }
              setState(() {
                FocusScope.of(context).requestFocus(FocusNode());
                talkFOT=false;
              });
            },
            child: new Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child:
                new Stack(
                  children: <Widget>[
                    Theme(
                        data: ThemeData(
                            primaryColor: Colors.white,
                            accentColor: Colors.white,
                            hintColor: Colors.white),
                        child: Container(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              TextField(
                                focusNode: _focusNode,
                                controller: _textController,
                                maxLines:4,
                                autofocus:true,
                                cursorColor:FineritColor.color2_normal,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                              ),
                            ],
                          ),

                        )
                    ),
                    new Container(
                      padding: new EdgeInsets.only(bottom: 50.0,top: 100),
                      alignment: Alignment.center,
                      // width: MediaQuery.of(context).size.width - 40.0,
                      child: ListView(
                        controller: _scrollController,
                        children: <Widget>[ new FlatButton(
                            onPressed: null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                images.length!=0?AssertGridView(imageList: images,):Container(),
                                _image != null
                                    ? new Container(
                                  alignment: Alignment.center,
                                  width: 180.0,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(_image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ):Container(),
                                _vedio!=null?Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 5),
                                  height: MediaQuery.of(context).size.height/1.6,
                                  width: MediaQuery.of(context).size.width/1.3,
                                  child: _get_vedio_wighet(),
                                ):Container(),
                                _voiceModel.voiceFile!=null?
                                Container(

                                  decoration: new BoxDecoration(
                                    border: new Border.all(width: 1, color: Colors.black26),
                                    borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                                  ),

                                  margin: EdgeInsets.only(top: 5,bottom: 10),
                                  child: AudioFileListTile(state: 1,),
                                )
//                                AudioFileListTile(state: 1,)
                                    :Container(),
                                getAddressWidget(),

                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text('显示地点'),
                                      Switch(value: _value, onChanged: _onChanged)
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),],
                      ),
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
//                        new Border.all(width: 0.3, color: Colors.black),
                          ),
                          child: new Column(
                            children: <Widget>[


                              new Offstage(
                                offstage: talkFOT,
                                child:  new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      icon: new Icon(MyFlutterApp2.voice, color: Color(0xFF707072)),
                                      onPressed: (){
                                        if(!this.mounted){
                                          return;
                                        }
                                        setState(() {
                                          change=true;
                                          talkFOT = !talkFOT;
                                          otherFOT = false;
                                        });
                                        FocusScope.of(context).requestFocus(FocusNode());
                                      },
                                    ),
                                    IconButton(
                                      icon: new Icon(MyFlutterApp2.image, color: Color(0xFF707072)),
                                      onPressed: loadAssets,
                                    ),
                                    IconButton(
                                        icon: new Icon(MyFlutterApp2.camera, color: Color(0xFF707072)),
                                        onPressed: () {
                                          getImageByCamera();
                                        }
                                    ),

                                    new IconButton(
                                      icon: Icon(MyFlutterApp2.video, color: Color(0xFF707072)),
                                      onPressed: (){
                                        getVedio();
                                      },
                                    ),
                                    new IconButton(
                                      icon: Icon(MyFlutterApp2.jianpan, color: Color(0xFF707072)),
                                      onPressed: (){
                                        if(!this.mounted){
                                          return;
                                        }
                                        setState(() {
                                          if(ifFocus){
                                            FocusScope.of(context).requestFocus(FocusNode());
                                            ifFocus=!ifFocus;
                                          }
                                          else{
                                            FocusScope.of(context).requestFocus(_focusNode);
                                            ifFocus=!ifFocus;
                                          }
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              new Offstage(
                                offstage: !talkFOT,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: new IconButton(
                                        icon: Icon(MyFlutterApp4.left,color: Colors.black,),
                                        onPressed: (){
                                          controller.reset();
                                          controller.stop();
                                          FocusScope.of(context).requestFocus(_focusNode);
                                          if(!this.mounted){
                                            return;
                                          }
                                          setState(() {
                                            talkFOT = !talkFOT;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 300,
                                      child: AudioRecorderWidget(callback: (){
                                        if(!this.mounted){
                                          return;
                                        }
                                        setState(() {
                                          FocusScope.of(context).requestFocus(_focusNode);
                                          _vedio=null;
                                          _image=null;
                                          images=[];
                                          talkFOT = !talkFOT;
                                        });
                                      },),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ],
                )
            ),
          )


      ),
    );
  }
  Widget _get_vedio_wighet(){
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
  Future<List<String>> _get_image_paths() async {
    List<String> filesPath=[];
    for(Asset image in images){
      File file=await writeToFile(image.thumbData,image.name);
      await NetUtil.putFile(file, (value){
        Map uploadInfo = json.decode(value);
        filesPath.add(uploadInfo["url"]);
      });
    }
    return filesPath;
  }
  Future<List<String>> _get_image_path() async{
    List<String> filesPath=[];
    if(_image!=null){
      await NetUtil.putFile(_image, (value){
        Map uploadInfo = json.decode(value);
        filesPath.add(uploadInfo["url"]);

      });
    }
    return filesPath;
  }
  Future<String> _get_vedio_path() async{
    if(_vedio!=null){
      await NetUtil.putFile(_vedio, (value){
        Map uploadInfo = json.decode(value);

        _vedioPath=uploadInfo["url"];
      });
    }
    return _vedioPath;
  }
  Future<String> _get_voice_path() async{
    if(_voiceModel.voiceFile!=null){
      await NetUtil.putFile(_voiceModel.voiceFile, (value){
        Map uploadInfo = json.decode(value);
        _voicePath=uploadInfo["url"];
        _voiceName=uploadInfo["name"];
      });
    }
    return _voicePath;
  }
  Future _handle_send_status(MainStateModel model) async {
    bool ifPermis=await FinerPermission.requestLocationPersmission();
    UserInfoModel userInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    if(ifPermis==false){
      requestToast('定位权限未开启，无法发表微文~');
      return;
    }
    if(ifPermis==true){
      List<String> imagesPath=await _get_image_paths();
      if(_image!=null){
        imagesPath=await _get_image_path();
      }
      String vedio=await _get_vedio_path();
      String voice_path=await _get_voice_path();
      await _getLocation();
      var address=_value?_loc.POIName:'';

      await NetUtil2().post(Api.BBS_BASE, (data) async{
        var id=data['objectId'];

        await NetUtil2().get(Api.BBS_BASE+id+'/', (data) {
          BBSDetailItem bbsDetailItem=BBSDetailItem.fromJson(data);
          for(BaseBBSModel bbsModel in bbsModels){
            bbsModel.addBegin(bbsDetailItem);
          }
          requestToast("发布微文成功");
          Navigator.popUntil(context, ModalRoute.withName('/home'));
          _voiceModel.voiceFile=null;
        },
          headers: {"Authorization": "Token ${model.session_token}"},
        );
      },
          params: {
            "images": imagesPath,
            "text": _textController.text,
            "video": _vedioPath==null?'':_vedioPath,
            "music": _voicePath==null?'':_voicePath,
            "music_name": _voiceName==null?'':"0"+_voiceName,
            "finerit_code": finerCode.toInt(),
            "latitude": _loc.latitude,
            "longitude": _loc.longitude,
            "address": address,
            'school':userInfoModel.userInfo.schoolName
          },
          headers: {"Authorization": "Token ${model.session_token}"},
          errorCallBack: (data){
            requestToast(HttpError.getErrorData(data).toString());
          }
      );

    }

  }
  Future<File> writeToFile(ByteData data, String path) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    final buffer = data.buffer;
    return new File(appDocDirectory.path+"/"+path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
  Future _getLocation() async {
    bool ifPermis=await FinerPermission.requestLocationPersmission();
    if(ifPermis){
      AMapLocation loc = await AMapLocationClient.getLocation(true);
      if(_loc==null){
        if(!this.mounted){
          return;
        }
        setState(() {
          _loc = loc;
        });
        return ;
      }
      if(_loc.formattedAddress==null){
        if(!this.mounted){
          return;
        }
        setState(() {
          _loc = loc;
        });
        return ;
      }
      if(_loc.formattedAddress!=loc.formattedAddress&&loc!=null){
        if(!this.mounted){
          return;
        }
        setState(() {
          _loc = loc;
        });
      }
    }
  }
  void  getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  }
  void getVedio() async{
    _vedio =  await ImagePicker.pickVideo(source: ImageSource.gallery);
    _videoPlayerController=VideoPlayerController.file(_vedio);
    _videoPlayerControllers.add(_videoPlayerController);
    if(!this.mounted){
      return;
    }
    setState(() {
      _vedio=_vedio;
      _image=null;
      images=[];
      _voiceModel.voiceFile=null;
    });
  }
  void _onChanged(bool value) {
    if(!this.mounted){
      return;
    }
    setState(() => _value = value);}
  Widget getAddressWidget(){
    if(_value){
      _getLocation();
      return new Container(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            Icon(MyFlutterApp2.address),
            _loc == null
                ? new Text("正在定位")
                :
            new Text(
              "${_loc.POIName}",
              maxLines: 5,
            ),
          ],
        ),
      );
    }
    else{
      return Container();
    }
  }
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        return AssetView(index, images[index]);
      }),
    );
  }
  Future<void> loadAssets() async {
    if(!this.mounted){
      return;
    }
    setState(() {
      images = List<Asset>();
    });
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: true,
        options: CupertinoOptions(takePhotoIcon: "chat"),
      );
    } on PlatformException catch (e) {
      error = e.message;
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
      _image=null;
      _vedio=null;
      _voiceModel.voiceFile=null;
      if (error == null) _error = 'No Error Dectected';
    });

  }
  void getImageByCamera() async{
    _image = await ImagePicker.pickImage(source: ImageSource.camera);
    if(_image!=null){
      if(!this.mounted){
        return;
      }
      setState(() {
        _image=_image;
        images=[];
        _vedio=null;
        _voiceModel.voiceFile=null;
      });
    }
  }
}