import 'package:finerit_app_flutter/apps/components/blank.dart';
import 'package:finerit_app_flutter/apps/contact/contact_profile.dart';
import 'package:finerit_app_flutter/commons/datas.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import "package:flutter/material.dart";
import 'package:lpinyin/lpinyin.dart';
import 'package:scoped_model/scoped_model.dart';

//class ContactInfo{
//  final String id;
//  final String name;
//  final String school;
//
//  ContactInfo(this.id, this.name, this.school);
//}

class ContactAddFriendApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactAddFriendAppState();
}

class ContactAddFriendAppState extends State<ContactAddFriendApp> {
  final TextEditingController _controller = new TextEditingController();
  List<ContactInfo> _list=[];
  bool _isSearching;
  String _searchText;
  List<ContactInfo> searchResult = new List();
  List<int> sortList = List();
  List<int> sortResultList = List();

  ContactAddFriendAppState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        if(!this.mounted){
          return;
        }
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        if(!this.mounted){
          return;
        }
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
//    values();
//    sorts();
  }

//  void values() {
//    _list = List();
//    _list.add(ContactInfo(
//        name: "阿刁", school: "清华大学", id: "0", imageUrl: FakeAvatars.avatar1));
//    _list.add(ContactInfo(
//        name: "白天一", school: "清华大学", id: "1", imageUrl: FakeAvatars.avatar2));
//    _list.add(ContactInfo(
//        name: "陈晓丽", school: "北京大学", id: "2", imageUrl: FakeAvatars.avatar3));
//    _list.add(ContactInfo(
//        name: "东陵", school: "北京大学", id: "3", imageUrl: FakeAvatars.avatar1));
//    _list.add(ContactInfo(
//        name: "恩正天", school: "人民大学", id: "4", imageUrl: FakeAvatars.avatar2));
//    _list.add(ContactInfo(
//        name: "福梅", school: "人民大学", id: "5", imageUrl: FakeAvatars.avatar3));
//    _list.add(ContactInfo(
//        name: "戈凌华",
//        school: "北京航空航天大学",
//        id: "6",
//        imageUrl: FakeAvatars.avatar1));
//    _list.add(ContactInfo(
//        name: "郝铠雪",
//        school: "北京航空航天大学",
//        id: "7",
//        imageUrl: FakeAvatars.avatar2));
//    _list.add(ContactInfo(
//        name: "洛天依", school: "东北石油大学", id: "8", imageUrl: FakeAvatars.avatar3));
//    _list.add(ContactInfo(
//        name: "宁雪纯", school: "东北石油大学", id: "9", imageUrl: FakeAvatars.avatar1));
//  }

//  void sorts() {
//    sortList.add(0);
//    sortList.add(2);
//    sortList.add(4);
//    sortList.add(6);
//    sortList.add(8);
//  }

  void searchOperation(String searchText) {
    searchResult.clear();
    sortResultList.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        ContactInfo data = _list[i];
        String pinyinName =
        PinyinHelper.convertToPinyinStringWithoutException(data.name);
        String pinyinSchool =
        PinyinHelper.convertToPinyinStringWithoutException(data.school);
        if (pinyinName
            .toLowerCase()
            .replaceAll(" ", "")
            .contains(_searchText.toLowerCase()) ||
            data.name.contains(_searchText) ||
            pinyinSchool
                .toLowerCase()
                .replaceAll(" ", "")
                .contains(_searchText.toLowerCase()) ||
            data.school.contains(_searchText)) {
          searchResult.add(data);
        }
      }
    }
  }

  Container _buildSystemMessage(ContactInfo info) {
    return Container(
      color: Colors.white,
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: FractionalOffset.topLeft,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8),
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    image: DecorationImage(
                      image: NetworkImage(info.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          Flexible(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: FractionalOffset.topLeft,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 18,
                          child: Text(
                            "${info.name}",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            width: 180,
                            height: 18,
                            margin: EdgeInsets.only(top: 8.0),
                            child: Text("手机号: 13835245236",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500))),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserInfoModel model=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    return Scaffold(
      resizeToAvoidBottomPadding:false,
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
        body: Column(
          children: <Widget>[
            new Flexible(
              child: searchResult.length != 0 || _controller.text.isNotEmpty
                  ? new ListView.builder(
                shrinkWrap: true,
                itemCount: searchResult.length,
                itemBuilder: (BuildContext context, int index) {
                  searchResult.sort((a, b) => a.school.compareTo(b.school));
                  List<String> schools = List();
                  for (var result in searchResult) {
                    schools.add(result.school);
                  }
                  List<String> schoolsDistinct = schools.toSet().toList();
                  for (var school in schoolsDistinct) {
                    sortResultList.add(schools.indexOf(school));
                  }
                  sortResultList = sortResultList.toSet().toList();
//                    print("sortResultList=${sortResultList.toString()}");

                  ContactInfo listData = searchResult[index];

                  for (var i = 0; i < sortResultList.length; i++) {
                    if (index == sortResultList[i]) {
                      //位于一个学校组内
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[400].withOpacity(0.3),
                            child: Text(
                              "来自 ${listData.school}",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 12),
                            ),
                          ),
                          InkWell(onTap: () {
                            print("OnItemClick: $listData");
//              Navigator.pushNamed(context, "/chat");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContactProfileApp(model: listData),
                              ),
                            );
                          },child: _buildSystemMessage(listData))
                        ],
                      );
                    }
                  }
                  return InkWell(onTap: () {
                    print("OnItemClick: $listData");
//              Navigator.pushNamed(context, "/chat");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ContactProfileApp(model: listData),
                      ),
                    );
                  },child: _buildSystemMessage(listData));
                },
              )
                  : new ListView.builder(
                shrinkWrap: true,
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  ContactInfo listData = _list[index];
                  for (var i = 0; i < sortList.length; i++) {
                    if (index == sortList[i]) {
                      //位于一个学校组内
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[400].withOpacity(0.3),
                            child: Text(
                              "来自 ${listData.school}",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 12),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                print("OnItemClick: $listData");
//              Navigator.pushNamed(context, "/chat");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ContactProfileApp(model: listData),
                                  ),
                                );
                              },
                              child: InkWell(
                                  onTap: () {
                                    print("OnItemClick: $listData");
//              Navigator.pushNamed(context, "/chat");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ContactProfileApp(
                                                model: listData),
                                      ),
                                    );
                                  },
                                  child: _buildSystemMessage(listData)))
                        ],
                      );
                    }
                  }
                  return InkWell(
                      onTap: () {
                        print("OnItemClick: $listData");
//              Navigator.pushNamed(context, "/chat");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ContactProfileApp(model: listData),
                          ),
                        );
                      },
                      child: _buildSystemMessage(listData));
                },
              ),
            ),
            model.userInfo.ifAuth==false?Container(
              child: Blank(width: MediaQuery.of(context).size.width
                ,height: MediaQuery.of(context).size.height
                ,text: '实名认证的用户才能使用通讯系统交友哦～',),
            ):Container(
              child: Blank(width: MediaQuery.of(context).size.width
                ,height: MediaQuery.of(context).size.height
                ,text: '及时通讯将在5月份推出，敬请期待～',),
            )
          ],
        ));
  }
  void _handle_search_press(){}
  void _handleSearch() {}
}
