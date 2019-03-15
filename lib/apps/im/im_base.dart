import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import "package:flutter/material.dart";
//TODO 临时解决方案
class ChatWebViewApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: "https://leanmessage.leanapp.cn/",
      appBar: new AppBar(
        title: const Text('聊天'),
      ),
      withZoom: false,
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
