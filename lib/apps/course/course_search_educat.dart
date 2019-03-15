import 'package:finerit_app_flutter/extra_apps/chewie/lib/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CourseEducationSearchApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CourseEducationSearchState();
}

class CourseEducationSearchState extends State<CourseEducationSearchApp> {
  final VideoPlayerController _videoPlayerController1 =
      new VideoPlayerController.network(
    'https://www.finerit.com/media/search_0.mp4',
  );
  final VideoPlayerController _videoPlayerController2 =
      new VideoPlayerController.network(
    'https://www.finerit.com/media/search_1.mp4',
  );

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/sousuoying.jpg')),
          Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
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
          Text(
              '       搜题系统中涵盖尔雅，学习通，智慧树，知道，新锦城，高校邦，优学院，学堂云幕课等多个平台题目，引擎用存有数百万题库，并会对当前不存在的题目进行实时爬取。'),
          Text('       注：题库实时爬取，搜索的时候，如果第一次没有搜到答案，可尝试第二次搜索（一般两次即可搜出答案）'),
          new Chewie(
            _videoPlayerController1,
            aspectRatio: 3 / 2,
            autoPlay: false,
            autoInitialize: true,
            looping: false,
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: new Row(children: [
                new Expanded(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text('附上搜题系统PC端的网址：'),
                      Text('https://www.finerit.com  ',
                          style:
                              new TextStyle(color: Colors.blue, fontSize: 20))
                    ])),
              ])),
          new Chewie(
            _videoPlayerController2,
            aspectRatio: 3 / 2,
            autoPlay: false,
            autoInitialize: true,
            looping: false,
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: new Row(children: [
                new Expanded(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text('由于智慧树考试题目不能复制，附上解决方案：视频中搜索所用的代码提供给大家：：'),
                      Text('<div class="subject_type_describe fl">  ',
                          style: new TextStyle(color: Colors.red, fontSize: 18))
                    ])),
              ])),
        ]),
      ),
    );
  }
}
