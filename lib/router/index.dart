import 'dart:io';

import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_replay_2.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_replay_3.dart';
import 'package:finerit_app_flutter/apps/home/home_base.dart';
import 'package:finerit_app_flutter/apps/im/im_base.dart';

import 'package:finerit_app_flutter/apps/profile/profile_base.dart';
import 'package:finerit_app_flutter/apps/profile/profile_comment.dart';
import 'package:finerit_app_flutter/apps/profile/profile_gallery.dart';
import 'package:finerit_app_flutter/apps/profile/profile_story.dart';
import 'package:finerit_app_flutter/apps/settings/settings_base.dart';
import 'package:finerit_app_flutter/apps/welcome/welcome_base.dart';
import 'package:finerit_app_flutter/apps/welcome/welcome_change_password.dart';
import 'package:finerit_app_flutter/apps/welcome/welcome_splash.dart';
import 'package:finerit_app_flutter/apps/welcome/welcome_splash.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
// 安卓
import 'package:finerit_app_flutter/apps/money/money_base.dart';
// ios
import 'package:finerit_app_flutter/apps/money/money_base_web.dart';
Map<String, WidgetBuilder> getRoutes() {
  Widget appWidget;
  if(Platform.isIOS){
    appWidget=MoneyAppIOS();
  }else if(Platform.isAndroid){
    appWidget=MoneyApp();
  }
  return {
//    '/': (context) => SplashPage(),
    '/': (context) => SplashApp(),
    '/welcome': (context) => WelcomeBaseApp(),
    '/changepassword': (context) => WelcomeChangePasswordApp(),
    '/home': (context) =>HomeApp(),
    '/settings': (context) => SettingsApp(),
    '/profile': (context) => ProfileApp(),
    '/profile/story': (context) => ProfileStoryApp(),
    '/profile/comment': (context) => ProfileCommentApp(),
    '/money': (context) => appWidget,
    '/chat': (context) => ChatWebViewApp(),
    '/replay': (context) => ReplyPage(),
    '/replay2': (context) => Reply2Page(),
    '/replay3': (context) => Reply3Page(),
  };
}
