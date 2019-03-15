import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/message/message_components_comment.dart';
import 'package:finerit_app_flutter/apps/message/message_components_like.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/beans/message_comment_list.dart';
import 'package:finerit_app_flutter/beans/message_like_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/state/page_state.dart';
import "package:flutter/material.dart";
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class MessageLikeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MessageLikeAppState();
}

class MessageLikeAppState extends PageState<MessageLikeApp> {
  BaseMessageLikeModel messageLikeModel;
  UserAuthModel userAuthModel;

  @override
  void initState() {
    super.initState();
  }

  Widget get_cart_wighet(int index){
    return MessageLikeCard<BaseMessageLikeModel>(index:index);
  }

  Widget handle_main_wighet() {
    if (messageLikeModel.getData() == null || messageLikeModel
        .getData()
        .length == 0) {
      if (messageLikeModel.initData == true) {
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
                        Container(
                          child: Blank(width: MediaQuery.of(context).size.width
                            ,height: MediaQuery.of(context).size.height
                            ,text: '还没有收到喜欢哦～',),
                        )
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
      else {
        return SpinKitFadingCircle(
          color: Color.fromARGB(50, 0, 0, 0), size: 30,);
      }
    }
    else {
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
              itemCount: messageLikeModel
                  .getData()
                  .length,
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
  Widget build(BuildContext context) {
    userAuthModel =
        ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
    messageLikeModel =
        ScopedModel.of<BaseMessageLikeModel>(context, rebuildOnChange: true);
    init_data();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title: Text("喜欢", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: handle_main_wighet(),
    );
  }

  @override
  Future init_data() {
    if (messageLikeModel.getData() == null ||
        messageLikeModel
            .getData()
            .length == 0) {
      if (messageLikeModel.initData == false) {
        NetUtil.get(
            Api.MESSAGE_LIKE_ME,
                (data) {
              var itemList = MessageLikeList.fromJson(data);
              if (itemList.data.length != 0) {
                messageLikeModel.setData(itemList.data);
              }
              if(!this.mounted){
                return;
              }
              setState(() {
                messageLikeModel.initData = true;
              });
            },
            headers: {"Authorization": "Token ${userAuthModel.session_token}"},
            params: {'page': '0'},
            errorCallBack: (error) {
              if(!this.mounted){
                return;
              }
              setState(() {
                messageLikeModel.initData = true;
              });
            });
      }
    }
  }

  @override
  Future load_more_data() {
//    NetUtil.get(Api.BBS_BASE, (data) {
//      var itemList = BBSItemList.fromJson(data);
//      page=page+1;
//      bbsModel.addAll(itemList.data);
//    },
//        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
//        params: {"state": state, "filter": filter,'page':page},
//        errorCallBack: (error){
//          print('erorr');
//        });

    NetUtil.get(
        Api.MESSAGE_LIKE_ME,
            (data) {
          var itemList = MessageLikeList.fromJson(data);
          page = page + 1;
          messageLikeModel.addAll(itemList.data);
        },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
        params: {'page': page},
        errorCallBack: (error) {
          print("error");
        });
  }

  @override
  Future refresh_data() {
    String sessionToken = userAuthModel.session_token;


    NetUtil.get(Api.MESSAGE_LIKE_ME, (data) {
      var itemList = MessageLikeList.fromJson(data);
      messageLikeModel.setData([]);
      messageLikeModel.addAll(itemList.data);
      if(!this.mounted){
        return;
      }
      setState(
            () {
          page = 1;
        },
      );
    },
        headers: {"Authorization": "Token $sessionToken"},
        params: {'page': 0},
        errorCallBack: (error) {});
  }
}
