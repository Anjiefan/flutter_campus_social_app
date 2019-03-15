import 'package:finerit_app_flutter/icons/icons_route4.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';
//TODO Finish settings page
class SettingsApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => SettingsAppState();
}

class SettingsAppState extends State<SettingsApp>{

  Widget _buildMidCard(MainStateModel model) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
                      height: 50,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: FractionalOffset.centerLeft,
                              child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "账号与安全", style: TextStyle(fontSize: 18),
                                  ))),
                          Align(
                            alignment: FractionalOffset.centerRight,
                            child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.black,
                                  size: 18,
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 50,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: FractionalOffset.centerLeft,
                              child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "账号与安全", style: TextStyle(fontSize: 18),
                                  ))),
                          Align(
                            alignment: FractionalOffset.centerRight,
                            child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(
                                  MyFlutterApp4.right,
                                  color: Colors.black,
//                                              size: 36,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return  ScopedModelDescendant<MainStateModel>(
        builder: (context, widget, MainStateModel model) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(color: Colors.grey[800],),
              title: Text("设置", style: TextStyle(color: Colors.grey[800]),),
              backgroundColor: Colors.white,
            ),
            body: Column(
              children: <Widget>[
                _buildMidCard(model),
              ],
            ),
          );
        });
  }
}