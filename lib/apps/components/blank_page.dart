import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        leading: BackButton(color: Colors.grey[800],),
        title: Text("错误信息", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: Blank(
        width: MediaQuery.of(context).size.width,
        text: '该文章已被删除或者隐藏',
      ),
    );
  }

}

