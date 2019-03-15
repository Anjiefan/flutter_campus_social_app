import 'dart:convert';
import 'package:finerit_app_flutter/apps/components/common_drawer.dart';
import 'package:finerit_app_flutter/apps/contact/components/index_bar.dart';
import 'package:finerit_app_flutter/apps/contact/components/suspension_listview.dart';
import 'package:finerit_app_flutter/apps/contact/contact_add_friend.dart';
import 'package:finerit_app_flutter/apps/contact/contact_profile.dart';
import 'package:finerit_app_flutter/commons/datas.dart';
import 'package:finerit_app_flutter/commons/ui.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactAppState();
}

class ContactAppState extends State<ContactApp> {
  List<ContactInfo> _contacts = List();

  int _suspensionHeight = 40;
  int _itemHeight = 60;
  String _hitTag = "";


  String headImg = "";
  String nickName = "";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    //加载联系人列表
//    rootBundle.loadString('assets/data/contacts.json').then((value) {
//      List list = json.decode(value);
//      list.forEach((value) {
//        _contacts.add(ContactInfo(name: value['name']));
//      });
//      _handleList(_contacts);
//      setState(() {});
//    });
  }

  void _handleList(List<ContactInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin =
          PinyinHelper.convertToPinyinStringWithoutException(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            '$susTag',
            textScaleFactor: 1.2,
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(ContactInfo model) {
    String susTag = model.getSuspensionTag();
    return Container(

      child: Column(
        children: <Widget>[
          Offstage(
            offstage: model.isShowSuspension != true,
            child: _buildSusWidget(susTag),
          ),
          Container(
            color: Colors.white,
            child:  SizedBox(
              height: _itemHeight.toDouble(),
              child: ListTile(
                leading: Container(
                  margin: EdgeInsets.only(left: 0),
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    image: DecorationImage(
                      image: NetworkImage(FakeAvatars.avatar1),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(model.name),
                onTap: () {
                  print("OnItemClick: $model");
//              Navigator.pushNamed(context, "/chat");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactProfileApp(model: model),
                    ),
                  );
                },
              ),

            ),
          ),
          Divider(height: 0.0, indent: 10, color: Colors.black12,)
        ],
      ),
    );
  }

  Widget getHeightItems(Icon icon, String name) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
            height: 50,
            child: new Row(
              children: <Widget>[
                icon,
                Padding(
                  padding: new EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  child: new Text(name, style: TextStyle(color: FineritColor.color1_normal),),
                )
              ],
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
            height: 0.5,
            color: const Color(0xffebebeb),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(MainStateModel model) {
    return AppBar(
      title: Text("通讯录", style: FineritStyle.style3,),
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: new CircleAvatar(
            backgroundImage: new NetworkImage(
                model.userInfo.headImg),
          ),
          onPressed: () => handle_head_event(context),
        ),
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          tooltip: "添加好友",
          icon: const Icon(MyFlutterApp.create2,size: 15,color: Colors.black),
          color: FineritColor.color1_normal,
          onPressed: _handleAddFriend,
        ),
      ],
    );
  }

  void _handleAvatar() {
    handleAvatar(context);
  }

  void _handleAddFriend() {
    //TODO handle add friend
    //...
    print("handle add friend");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactAddFriendApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    return Scaffold(
      appBar: _buildAppBar(model),
//      drawer: new Drawer(
//        child: CommonDrawer(headImg: model.userInfo.headImg,nickName: model.userInfo.nickName),
//      ),
      body: QuickSelectListView(
        data: _contacts,
        itemBuilder: (context, model) => _buildListItem(model),
        isUseRealIndex: true,
        itemHeight: _itemHeight,
        suspensionHeight: _suspensionHeight,
        header: QuickSelectListViewHeader(
            height: 102,
            builder: (context) {
              return Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: _handleAddFriend,
                      child: getHeightItems(
                          Icon(
                            MyFlutterApp.addfriend,
                            size: 20,
                            color: FineritColor.color1_normal,
                          ),
                          '新的朋友'),
                    ),
                    getHeightItems(Icon(MyFlutterApp.chart, size: 20, color: FineritColor.color1_normal,), '群聊'),
                  ],
                ),
              );
            }),
        indexBarBuilder: (BuildContext context, List<String> tags,
            IndexBarTouchCallback onTouch) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.grey[300], width: .5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: IndexBar(
                data: tags,
                itemHeight: 14,
                onTouch: (details) {
                  onTouch(details);
                },
              ),
            ),
          );
        },
        indexHintBuilder: (context, hint) {
          return Container(
            alignment: Alignment.center,
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.blue[700].withAlpha(200),
              shape: BoxShape.circle,
            ),
            child: Text(hint,
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
          );
        },
      ),
    );
  }
}
