import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';


/// SharedPreferences Util.
class SpUtil {
  static SpUtil _singleton;
  static SharedPreferences prefs;
  static Lock _lock = Lock();

  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // 保持本地实例直到完全初始化。
          var singleton = SpUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  SpUtil._();

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    if (prefs == null) return null;
    return prefs.getString(key);
  }

  static Future<bool> putString(String key, String value) {
    if (prefs == null) return null;
    return prefs.setString(key, value);
  }

  static bool getBool(String key) {
    if (prefs == null) return null;
    return prefs.getBool(key);
  }

  static Future<bool> putBool(String key, bool value) {
    if (prefs == null) return null;
    return prefs.setBool(key, value);
  }

  static int getInt(String key) {
    if (prefs == null) return null;
    return prefs.getInt(key);
  }

  static Future<bool> putInt(String key, int value) {
    if (prefs == null) return null;
    return prefs.setInt(key, value);
  }

  static double getDouble(String key) {
    if (prefs == null) return null;
    return prefs.getDouble(key);
  }

  static Future<bool> putDouble(String key, double value) {
    if (prefs == null) return null;
    return prefs.setDouble(key, value);
  }

  static List<String> getStringList(String key) {
    return prefs.getStringList(key);
  }

  static Future<bool> putStringList(String key, List<String> value) {
    if (prefs == null) return null;
    return prefs.setStringList(key, value);
  }

  static dynamic getDynamic(String key) {
    if (prefs == null) return null;
    return prefs.get(key);
  }

  static Set<String> getKeys() {
    if (prefs == null) return null;
    return prefs.getKeys();
  }

  static Future<bool> remove(String key) {
    if (prefs == null) return null;
    return prefs.remove(key);
  }

  static Future<bool> clear() {
    if (prefs == null) return null;
    return prefs.clear();
  }

  ///Sp is initialized.
  static bool isInitialized() {
    return prefs != null;
  }
}
