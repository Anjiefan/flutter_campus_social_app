import 'dart:io';

import 'package:finerit_app_flutter/extra_apps/chewie/lib/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CourseEducationShuakeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CourseEducationShuakeState();
}

class CourseEducationShuakeState extends State<CourseEducationShuakeApp> {
  VideoPlayerController _videoPlayerController =
      new VideoPlayerController.network(
          'https://www.finerit.com/media/course.mp4');
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_videoPlayerController!=null){
      _videoPlayerController.dispose();
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        child: new Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/course.png')),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: new Row(children: [
                      new Expanded(
                          child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            new Container(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: new Text('代课系统操作指南',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ))),
                            new Text('更多实时信息点击右上角关注公众号和微博，系统出现问题可实时联系站长',
                                style: new TextStyle(color: Colors.grey[500])),
                          ])),
                    ])),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        '操作说明：',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                Text('       使用对应网站的账号密码进行登录，登录进' +
                    '网站后，点击开始代课按钮，后将会显示该课程的章节信息，继而点击代课按钮开始每章节的代课' +
                    '以下是智慧树（知道）特有的功能：点击开始考试，进入章节考试页面，有两个按钮，单章节考试' +
                    '和一键全部自动考完。点击左上角三个横线将会显示见' +
                    '面课的按钮，点击可进入见面课刷课页面，操作和普通课程刷课步骤类似。'),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        '视频教程：',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                _get_vedio_wighet(),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        '尔雅错误解决方案：',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                Text('       1.    此类特殊章节不给予考试'),
                Text(
                    '       前往尔雅检查该视频此课程类型是否是单章节完成才解锁下一章节的类型课程，如果是此类型，需要用户手动完成课后答题后，解锁下一章节，再于刷课系统中点击更新刷课详情后，再刷下一个章节，反之，如果此类课程章节全部解锁，可一直点击刷课，将所有章节视频刷完。'),
                Text('       2.    信息提交异常，请点击更新课程详情'),
                Text(
                    '       按提示，点击更新课程详情，如果点击后依旧出现此信息，可能原因是，此章节视频和答题都已经完成，但是尔雅（学习通）那边并没有进行信息更新，前往尔雅（学习通）进行查看，如果发现视频和答题都已经完成，于官网中对该章节课程进行更新和下章节解锁，完成操作后回到刷课系统中点击更新课程详情，此时再点击刷课，即会开始下一章节的刷课了。'),
                Text('       3.    首页显示课程信息为空'),
                Text(
                    '       点击右上角头像，退出当前账户，重新登录一次即可，注意不要回到第一层登录页面，一定要退回到尔雅登录页面，即第二层登录页面。'),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        '智慧树错误解决方案：',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                Text('       1.    见面课章节数量与官网章节不对应'),
                Text('       刷完当前所显示的见面课，完成后点击更新课程'),
                Text('       2.    考试章节数量与官网章节不对应'),
                Text('       刷完当前所有考试章节后，点击更新课程'),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        '尔雅学习通出现不良解决方案(智慧树知到无不良)：',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                Text(
                    '       目前尔雅系统有几率出现一次不良（零几率出现两次），出现一次不良不会停封账号，可能将会取消成绩，看每个学校处理制度，大部分学校都不处理，请用户自行打听）'),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        '注意事项：',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                Text(
                    '       1.    目前答题系统中，高数课程题目都是图片题，系统无法识别及找寻答案，所以刷高数课的，答题请手动答题。'),
                Text('       2.    部分稀缺课程题库有遗漏，如果答题分数较低，不满意可使用免费的搜题系统手动答题，后更新课程。'),
              ],
            )));
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
}
