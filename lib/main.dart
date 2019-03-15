import 'package:finerit_app_flutter/extra_apps/location/lib/amap_location.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/router/index.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  //设置ios的key
  AMapLocationClient.setApiKey("");
  SharedPreferences _prefs=await SharedPreferences.getInstance();
  MainStateModel model = MainStateModel(_prefs);
  runApp(
      ScopedModel<MainStateModel>(
        model: model,
        child:  MaterialApp(
          title: "云智校",
          theme: ThemeData(
          ),
          initialRoute: "/",
          //route configuration
          routes: getRoutes(),
        ),
      )
  );
}
