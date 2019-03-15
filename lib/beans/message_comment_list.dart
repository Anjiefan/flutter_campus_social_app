import 'package:finerit_app_flutter/beans/base_user_item.dart';

class MessageCommentList {
  List<MessageCommentItem> data;

  MessageCommentList({this.data});

  MessageCommentList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MessageCommentItem>();
      json['data'].forEach((v) {
        data.add(new MessageCommentItem.fromJson(v));
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

class MessageCommentItem {
  String updatedAt;
  String interactive;
  String objectId;
  String createdAt;
  String likes;
  Status status;
  String score;
  User user;
  String text;
  String sincePosted;

  MessageCommentItem(
      {this.updatedAt,
        this.interactive,
        this.objectId,
        this.createdAt,
        this.likes,
        this.status,
        this.score,
        this.user,
        this.text,
      this.sincePosted});

  MessageCommentItem.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updatedAt'];
    interactive = json['interactive'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    likes = json['likes'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
    score = json['score'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    text = json['text'];
    sincePosted = json['since_posted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updatedAt'] = this.updatedAt;
    data['interactive'] = this.interactive;
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    data['likes'] = this.likes;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['score'] = this.score;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['text'] = this.text;
    data['since_posted'] = this.sincePosted;
    return data;
  }
}

class Status {
  String video;
  String address;
  String updatedAt;
  String music;
  String school;
  List<String> images;
  String objectId;
  String inboxType;
  String createdAt;
  String vedio;
  String fineritCode;
  String musicName;
  String userId;
  Location location;
  String text;

  Status(
      {this.video,
        this.address,
        this.updatedAt,
        this.music,
        this.school,
        this.images,
        this.objectId,
        this.inboxType,
        this.createdAt,
        this.vedio,
        this.fineritCode,
        this.musicName,
        this.userId,
        this.location,
        this.text});

  Status.fromJson(Map<String, dynamic> json) {
    video = json['video'];
    address = json['address'];
    updatedAt = json['updatedAt'];
    music = json['music'];
    school = json['school'];
    images = json['images'].cast<String>();
    objectId = json['objectId'];
    inboxType = json['inboxType'];
    createdAt = json['createdAt'];
    vedio = json['vedio'];
    fineritCode = json['finerit_code'];
    musicName = json['music_name'];
    userId = json['user_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video'] = this.video;
    data['address'] = this.address;
    data['updatedAt'] = this.updatedAt;
    data['music'] = this.music;
    data['school'] = this.school;
    data['images'] = this.images;
    data['objectId'] = this.objectId;
    data['inboxType'] = this.inboxType;
    data['createdAt'] = this.createdAt;
    data['vedio'] = this.vedio;
    data['finerit_code'] = this.fineritCode;
    data['music_name'] = this.musicName;
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
