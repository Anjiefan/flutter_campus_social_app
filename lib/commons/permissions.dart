
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_permissions/simple_permissions.dart';

class FinerPermission{
  static Future<bool> requestLocationPersmission() async {
    bool _hasLocationPersmission =
    await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
    if (!_hasLocationPersmission) {
      PermissionStatus requestPermissionResult =
      await SimplePermissions.requestPermission(
          Permission.WhenInUseLocation);
      if (requestPermissionResult != PermissionStatus.authorized) {
        Fluttertoast.showToast(
            msg: "申请定位权限失败",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            textColor: Colors.black);
        return  false;
      }
      return true;
    }
    else{
      return true;
    }

  }
  static Future<bool> requestWriteExternalStoragePermission() async {
    bool res = await SimplePermissions.checkPermission(
        Permission.WriteExternalStorage);
    if (!res) {
      PermissionStatus requestPermissionResult =await SimplePermissions.requestPermission(
          Permission.WriteExternalStorage);
      if (requestPermissionResult != PermissionStatus.authorized) {
        Fluttertoast.showToast(
            msg: "申请权限失败，无法使用此功能。",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            textColor: Colors.black);
        return  false;
      }
      return true;
    }
    return true;
  }
}