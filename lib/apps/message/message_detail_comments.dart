import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/message/message_components_comment.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/beans/message_comment_list.dart';
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

class MessageCommentApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MessageCommentAppState();
}

class MessageCommentAppState extends PageState<MessageCommentApp> {
  BaseMessageCommentModel messageCommentModel;
  UserAuthModel userAuthModel;
//BaseBBSModel bbsModel;
//  String state = '自己';
//  String filter = '及时动态';

  @override
  void initState() {
    super.initState();
  }

  Widget get_cart_wighet(int index){
    return MessageCommentCard<BaseMessageCommentModel>(index:index);
  }

  Widget handle_main_wighet() {
    if (messageCommentModel.getData() == null || messageCommentModel
        .getData()
        .length == 0) {
      if (messageCommentModel.initData == true) {
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
                            ,text: '还没有收到评论哦～',),
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
              itemCount: messageCommentModel
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
    messageCommentModel =
        ScopedModel.of<BaseMessageCommentModel>(context, rebuildOnChange: true);
    init_data();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title: Text("评论", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: handle_main_wighet(),
    );
  }

  @override
  Future init_data() {
    if (messageCommentModel.getData() == null ||
        messageCommentModel
            .getData()
            .length == 0) {
      if (messageCommentModel.initData == false) {
        NetUtil.get(
            Api.MESSAGE_COMMENT_ME,
                (data) {
              var itemList = MessageCommentList.fromJson(data);
              if (itemList.data.length != 0) {
                messageCommentModel.setData(itemList.data);
              }
              if(!this.mounted){
                return;
              }
              setState(() {
                messageCommentModel.initData = true;
              });
            },
            headers: {"Authorization": "Token ${userAuthModel.session_token}"},
            params: {'page': '0'},
            errorCallBack: (error) {
              if(!this.mounted){
                return;
              }
              setState(() {
                messageCommentModel.initData = true;
              });
            });
      }
    }
  }

  @override
  Future load_more_data() {

    NetUtil.get(
        Api.MESSAGE_COMMENT_ME,
            (data) {
          var itemList = MessageCommentList.fromJson(data);
          page = page + 1;
          messageCommentModel.addAll(itemList.data);
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


    NetUtil.get(Api.MESSAGE_COMMENT_ME, (data) {
      var itemList = MessageCommentList.fromJson(data);
      messageCommentModel.setData([]);
      messageCommentModel.addAll(itemList.data);
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
