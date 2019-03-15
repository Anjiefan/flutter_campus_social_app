import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

abstract class PageState<T extends StatefulWidget> extends State{
  GlobalKey<EasyRefreshState> easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> headerKey =
  new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> footerKey =
  new GlobalKey<RefreshFooterState>();
  bool loading=false;
  var page=1;
  Future load_more_data();
  Future refresh_data();
  Future init_data();
}