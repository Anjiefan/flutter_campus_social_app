import 'package:finerit_app_flutter/apps/bbs/state/bbs_state.dart';
import 'package:finerit_app_flutter/commons/http_error.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/extra_apps/location/lib/amap_location.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/permissions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class BBSRecommendTab extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => BBSRecommendTabState();
}

class BBSCountryTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BBSCountryTabState();
}

class BBSNeighborhoodTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BBSNeighborhoodTabState();
}

class BBSSchoolTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BBSSchoolTabState();
}

class BBSFriendTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BBSFriendTabState();
}



class BBSRecommendTabState extends BBSState<BBSRecommendTab> {
  String state='推荐';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}

class BBSCountryTabState extends BBSState<BBSCountryTab>{

  String state='全国';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}

class BBSNeighborhoodTabState extends BBSState<BBSNeighborhoodTab>{

  String state='附近';
  AMapLocation _loc;
  @override
  void initState() {
    AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    super.initState();

  }
  Future _getLocation() async {
    bool ifPermis=await FinerPermission.requestLocationPersmission();
    if(ifPermis){
      AMapLocation loc = await AMapLocationClient.getLocation(true);
      if(_loc==null){
        if(!this.mounted){
          return;
        }
        setState(() {
          _loc = loc;
        });
        return ;
      }
      if(_loc.formattedAddress==null){
        if(!this.mounted){
          return;
        }
        setState(() {
          _loc = loc;
        });
        return ;
      }
      if(_loc.formattedAddress!=loc.formattedAddress&&loc!=null){
        if(!this.mounted){
          return;
        }
        setState(() {
          _loc = loc;
        });
      }
    }
  }
  Future init_data() async {
    await _getLocation();
    if(_loc.formattedAddress==null){
      requestToast("定位失败，请授权定位权限");
      return;
    }
    
//    if(bbsModel.getData()==null||bbsModel.getData().length==0){
//      if(bbsModel.initData==false){
    if(loading==false) {
      NetUtil.get(Api.BBS_BASE, (data) {
        var itemList = BBSItemList.fromJson(data);
        if (itemList.data.length != 0) {
          bbsModel.setData(itemList.data);
        }
        if(!this.mounted){
          return;
        }
        setState(() {
          bbsModel.initData=true;
          loading=true;
        });

//        setState(() {
//          bbsModel.initData = true;
//        });
        //TODO 界面显示数据
      },
          headers: {"Authorization": "Token ${userAuthModel.session_token}"},
          params: {
            "state": state,
            "filter": filter,
            'page': 0,
            'latitude': _loc.latitude,
            'longitude': _loc.longitude
          },
          errorCallBack: (error){
        requestToast(HttpError.getErrorData(error).toString());
        if(!this.mounted){
          return;
        }
        setState(() {
          bbsModel.initData=true;
          loading=true;
        });
      });
    }
        //      }
//    }
  }
  Future load_more_data()async{
    if(_loc==null){
      await _getLocation();
    }
    NetUtil.get(Api.BBS_BASE, (data) {
      var itemList = BBSItemList.fromJson(data);
      page=page+1;
      bbsModel.addAll(itemList.data);
    },
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
      params: {"state": state, "filter": filter,'page':page,'latitude':_loc.latitude,'longitude':_loc.longitude},
    );
  }
  Future refresh_data()async{
    if(_loc==null){
      await _getLocation();
    }
    String sessionToken = userAuthModel.session_token;
    NetUtil.get(Api.BBS_BASE, (data) {
      var itemList = BBSItemList.fromJson(data);
      bbsModel.setData([]);
      bbsModel.addAll(itemList.data);
      if(!this.mounted){
        return;
      }
      setState(() {
        page=1;
      });
    },
      headers: {"Authorization": "Token $sessionToken"},
        params: {"state": state, "filter": filter,'page':0,'latitude':_loc.latitude,'longitude':_loc.longitude});

  }
}

class BBSSchoolTabState extends BBSState<BBSSchoolTab> {
  String state='本校';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}

class BBSFriendTabState extends BBSState<BBSFriendTab> {
  String state='朋友';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}

