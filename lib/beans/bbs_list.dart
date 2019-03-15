import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';

class BBSItemList {
  List<BBSDetailItem> data;
  BBSItemList({this.data});

  BBSItemList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<BBSDetailItem>();
      json['data'].forEach((v) {
        data.add(new BBSDetailItem.fromJson(v));
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


class Status {
  String address;
  String updatedAt;
  String music;
  String musicName;
  String school;
  List<String> images;
  String objectId;
  String inboxType;
  String createdAt;
  String video;
  String fineritCode;
  String userId;
  Location location;
  String text;

  Status(
      {this.address,
        this.updatedAt,
        this.music,
        this.musicName,
        this.school,
        this.images,
        this.objectId,
        this.inboxType,
        this.createdAt,
        this.video,
        this.fineritCode,
        this.userId,
        this.location,
        this.text});

  Status.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    updatedAt = json['updatedAt'];
    music = json['music'];
    school = json['school'];
    images = json['images'].cast<String>();
    objectId = json['objectId'];
    inboxType = json['inboxType'];
    createdAt = json['createdAt'];
    musicName=json['music_name'];
    video = json['video'];
    fineritCode = json['finerit_code'];
    userId = json['user_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['updatedAt'] = this.updatedAt;
    data['music'] = this.music;
    data['school'] = this.school;
    data['images'] = this.images;
    data['objectId'] = this.objectId;
    data['music_name']=this.musicName;
    data['inboxType'] = this.inboxType;
    data['createdAt'] = this.createdAt;
    data['video'] = this.video;
    data['finerit_code'] = this.fineritCode;
    data['user_id'] = this.userId;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['text'] = this.text;
    return data;
  }
}

class Location {
  String latitude;
  String longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

