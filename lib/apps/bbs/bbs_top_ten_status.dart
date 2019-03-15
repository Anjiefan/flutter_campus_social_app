
import 'package:finerit_app_flutter/apps/bbs/components/bbs_card.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/apps/components/hint_wighet.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/state/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class BBSTopTenApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BBSTopTenState();
}

class BBSTopTenState extends PageState<BBSTopTenApp>{
  BaseBBSModel bbsModel;
  UserAuthModel userAuthModel;
  bool initData=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
    Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title:
        Text("全球通告", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15),
            child: handle_main_wighet(),
          ),
          new Positioned(
              top: 0,
              left:0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: TopHint(value: '实时更新每日赏金最高的前十条精彩微文，全球广播~',icon: Icons.data_usage,),
              )
          ),
        ],
      ),
    );
  }
  Widget get_cart_wighet(int index){
    return BBSCard<BBSTopTenModel>(index:index);
  }
  Widget handle_main_wighet(){
    userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    bbsModel=ScopedModel.of<BBSTopTenModel>(context,rebuildOnChange: true);
    init_data();
    if(bbsModel.getData()==null||bbsModel.getData().length==0){
      if(bbsModel.initData==true){
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
                itemCount: 0,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Column(
                      children: <Widget>[
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
    String sessionToken = userAuthModel.session_token;
    NetUtil.get(Api.BBS_TOP_TEN_STATUS, (data) {
      var itemList = BBSItemList.fromJson(data);
      bbsModel.setData([]);
      bbsModel.addAll(itemList.data);
    },
      headers: {"Authorization": "Token $sessionToken"},
    );
  }
  Future refresh_data(){
    String sessionToken = userAuthModel.session_token;
    NetUtil.get(Api.BBS_TOP_TEN_STATUS, (data) {
      var itemList = BBSItemList.fromJson(data);
      bbsModel.setData([]);
      bbsModel.addAll(itemList.data);
    },
      headers: {"Authorization": "Token $sessionToken"},
    );
  }
  Future init_data() async {
    if(bbsModel.getData()==null||bbsModel.getData().length==0){
      if(bbsModel.initData==false){
        NetUtil.get(Api.BBS_TOP_TEN_STATUS, (data) {
          var itemList = BBSItemList.fromJson(data);
          if(itemList.data.length!=0){
            bbsModel.setData(itemList.data);
          }
          if(!this.mounted){
            return;
          }
          setState(() {
            bbsModel.initData=true;
          });
        },
          headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        );
      }
    }
  }

}