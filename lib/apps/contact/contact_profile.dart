import 'package:finerit_app_flutter/apps/im/im_base.dart';
import 'package:finerit_app_flutter/apps/profile/profile_gallery.dart';
import 'package:finerit_app_flutter/apps/profile/profile_story.dart';
import 'package:finerit_app_flutter/commons/datas.dart';
import "package:flutter/material.dart";

class ContactProfileApp extends StatefulWidget {
  final ContactInfo model;

  ContactProfileApp({Key key, @required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ContactProfileAppState(model: model);
}

class ContactProfileAppState extends State<ContactProfileApp> {
  final ContactInfo model;

  ContactProfileAppState({Key key, @required this.model}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.grey[800],
          ),
          backgroundColor: Colors.white,
          title: Text(
            "个人资料",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: <Widget>[
            _buildTopCard(),
            _buildMidCard(),
            _buildBottomBar()
          ],
        ));
  }

  Widget _buildRegionBar() {
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(margin: EdgeInsets.only(left: 10), child: Text("地区")),
          Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "北京市",
                style: TextStyle(color: Colors.grey),
              ))
        ],
      ),
    );
  }

  Widget _buildAlbumBar() {
    return InkWell(
      onTap: _handleAlbum,
      child: Container(
        height: 70,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(margin: EdgeInsets.only(left: 10), child: Text("相册")),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://pic.baike.soso.com/ugc/baikepic2/16720/cut-20180126195517-1168215312_jpg_731_584_26331.jpg/300"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=31521df69ddda144ce0464e0d3debbc7/8694a4c27d1ed21b33719700a76eddc450da3f9e.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://img.go007.com/2016/11/27/b250bff5dd7a2b67_3.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildTopCard() {
    return Container(
      margin: EdgeInsets.only(top: 10),
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
                      image: NetworkImage(FakeAvatars.avatar1),
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
                          child: Row(children: <Widget>[
                            Text(
                              model.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: 16,
                                ))
                          ]),
                        ),
                        Container(
                            width: 180,
                            height: 18,
                            margin: EdgeInsets.only(top: 8.0),
                            child: Text("手机号: 13835275252",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ))),
                        Container(
                            width: 180,
                            height: 18,
                            child: Text("学校: 东北石油大学",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ))),
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

  Widget _buildMidCard() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  _buildRegionBar(),
                  Divider(
                    height: 2,
                  ),
                  _buildAlbumBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      width: 150,
      margin: EdgeInsets.only(top: 20),
      child: RaisedButton(
        onPressed: _handleChat,
        child: Text(
          "发消息",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
      ),
    );
  }

  void _handleChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatWebViewApp(),
      ),
    );
  }

  void _handleAlbum() {
    //TODO handle album
    //...
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileStoryApp(),
      ),
    );
  }
}
