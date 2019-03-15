import 'package:finerit_app_flutter/apps/profile/components/profile_task_item_widget.dart';
import 'package:finerit_app_flutter/beans/task_info_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileTaskApp extends StatefulWidget{
  ProfileTaskApp({Key key}): super (key: key);
  @override
  State<StatefulWidget> createState() => ProfileTaskAppState();
}

class ProfileTaskAppState extends State<ProfileTaskApp>{
  TaskInfoModel taskInfoModel;
  UserAuthModel userAuthModel;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(loading==false){
      taskInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      init_data();
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title:
        Text("新手任务", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: taskInfoModel.tasks!=null?Column(
          children: <Widget>[
          ]..addAll(get_task_widget_cards()),
        ): SpinKitFadingCircle(color: Color.fromARGB(50, 0, 0, 0),size: 30,),
      ),
    );
  }
  List<Widget> get_task_widget_cards(){
      List<Widget> taskWidgets=[];
      for(int i=0;i<taskInfoModel.tasks.length;i++){
        taskWidgets.add(TaskListItem(taskData: taskInfoModel.tasks[i],index:i));
      }
      return taskWidgets;
  }
  Future init_data() {
    // TODO: implement init_data
    NetUtil.get(Api.TASK_INFO, (data) {
      var itemList = Task.fromJson(data);
      loading=true;
      taskInfoModel.tasks=itemList.data;
    },
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
  }

}