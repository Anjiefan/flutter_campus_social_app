import 'package:finerit_app_flutter/commons/http_error.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

void requestToast(String value){
  Fluttertoast.showToast(
      msg: value,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.black12,
      textColor: Colors.black,
      fontSize: 16.0
  );
}

void requestErrorDialog(BuildContext context,Map data){
  showDialog(
      context:context,builder: (_) => AssetGiffyDialog(
    title: Text('错误', style: TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w600)),
    imagePath: 'assets/sorry.gif',
    description: Text(HttpError.getErrorData(data).toString(),textAlign: TextAlign.center,),
    onOkButtonPressed:(){
      Navigator.pop(context);
    },
    buttonOkText:Text('确定'),
    buttonCancelText: Text('取消'),
  )
  );
}