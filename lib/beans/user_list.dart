

import 'package:finerit_app_flutter/beans/base_user_item.dart';

class UserInfoList {
  List<User> data;
  UserInfoList({this.data});

  UserInfoList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<User>();
      json['data'].forEach((v) {
        data.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

