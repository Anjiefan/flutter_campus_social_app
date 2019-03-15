//TODO 抽取本地SharedPreference管理
import 'dart:convert';

import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceUtil{
  static Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

  static Future<String> getObjectId() async {
      SharedPreferences sharedPreferences = await _sharedPreferences;
      return sharedPreferences.getString("objectId");
  }

  static Future<String> getSessionToken() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString("session_token");
  }

  static Future<String> getSessionId() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString("session密码登录"
        "id");
  }

  static Future<String> getPhone() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString("phone");
  }

  static Future<String> getNickName() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString("nick_name");
  }

  static Future<String> getHeadImg() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString("head_img");
  }

  static Future<String> getPassword() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString("password");
  }

  static Future<int> getMessageLikeCount() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getInt("message_like_count");
  }

  static Future<int> getMessageCommentCount() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getInt("message_comment_count");
  }

  static Future<bool> getIsReadLicence() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getBool("is_read_licence");
  }

  static Future<User> getUserInfo() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    String jsonString = sharedPreferences.getString("userinfo");
    return User.fromJson(json.decode(jsonString));
  }

  static Future setObjectId(String objectId) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString("objectId", objectId);
  }

  static Future setSessionToken(String sessionToken) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString("session_token", sessionToken);
  }

  static Future setSessionId(String sessionId) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString("sessionid", sessionId);
  }

  static Future setPhone(String phone) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString("phone", phone);
  }

  static Future setNickName(String nickName) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString("nick_name", nickName);
  }

  static Future setHeadImg(String headImg) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString("head_img", headImg);
  }
  static Future setPassword(String password) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString("password", password);
  }

  static Future setMessageLikeCount(int messageLikeCount) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setInt("message_like_count", messageLikeCount);
  }

  static Future setMessageCommentCount(int messageCommentCount) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setInt("message_comment_count", messageCommentCount);
  }

  static Future setIsReadLicence(bool isReadLicence) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setBool("is_read_licence", isReadLicence);
  }

  static Future setUserInfo(User user) async{
    SharedPreferences sharedPreferences = await _sharedPreferences;
    String jsonString = json.encode(user.toJson());
    sharedPreferences.setString("userinfo", jsonString);
  }


}