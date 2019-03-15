import 'package:finerit_app_flutter/apps/bbs/bbs_search_detail.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_search_recent_item.dart';
import 'package:finerit_app_flutter/apps/bbs/components/bbs_top_search_item_wighet.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/apps/components/hint_wighet.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/apps/profile/profile_friend_detail.dart';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/sp_util.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileSearchPage extends StatefulWidget{
  @override
  ProfileSearchPageState createState() => new ProfileSearchPageState();
}

class ProfileSearchPageState extends State<ProfileSearchPage> {
  final TextEditingController _controller = new TextEditingController();
  bool initData=false;
  UserAuthModel userAuthModel;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    return new Scaffold(

        appBar: new AppBar(
          leading: BackButton(color: Colors.grey[800],),
          backgroundColor: Colors.white,
          title: new TextField(
            controller: _controller,
            autofocus: true,
            decoration: new InputDecoration.collapsed(
                hintText: "输入手机号进行搜索",
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
        body: Container()
    );
  }
  Future _handle_search_press() async{
    await   NetUtil.get(Api.PHONE_SEARCH, (data) async{
      User userinfo=User.fromJson(data);
      if(userinfo!=null){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>
                ScopedModel<SearchStatusModel>(
                  model: SearchStatusModel(),
                  child: ProfileFrendDetailApp(userInfo: userinfo,),
                )
        ));
      }

    },params: {
      "phonenum":_controller.text
    },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );

  }
}
