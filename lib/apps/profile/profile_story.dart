import 'package:finerit_app_flutter/apps/bbs/components/bbs_card.dart';
import 'package:finerit_app_flutter/apps/bbs/state/bbs_state.dart';
import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_story_card.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import "package:flutter/material.dart";
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
class ProfileStoryApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => ProfileStoryAppState();
}

class ProfileStoryAppState extends BBSState<ProfileStoryApp>{
  final String state='自己';
  final String filter='及时动态';
  bool loading=false;
  @override
  Widget get_cart_wighet(int index) {
    // TODO: implement get_cart_wighet
    return ProfileBBSCard<BaseBBSModel>(index:index);
  }
  @override
  Widget build(BuildContext context) {
    if(loading==false){
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      bbsModel=ScopedModel.of<BaseBBSModel>(context,rebuildOnChange: true);
    }
    init_data();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title: Text("微文", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: handle_main_wighet(),
    );
  }
  Widget handle_main_wighet(){
    if(bbsModel.getData()==null||bbsModel.getData().length==0){
      if(loading==true){
        return Container(
          child: new EasyRefresh(
            autoLoad: true,
            key: easyRefreshKey,
            refreshHeader: MaterialHeader(
              key: headerKey,
            ),
            refreshFooter: MaterialFooter(
              key: footerKey,
            ),
            child: new ListView.builder(
              //ListView的Item
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Column(
                      children: <Widget>[
                        Blank(width: MediaQuery.of(context).size.width
                          ,height: MediaQuery.of(context).size.height
                          ,text: '你还没有发布过微文哦～',)
                      ],
                    ),
                  );
                }),
            onRefresh: () async {
              refresh_data();
            },
            loadMore: () async {
              load_more_data();
            },
          ),
        );
      }
      else{
        return SpinKitFadingCircle(color: Color.fromARGB(50, 0, 0, 0),size: 30,);
      }
    }
    else{
      return Container(
        child: new EasyRefresh(
          autoLoad: true,
          key: easyRefreshKey,
          refreshHeader: MaterialHeader(
            key: headerKey,
          ),
          refreshFooter: MaterialFooter(
            key: footerKey,
          ),
          child: new ListView.builder(
            //ListView的Item
              itemCount: bbsModel.getData().length,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Column(
                    children: <Widget>[
                      get_cart_wighet(index)
                    ],
                  ),
                );
              }),
          onRefresh: () async {
            refresh_data();
          },
          loadMore: () async {
            load_more_data();
          },
        ),
      );
    }
  }
  @override
  void handle_filter(FilterMenuItem value) {
  }
}