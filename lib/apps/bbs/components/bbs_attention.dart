import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BBSAttention extends StatefulWidget{
  User user;
  BBSAttention({Key key,this.user}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BBSAttentionState(
      key: key,
      user: user,
    );
  }

}

class BBSAttentionState extends State<BBSAttention>{
  User user;
  UserAuthModel _userAuthModel;
  BBSAttentionState({Key key,this.user}):super();
  bool loading=false;
  bool iffrend=false;
  @override
  Widget build(BuildContext context) {

    if(loading==false){
      _userAuthModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      init_user_iffrend();
    }
    return  GestureDetector(
      child:  new Container(
        width: 80,
        padding:EdgeInsets.only(top: 5,bottom: 5),
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 5),
        decoration: new BoxDecoration(
          border: new Border.all(width: 1, color: Colors.black26),
          borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
        ),
        child: iffrend==false?Text("关注",style: TextStyle(color: FineritColor.color1_normal),)
        :Text("已关注",style: TextStyle(color: FineritColor.color1_normal),),
      ),
      onTap: (){
        _handle_frendlike_oprate();
      },
    );

  }
  void init_user_iffrend(){
    NetUtil.get(Api.IFFRIEND, (data) async{
      loading=true;
      if(data['frend']=='1'){
        if(!this.mounted){
          return;
        }
        setState(() {
          iffrend=true;
        });
      }
      else if(data['frend']=="0"){
        if(!this.mounted){
          return;
        }
        setState(() {
          iffrend=false;
        });
      };
    },
      headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
      params: {"userid":user.id},

    );
  }
  void _handle_frendlike_oprate(){
    if(iffrend==false){
      NetUtil.put(Api.MAKE_FRIENDS+user.id+'/', (data) async{
        if(data['info']=='success'){
          requestToast("关注成功");
          if(!this.mounted){
            return;
          }
          setState(() {
            iffrend=true;
          });
        }
      },
          headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
          errorCallBack: (error){
            if(error.containsKey('leancloud_error')&&error['leancloud_error']=="You can't follow yourself."){
              requestToast("无法关注自己");
            }
          }
      );
    }
    else{
      NetUtil.delete(Api.MAKE_FRIENDS+user.id+'/', (data) async{
        if(data['info']=='success'){
          requestToast("取关成功");
          if(!this.mounted){
            return;
          }
          setState(() {
            iffrend=false;
          });
        }
      },
          headers: {"Authorization": "Token ${_userAuthModel.session_token}"},
          errorCallBack: (error){
            if(error.containsKey('leancloud_error')&&error['leancloud_error']=="You can't follow yourself."){
              requestToast("无法关注自己");
            }
          }
      );
    }
  }
}