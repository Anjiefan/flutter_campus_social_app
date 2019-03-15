import 'package:finerit_app_flutter/apps/bbs/bbs_info.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_tabs.dart';
import 'package:finerit_app_flutter/apps/components/image_grid_view.dart';
import 'package:finerit_app_flutter/commons/load_locale_imgs.dart';
import 'package:finerit_app_flutter/commons/picturePage.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/asset.dart';

///创建BBS的Widget
class BBSBuider{
  static var width = 360.0;

  static Widget bbsCommentsCard(BBSInfo article,BuildContext context) {
    Widget markWidget;
    if (article.imgUrl == null) {
      markWidget = new Text(
          article.mark,
          style: new TextStyle(height: 1.3, color: GlobalConfig.font_color)
      );
    } else {
      markWidget = new Row(
        children: <Widget>[
          new Expanded(
            flex: 2,
            child: new Container(
              child: new Text(
                  article.mark,
                  style: new TextStyle(height: 1.3, color: GlobalConfig.font_color)
              ),
            ),
          ),
          new Expanded(
              flex: 1,
              child: new AspectRatio(
                  aspectRatio: 3.0 / 2.0,
                  child: new Container(
                    foregroundDecoration:new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(article.imgUrl[0]),
                          centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                        ),
                        borderRadius: const BorderRadius.all(const Radius.circular(6.0))
                    ),
                  )
              )
          ),
        ],
      );
    }
    return new Container(
        color: Colors.white,
        margin: const EdgeInsets.only( bottom:1.0),
        child: new FlatButton(
          onPressed: (){
          },
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Container(
//                height: 30,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child:
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                child: new CircleAvatar(
                                    backgroundImage: new NetworkImage(article.headUrl),
                                    radius: 15.0
                                ),
                              ),
                              new Container(
                                child: FittedBox(
                                  child: new Column(
                                    children: <Widget>[
                                      new Text("  " + article.user  , style: new TextStyle(color: FineritColor.color2_normal)),
                                      new Divider(height:5),
                                      new Text( "  " +article.time, style: new TextStyle(color: Colors.black54,fontSize: 10,),textAlign:TextAlign.right),

                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.only(),
                              ),
//                                new Text("  " + article.user + " " + article.action + " · " + article.time, style: new TextStyle(color: Colors.black12)),

                            ],
                          )
                      ),
                      new Expanded(
                          child:
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Container(
                                width: 50,
                                child: new FlatButton(
                                  onPressed: (){ print("icon");},
                                  padding:EdgeInsets.only(),
                                  child: new Row(

                                    children: <Widget>[
                                      new Icon(MyFlutterApp.like, size: 25.0, color: GlobalConfig.font_color,),
                                      new Text(article.agreeNum.toString(),style: TextStyle(color: GlobalConfig.font_color)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      new PopupMenuButton(

                        icon: new Icon(MyFlutterApp.more, color: GlobalConfig.font_color,size: 30),
                        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                          new PopupMenuItem<String>(
                            value: '添加好友',
                            child:  new Container(
                              width: 80,
                              child: new FlatButton(
                                onPressed: (){ print("icon");},
                                padding:EdgeInsets.only(),
                                child: new Row(

                                  children: <Widget>[
                                    new Icon(Icons.favorite, size: 18.0, color: GlobalConfig.font_color,),
                                    new Text(' '+'添加好友',style: TextStyle(color: GlobalConfig.font_color)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          new PopupMenuItem<String>(
                            value: '添加关注',
                            child:  new Container(
                              width: 80,
                              child: new FlatButton(
                                onPressed: (){ print("icon");},
                                padding:EdgeInsets.only(),
                                child: new Row(

                                  children: <Widget>[
                                    new Icon(Icons.favorite, size: 18.0, color: GlobalConfig.font_color,),
                                    new Text(' '+'添加好友',style: TextStyle(color: GlobalConfig.font_color)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        padding:const EdgeInsets.only(),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.only(),
                ),
              ),
              new Container(
                child: new Container(
//                height: 30,
                  child: new Row(
                    children: <Widget>[
                      new Text(article.title,style: TextStyle(color: Colors.black54),),
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 37,bottom: 15),
                ),
              ),
            ],
          ),
        )
    );
  }
  static Widget bbsDetailWordsCard(BBSInfo article,BuildContext context) {
    return new Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: new FlatButton(
          onPressed: (){
          },
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Container(
//                height: 30,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child:
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                child: new CircleAvatar(
                                    backgroundImage: new NetworkImage(article.headUrl),
                                    radius: 15.0
                                ),
                              ),
                              new Container(
                                child: FittedBox(
                                  child: new Column(
                                    children: <Widget>[
                                      new Text("  " + article.user  , style: new TextStyle(color: FineritColor.color2_normal)),
                                      new Divider(height:5),
                                      new Text( "  " +article.time, style: new TextStyle(color: Colors.black54,fontSize: 10,),textAlign:TextAlign.right),

                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.only(),
                              ),
//                                new Text("  " + article.user + " " + article.action + " · " + article.time, style: new TextStyle(color: Colors.black12)),

                            ],
                          )
                      ),
                      new PopupMenuButton(

                        icon: new Icon(MyFlutterApp.more, color: GlobalConfig.font_color,size: 30),
                        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                          new PopupMenuItem<String>(
                            value: '添加好友',
                            child:  new Container(
                              width: 80,
                              child: new FlatButton(
                                onPressed: (){ print("icon");},
                                padding:EdgeInsets.only(),
                                child: new Row(

                                  children: <Widget>[
                                    new Icon(Icons.favorite, size: 18.0, color: GlobalConfig.font_color,),
                                    new Text(' '+'添加好友',style: TextStyle(color: GlobalConfig.font_color)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          new PopupMenuItem<String>(
                            value: '添加关注',
                            child:  new Container(
                              width: 80,
                              child: new FlatButton(
                                onPressed: (){ print("icon");},
                                padding:EdgeInsets.only(),
                                child: new Row(

                                  children: <Widget>[
                                    new Icon(Icons.favorite, size: 18.0, color: GlobalConfig.font_color,),
                                    new Text(' '+'添加好友',style: TextStyle(color: GlobalConfig.font_color)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        padding:const EdgeInsets.only(),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 5,top: 5),
                ),
                decoration: new BoxDecoration(
                    color: GlobalConfig.card_background_color,
                    border: new BorderDirectional(bottom: new BorderSide(color: Colors.white10))
                ),
              ),
              new Container(
                color: Colors.white,

                child: new Text(
                    '        波斯猫（Persian cat）是以阿富汗的土种长毛猫和土耳其的安哥拉长毛猫为基础，在英国经过100多年的选种繁殖，于1860年诞生的一个品种。\n'
                        '    波斯猫是最常见的长毛猫，波斯猫有一张讨人喜爱的面庞，长而华丽的背毛，优雅的举止，故有“猫中王子”、“王妃”之称，是世界上爱猫者最喜欢的纯种猫之一，占有极其重要的地位。',
                    style: new TextStyle(height: 1.4, fontSize: 13.0, color: Colors.black54), textAlign: TextAlign.start
                ),
                padding: const EdgeInsets.all(16.0),
              ),
//              new Center(
//                child: PictureShow(
//                  picList: article.imgUrl,
//                ),
//              ),
              new Container(
                  child: ImageGridView(imageList: article.imgUrl,)
              ),
              new Container(
//                height: 30,
                color: Colors.white,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                        child:
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              width: 50,
                              child: new FlatButton(
                                onPressed: (){ print("icon");},
                                padding:EdgeInsets.only(),
                                child: new Row(

                                  children: <Widget>[
                                    new Icon(MyFlutterApp.money, size: 30.0, color: FineritColor.color1_normal),
                                    new Text(''+article.commentNum.toString(),style: TextStyle(color: FineritColor.color1_normal)),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        )
                    ),
                    new Expanded(
                        child:
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Container(
                              width: 50,
                              child: new FlatButton(
                                onPressed: (){ print("icon");},
                                padding:EdgeInsets.only(),
                                child: new Row(

                                  children: <Widget>[
                                    new Icon(MyFlutterApp.like, size: 25.0, color: FineritColor.color1_normal,),
                                    new Text(article.agreeNum.toString(),style: TextStyle(color: FineritColor.color1_normal)),
                                  ],
                                ),
                              ),
                            ),
                            new Container(
                              width: 50,
                              child: new FlatButton(
                                onPressed: (){ print("icon");},
                                padding:EdgeInsets.only(),
                                child: new Row(

                                  children: <Widget>[
                                    new Icon(MyFlutterApp.comment, size: 25.0, color: FineritColor.color1_normal,),
                                    new Text(article.commentNum.toString(),style: TextStyle(color: FineritColor.color1_normal)),
                                  ],
                                ),
                              ),
                            ),
                            new Container(
                              width: 49,
                              child: new FlatButton(
                                onPressed: (){ print("icon");},
                                padding:EdgeInsets.only(),
                                child: new Row(

                                  children: <Widget>[
                                    new Icon(MyFlutterApp.eyes, size: 15.0, color: FineritColor.color1_normal),
                                    new Text("    "+article.commentNum.toString(),style: TextStyle(color: FineritColor.color1_normal)),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        )
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15),
              ),
            ],
          ),
        )
    );
  }
}

