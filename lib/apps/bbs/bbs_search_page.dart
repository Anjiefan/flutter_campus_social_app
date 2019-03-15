import 'package:finerit_app_flutter/apps/bbs/bbs_search_detail.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_search_recent_item.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_top_search_item_wighet.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/apps/components/hint_wighet.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/sp_util.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchPage extends StatefulWidget{
  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = new TextEditingController();
  StatusModel statusModel;
  StatusTopModel statusTopModel;
  bool initData=false;
  UserAuthModel userAuthModel;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    statusModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    statusTopModel=ScopedModel.of<BaseBBSModel>(context,rebuildOnChange: true);
    userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    if(initData==false){
      _init_search_list_data();
    }

    return new Scaffold(

        appBar: new AppBar(
          leading: BackButton(color: Colors.grey[800],),
          backgroundColor: Colors.white,
          title: new TextField(
            controller: _controller,
            autofocus: true,
            decoration: new InputDecoration.collapsed(
                hintText: "搜索所有校园微文",
                hintStyle: new TextStyle(color: GlobalConfig.font_color)
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(MyFlutterApp.search,color: Colors.black,size: 30,),
              onPressed: (){
                _handle_search_press();
              },
            )
          ],
        ),
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Text("每日热搜榜", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                margin: const EdgeInsets.only(top: 16.0, left: 16.0,bottom: 16),
                alignment: Alignment.topLeft,
              ),
            ]
              ..addAll(get_top_search_wighets())..add( new Container(
              child: new Text("最近搜索", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
              padding: EdgeInsets.only(left: 16.0, right: 16.0,),
              margin: const EdgeInsets.only(top: 16),
              alignment: Alignment.topLeft,
            ))..addAll(_get_search_list_widgets()),
          ),
        )
    );
  }
  void _handle_search_press(){
    statusModel.insert(_controller.text);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context)=>
            ScopedModel<SearchStatusModel>(
              model: SearchStatusModel(),
              child: BBSSearchApp(value:_controller.text),
            )
    ));
  }
  List<Widget> _get_search_list_widgets(){
    List<Widget> searchWidgets=[];
    for(var item in statusModel.searchs){
      searchWidgets.add( SearchRecentItem(value: item));
    }
    return searchWidgets;
  }
  void _init_search_list_data(){
    if(initData==false){
      NetUtil.get(Api.BBS_TOP_SEARCH, (data) {
        var itemList = BBSItemList.fromJson(data);
        initData=true;
        statusTopModel.setData(itemList.data);
        //TODO 界面显示数据
      },
          headers: {"Authorization": "Token ${userAuthModel.session_token}"},
          params: {});
    }
  }
  List<Widget> get_top_search_wighets(){
    List statusList=statusTopModel.getData();
    if(statusList==null||statusList==0){
      if(initData==true){
        return [];
      }
      else{
        return [SpinKitFadingCircle(color: Color.fromARGB(50, 0, 0, 0),size: 30,)];
      }
    }
    else{
      List<Widget> wighetList=[];
      for(var index=0;index<statusList.length;index++){
        wighetList.add(BBSTopSearchWidget(index: index,bbsDetailItem: statusList[index]));
      }
      return wighetList;
    }
  }
}