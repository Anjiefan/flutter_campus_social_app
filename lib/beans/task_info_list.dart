import 'package:finerit_app_flutter/beans/base_user_item.dart';

class Task {
  List<TaskData> data;

  Task({this.data});

  Task.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<TaskData>();
      json['data'].forEach((v) {
        data.add(new TaskData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskData {
  User user;
  String taskid;
  String taskDsc;
  String awardRange;
  String award;
  bool ifComplete;
  bool ifGet;
  String updatedAt;
  String objectId;
  String createdAt;

  TaskData(
      {this.user,
        this.taskid,
        this.taskDsc,
        this.awardRange,
        this.award,
        this.ifComplete,
        this.updatedAt,
        this.objectId,
        this.createdAt});

  TaskData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    taskid = json['taskid'];
    taskDsc = json['task_dsc'];
    awardRange = json['award_range'];
    award = json['award'];
    ifComplete = json['if_complete'];
    ifGet = json['if_get'];
    updatedAt = json['updatedAt'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['taskid'] = this.taskid;
    data['task_dsc'] = this.taskDsc;
    data['award_range'] = this.awardRange;
    data['award'] = this.award;
    data['if_complete'] = this.ifComplete;
    data['if_get'] = this.ifGet;
    data['updatedAt'] = this.updatedAt;
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
