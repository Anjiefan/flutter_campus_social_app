import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CourseWebApp extends StatefulWidget {
  final String url;
  const CourseWebApp({
    Key key,
    @required this.url,
  }):
        assert(url != null),
        super(key:key);
  @override
  State<StatefulWidget> createState() =>CourseWebState(this.url);
}

class CourseWebState extends State<CourseWebApp>{
  final String url;
  CourseWebState(this.url);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: const Text('代课系统',style: TextStyle(color:Colors.black),),
        leading: BackButton(
          color: Colors.grey[800],
        ),
        backgroundColor: Colors.white,
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      withJavascript: true,
      initialChild: Container(
        child: const Center(
          child: Text('加载中...'),
        ),
      ),
    );
  }

}
