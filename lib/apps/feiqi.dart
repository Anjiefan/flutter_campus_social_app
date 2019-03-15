//重构删除的废弃代码，统一放在这，以防备用，你可以称之为：垃圾箱
//Widget get_bbs_card(BBSDetailItem obj,int index,MainStateModel model){
//  return new Container(
//      color: Colors.white,
//      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
//      child: new FlatButton(
//        onPressed: (){
//          _handle_detail_status(obj,model,index);
//        },
//        child: new Column(
//          children: <Widget>[
//            new Container(
//              child: new Container(
//                child: new Row(
//                  children: <Widget>[
//                    new Expanded(
//                        child:
//                        new Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            new Container(
//                              child: new CircleAvatar(
//                                  backgroundImage: new NetworkImage(obj.user.headImg),
//                                  radius: 15.0
//                              ),
//                            ),
//                            new Container(
//                              child: FittedBox(
//                                child: new Column(
//                                  children: <Widget>[
//                                    new Text("  " + obj.user.nickName  , style: new TextStyle(color: FineritColor.color2_normal)),
//                                    new Divider(height:5),
//                                    new Text( "  " +obj.sincePosted, style: new TextStyle(color: Colors.black54,fontSize: 10,),textAlign:TextAlign.right),
//                                  ],
//                                ),
//                              ),
//                              padding: EdgeInsets.only(),
//                            ),
//                          ],
//                        )
//                    ),
//                    new PopupMenuButton(
//
//                      icon: new Icon(MyFlutterApp.more, color: GlobalConfig.font_color,size: 30),
//                      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
//                        new PopupMenuItem<String>(
//                          value: '添加关注',
//                          child:  new Container(
//                            width: 80,
//                            child: new FlatButton(
//                              onPressed: (){ print("icon");},
//                              padding:EdgeInsets.only(),
//                              child: new Row(
//
//                                children: <Widget>[
//                                  new Icon(Icons.favorite, size: 18.0, color: GlobalConfig.font_color,),
//                                  new Text('关注',style: TextStyle(color: GlobalConfig.font_color)),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                      padding:const EdgeInsets.only(),
//                    )
//                  ],
//                ),
////                  padding: const EdgeInsets.only(left: 5,top: 5),
//              ),
//              decoration: new BoxDecoration(
//                  color: GlobalConfig.card_background_color,
//                  border: new BorderDirectional(bottom: new BorderSide(color: Colors.white10))
//              ),
//            ),
//            new Container(
//                alignment: Alignment.bottomLeft,
//                child: new Text(
//                    obj.status.text,
//                    style: new TextStyle(height: 1.3, color: GlobalConfig.font_color)
//                )
//            ),
//            new Container(
//                child: ImageGridView(imageList: obj.status.images,)
//            ),
//            obj.user.schoolName != ''?IconText(text: obj.user.schoolName,icon: Icons.account_balance):Container(),
////              obj.user.addressName != null?IconText(text: obj.user.schoolName,icon: Icons.account_balance):Container(),
//            obj.status.address!=''?IconText(text: obj.status.address,icon: Icons.add_location):Container(),
//            new Container(
//              child: new Row(
//                children: <Widget>[
//                  new Expanded(
//                      child:
//                      new Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          new Container(
//                            width: 50,
//                            child: new FlatButton(
//                              onPressed: (){ print("icon");},
//                              padding:EdgeInsets.only(),
//                              child: new Row(
//
//                                children: <Widget>[
//                                  new Icon(MyFlutterApp.money, size: 30.0, color: FineritColor.color1_normal),
//                                  new Text(''+obj.status.fineritCode,style: TextStyle(color: FineritColor.color1_normal)),
//                                ],
//                              ),
//                            ),
//                          ),
//
//                        ],
//                      )
//                  ),
//                  new Expanded(
//                      child:
//                      new Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
//                        children: <Widget>[
//                          new Container(
//                            width: 50,
//                            child: new FlatButton(
//                              onPressed: (){
//                                _handle_like_oprate(obj,index,model);
//                              },
//                              padding:EdgeInsets.only(),
//                              child: new Row(
//
//                                children: <Widget>[
//                                  new Icon(obj.like==false?MyFlutterApp.like:Icons.favorite, size: 25.0, color: FineritColor.color1_normal,),
//                                  new Text(obj.likes,style: TextStyle(color: FineritColor.color1_normal)),
//                                ],
//                              ),
//                            ),
//                          ),
//                          new Container(
//                            width: 50,
//                            child: new FlatButton(
//                              onPressed: (){ print("icon");},
//                              padding:EdgeInsets.only(),
//                              child: new Row(
//
//                                children: <Widget>[
//                                  new Icon(MyFlutterApp.comment, size: 25.0, color: FineritColor.color1_normal,),
//                                  new Text(obj.comments,style: TextStyle(color: FineritColor.color1_normal)),
//                                ],
//                              ),
//                            ),
//                          ),
//                          new Container(
//                            width: 50,
//                            child: new FlatButton(
//                              onPressed: (){ print("icon");},
//                              padding:EdgeInsets.only(),
//                              child: new Row(
//
//                                children: <Widget>[
//                                  new Icon(MyFlutterApp.eyes, size: 15.0, color: FineritColor.color1_normal),
//                                  new Text("    "+obj.browses,style: TextStyle(color: FineritColor.color1_normal)),
//                                ],
//                              ),
//                            ),
//                          ),
//
//                        ],
//                      )
//                  ),
//                ],
//              ),
//              padding: const EdgeInsets.only(),
//            )
//          ],
//        ),
//      )
//  );
//}
//void _handle_like_oprate(BBSDetailItem obj,int index,MainStateModel model){
//  obj.like=!obj.like;
//  if(obj.like){
//    int likes=int.parse(obj.likes)+1;
//    obj.likes=likes.toString();
//  }
//  else{
//    int likes=int.parse(obj.likes)-1;
//    obj.likes=likes.toString();
//  }
//  setState(() {
//    obj=obj;
//  });
//  NetUtil.get(Api.BBS_STATUS_LIKE+obj.status.objectId+'/', (data) async{
//    NetUtil.get(Api.BBS_BASE+obj.status.objectId+'/', (data) async{
//      var _obj = BBSDetailItem.fromJson(data);
//      model.updateRecommend(_obj, index);
//      setState(() {
//        obj=_obj;
//      });
//    },
//      headers: {"Authorization": "Token ${model.session_token}"},
//    );
//  },
//    headers: {"Authorization": "Token ${model.session_token}"},
//  );
//
//}
//void _handle_detail_status(BBSDetailItem obj,MainStateModel model,int index){
//  NetUtil.get(Api.BBS_BASE+obj.status.objectId+'/', (data) async{
//    BBSDetailItem bbsDetailItem = BBSDetailItem.fromJson(data);
//    Navigator.of(context).push(MaterialPageRoute(
//        builder: (context)=> ReplyPage(bbsDetailItem: bbsDetailItem,index:index)
//    ));
//  },
//    headers: {"Authorization": "Token ${model.session_token}"},
//  );
//}