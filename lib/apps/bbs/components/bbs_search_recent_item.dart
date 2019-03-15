
import 'package:finerit_app_flutter/apps/bbs/bbs_search_detail.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchRecentItem extends StatelessWidget{
  String value;
  SearchRecentItem({Key key,this.value}):super(key:key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
              child:Container(
                child: FlatButton.icon(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>
                            ScopedModel<SearchStatusModel>(
                              model: SearchStatusModel(),
                              child: BBSSearchApp(value:value),
                            )
                    ));
                  },
                  icon:           new Container(
                    child: new Icon(Icons.access_time, color: GlobalConfig.font_color, size: 16.0),
                    margin: const EdgeInsets.only(right: 12.0),
                  ),
                  label: //          new Expanded(
                  new Container(
                    child: new Text(value, style: new TextStyle( color: GlobalConfig.font_color, fontSize: 14.0),),
                  ),
                ),
                alignment: Alignment.centerLeft,
              )),
          new Container(
            child: GestureDetector(
              child:
              new Icon(Icons.clear, color: GlobalConfig.font_color, size: 16.0),
              onTap: (){
                StatusModel statusModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
                statusModel.remove(value);
              },
            ),
          )
        ],
      ),
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0.0),
      padding: const EdgeInsets.only(bottom: 0.0),
      decoration: new BoxDecoration(
          border: new BorderDirectional(bottom: new BorderSide(color: GlobalConfig.dark == true ?  Colors.white12 : Colors.black12))
      ),
    );
  }

}