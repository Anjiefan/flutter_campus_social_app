import 'package:finerit_app_flutter/commons/SharedPreferenceUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WelcomeContractApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WelcomeContractAppState();
}

class WelcomeContractAppState extends State<WelcomeContractApp> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  UserAuthModel _userAuthModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebViewPlugin.onDestroy.listen((_) => null);
  }

  @override
  Widget build(BuildContext context) {
    _userAuthModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    return WillPopScope(
      onWillPop: () {
//        showDialog(
//            context: context,
//            barrierDismissible: false,
//            builder: (context) {
//              return AlertDialog(
//                content: Text("您需要同意本协议以使用本APP软件"),
//                title: Text("重要提示"),
//                actions: <Widget>[
//                  FlatButton(
//                    onPressed: () {
//                      Navigator.pop(context);
//                      return false;
//                    },
//                    child: Text("确定"),
//                  )
//                ],
//              );
//            });
      },
      child: WebviewScaffold(
        url: "https://www.finerit.com/media/xieyi.html",
        appBar: AppBar(
          leading: Text(""),
          centerTitle: true,
          title: Text(
            "请仔细阅读协议",
            style: TextStyle(color: Colors.grey[800]),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                SharedPreferenceUtil.setIsReadLicence(true).then((value){
                  Navigator.pop(context);
                });
                _userAuthModel.prefs.setBool('is_read_licence', true);

              },
              child: Text("我同意"),
            )
          ],
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
