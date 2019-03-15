//
//
////import 'package:finerit_app_flutter/icons/my_flutter_app_icons.dart';
//import 'package:finerit_app_flutter/style/themes.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//import 'package:flutter/material.dart';
//import 'package:zefyr/zefyr.dart';
//class BBSSend extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => BBSSendState();
//}
//
//
//class BBSSendState extends State<BBSSend>{
//  ZefyrController _controller;
//  FocusNode _focusNode;
//
//    @override
//  void initState() {
//    super.initState();
//    // Create an empty document or load existing if you have one.
//    // Here we create an empty document:
//    final document = new NotusDocument();
//    _controller = new ZefyrController(document);
//    _focusNode = new FocusNode();
//  }
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//
//    return Scaffold(
//
//      resizeToAvoidBottomPadding: false,
//
//      appBar: AppBar(
//        leading:IconButton(
//          icon:Text('取消',style: TextStyle(color: FineritColor.color2_normal),),
//          color: FineritColor.color1_normal,
//          onPressed: ()=>
//              Navigator.of(context).pop()
//          ,
//        ),
//        backgroundColor:Colors.white ,
//        centerTitle: true,
//        title:Text('发布微文',style: TextStyle(color: FineritColor.color2_normal)),
//        actions: <Widget>[
//          IconButton(
//            icon:Text('发布',style: TextStyle(color: FineritColor.color2_normal),),
//            color: FineritColor.color1_normal,
//            onPressed: ()=>{},
//          ),
//        ],
//      ),
//      body: new Container(
//          color: Colors.white,
//          child:
//          Theme(
//              data: ThemeData(
//                  primaryColor: Colors.white,
//                  accentColor: Colors.white,
//                  hintColor: Colors.white),
//              child: Container(
//
//                child: new Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    TextField(
//                      maxLines:8,
//                      autofocus:true,
//                      cursorColor:FineritColor.color2_normal,
//                      decoration: InputDecoration(
//                        contentPadding: EdgeInsets.all(10.0),
//                      ),
//                    ),
//                    Container(
//                      child: RaisedButton(
//                        color: Colors.white,
//                        onPressed: (){ print("icon");},
//                        padding:EdgeInsets.only(),
//                        child: new Row(
//                          children: <Widget>[
//                            Container(
//                              padding: EdgeInsets.all(16),
//                              child: Row(
//                                children: <Widget>[
//                                  IconButton(
//                                      icon: Icon(Icons.add_location),
//                                      onPressed: null
//                                  ),
//                                  Text('东北石油大学',style: TextStyle(color: FineritColor.color1_normal),)
//                                ],
//                              ),
//                            )
//
//                          ],
//                        ),
//                      ),
//                    ),
//
//
//                  ],
//                ),
//              )
//          ),
//      ),
//    );
//  }
//
//}
