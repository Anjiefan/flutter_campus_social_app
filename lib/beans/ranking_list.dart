import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';

class RankingList {
  List<RankingData> data;

  RankingList({this.data});

  RankingList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<RankingData>();
      json['data'].forEach((v) {
        data.add(new RankingData.fromJson(v));
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

class RankingData {
  String rankingTime;
  String rankingMoney;
  User user;
  Status status;
  String updatedAt;
  String createdAt;
  String objectId;

  RankingData(
      {this.rankingTime,
        this.rankingMoney,
        this.user,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.objectId});

  RankingData.fromJson(Map<String, dynamic> json) {
    rankingTime = json['ranking_time'];
    rankingMoney = json['ranking_money'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    objectId = json['objectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ranking_time'] = this.rankingTime;
    data['ranking_money'] = this.rankingMoney;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['objectId'] = this.objectId;
    return data;
  }
}


