
import 'package:finerit_app_flutter/apps/bbs/components/bbs_card.dart';
import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/http_error.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/state/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class BBSState<T extends StatefulWidget> extends PageState{
  BaseBBSModel bbsModel;
  UserAuthModel userAuthModel;
  String state;
  String filter='及时动态';

  Widget get_cart_wighet(int index){
    return BBSCard<BaseBBSModel>(index:index);
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
                          ,text: '没有新的信息哦，上拉刷新试试吧～',)
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
  Future load_more_data(){
    NetUtil.get(Api.BBS_BASE, (data) {
      var itemList = BBSItemList.fromJson(data);
      page=page+1;
      bbsModel.addAll(itemList.data);
    },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        params: {"state": state, "filter": filter,'page':page},
        );
  }
  Future refresh_data(){
    String sessionToken = userAuthModel.session_token;
    NetUtil.get(Api.BBS_BASE, (data) {
      var itemList = BBSItemList.fromJson(data);
      bbsModel.setData([]);
      bbsModel.addAll(itemList.data);
      if(!this.mounted){
        return;
      }
      setState(() {
        page=1;
      });
    },
        headers: {"Authorization": "Token $sessionToken"},
        params: {"state": state, "filter": filter,'page':0},
    );
  }
  Future init_data() async {
//    if(bbsModel.getData()==null||bbsModel.getData().length==0){
      if(loading==false){
        NetUtil.get(Api.BBS_BASE, (data) {
          var itemList = BBSItemList.fromJson(data);
          if(itemList.data.length!=0){

            bbsModel.setData(itemList.data);
          }
          if(!this.mounted){
            return;
          }
          setState(() {
            bbsModel.initData=true;
            loading=true;
          });
        },
            headers: {"Authorization": "Token ${userAuthModel.session_token}"},
            params: {"state": state, "filter": filter,'page':0},
            errorCallBack: (error){
              requestToast(HttpError.getErrorData(error).toString());
              if(!this.mounted){
                return;
              }
              setState(() {
                bbsModel.initData=true;
                loading=true;
              });
            });
      }
//    }
  }
  void handle_filter(FilterMenuItem value){
    switch (value) {
      case FilterMenuItem.TOP:
        break;
      case FilterMenuItem.FINERCODE:
        filter='赏金趣文';
        break;
      case FilterMenuItem.TIME:
        filter='及时动态';
        break;
    }
  }
  @override
  Widget build(BuildContext context) {

    bbsModel=ScopedModel.of<BaseBBSModel>(context,rebuildOnChange: true);
    if(loading==false){
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      init_data();
    }
    handle_filter(bbsModel.filterMenuItem);
    if(loading==true&&bbsModel.initData==null){
      loading=false;
      init_data();
    }
    return new Scaffold(
//        backgroundColor: Color.fromARGB(60, 222, 222, 222),
        body:handle_main_wighet()
    );
  }
}