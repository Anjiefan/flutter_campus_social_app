import 'package:finerit_app_flutter/apps/bbs/bbs_replay.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/apps/profile/model/profile_model.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/beans/ranking_list.dart';
import 'package:finerit_app_flutter/beans/task_info_list.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:finerit_app_flutter/commons/dicts.dart';
class TaskListItem extends StatefulWidget{
  int index;
  TaskData taskData;
  TaskListItem({Key key,
    @required this.taskData,
    @required this.index}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TaskListItemState(
      taskData: taskData,
      index: index
    );
  }
}
class TaskListItemState extends State<TaskListItem>{
  TaskListItemState({Key key,
    @required this.taskData,
    @required this.index}):super();
  int index;
  TaskData taskData;
  UserAuthModel userAuthModel;
  MainStateModel model;
  TaskInfoModel taskInfoModel;
  String type='';
  String achiveType='';
  bool loading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  void initTaskAchiveType(){
    if(taskData.taskid=='com.finerit.ten_use_your_invitation_code'){
      NetUtil.get(Api.TASK_TEN_PEPOLE_INVITE, (data) {
        if(int.parse(data['info'])>=10&&taskData.ifComplete==false){
          taskData.ifComplete=true;
          taskInfoModel.replaceInIndexTask(index, taskData);
        }
        if(!this.mounted){
          return;
        }
        setState(() {
          achiveType='完成度${data["info"]}/10';
          loading=true;
        });

      },
        headers: {"Authorization": "Token ${userAuthModel.session_token}"},
      );
    }
      if(taskData.ifComplete==false){
        type='未完成';
        achiveType='完成度0/1';
      }
      else{
        if(taskData.ifGet==false){
          type='领取奖励';
          achiveType='完成度1/1';
        }
        else{
          type='已领取';
          achiveType='完成度1/1';
        }
      }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userAuthModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    taskInfoModel=ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    model = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    taskData=taskInfoModel.tasks[index];
    if(loading==false){
      initTaskAchiveType();
    }


    return Container(
      margin: EdgeInsets.only(top: 3),
      padding: EdgeInsets.only(left: 10,right: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Image.asset(Dicts.TASK_IMAGES[taskData.taskid]),
            width: 40,
            height: 40,
          ),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(taskData.taskDsc,style: TextStyle(fontSize: 15),),
              ),
              Container(
                child: Text('奖励：随机获得1~${taskData.awardRange}个凡尔币',style: TextStyle(fontSize: 10),),
              )
            ],
          )),
          Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                type=='领取奖励'?RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: (){
                    handle_over_task(context);
                  },
                  child: Text("$type"),
                ):Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text("$type"),
                ),
//                Text("$type"),
                Container(
                  child: Text("$achiveType"),
                )
              ],
            ),
            margin: EdgeInsets.only(bottom: 3),
          )
        ],
      ),
    );
  }
  void handle_over_task(var context){
    NetUtil.get(Api.TASK_INFO+taskData.objectId+'/', (data) {
      model.profileTaskCount >= 1?
      model.profileTaskCount = model.profileTaskCount - 1:
      print("推送数量显示异常");
      showDialog(
          context: context,builder: (context){
        return StatefulBuilder(
            builder: (context, state) {
              return new AssetGiffyDialog(
                imagePath: 'assets/open_box.gif',
                title:Text('领取奖励',textAlign: TextAlign.center,
                  style: TextStyle( fontWeight: FontWeight.w600,fontSize: 20),),
                description: Text(data['info']),
                buttonOkText:Text('确定'),
                buttonCancelText: Text('取消'),
                onOkButtonPressed: () async {
                  Navigator.pop(context);
                },
              );
            }
        );
      }
      );
      taskData.ifGet=true;
      taskInfoModel.replaceInIndexTask(index, taskData);
      initTaskAchiveType();
    },
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
  }

}