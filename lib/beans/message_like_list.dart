import 'package:finerit_app_flutter/beans/base_user_item.dart';

class MessageLikeList {
  List<MessageLikeItem> data;

  MessageLikeList({this.data});

  MessageLikeList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MessageLikeItem>();
      json['data'].forEach((v) {
        data.add(new MessageLikeItem.fromJson(v));
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

class MessageLikeItem {
  StatusMessage status;
  User user;
  CommentMessage comment;
  String createdAt;
  String updatedAt;
  String objectId;
  String sincePosted;

  MessageLikeItem(
      {this.status,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.objectId,
        this.sincePosted});

  MessageLikeItem.fromJson(Map<String, dynamic> json) {
    status =
    json['status'] != null ? new StatusMessage.fromJson(json['status']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    objectId = json['objectId'];
    sincePosted = json['since_posted'];
    comment =
    json['comment'] != null ? new CommentMessage.fromJson(json['comment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.comment != null) {
      data['comment'] = this.comment.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['objectId'] = this.objectId;
    data['since_posted'] = this.sincePosted;

    return data;
  }
}

class CommentMessage {
  String updatedAt;
  String interactive;
  String objectId;
  Comments comments;
  String createdAt;
  String likes;
  StatusMessage status;
  String score;
  User user;
  String text;

  CommentMessage(
      {this.updatedAt,
        this.interactive,
        this.objectId,
        this.comments,
        this.createdAt,
        this.likes,
        this.status,
        this.score,
        this.user,
        this.text});

  CommentMessage.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updatedAt'];
    interactive = json['interactive'];
    objectId = json['objectId'];
    comments = json['comments'] != null
        ? new Comments.fromJson(json['comments'])
        : null;
    createdAt = json['createdAt'];
    likes = json['likes'];
    status =
    json['status'] != null ? new StatusMessage.fromJson(json['status']) : null;
    score = json['score'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    text = json['text'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updatedAt'] = this.updatedAt;
    data['interactive'] = this.interactive;
    data['objectId'] = this.objectId;
    if (this.comments != null) {
      data['comments'] = this.comments.toJson();
    }
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

    return data;
  }
}

class Comments {
  String updatedAt;
  String interactive;
  String objectId;
  String createdAt;
  String likes;
  StatusMessage status;
  String score;
  User user;
  String text;

  Comments(
      {this.updatedAt,
        this.interactive,
        this.objectId,
        this.createdAt,
        this.likes,
        this.status,
        this.score,
        this.user,
        this.text});

  Comments.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updatedAt'];
    interactive = json['interactive'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    likes = json['likes'];
    status =
    json['status'] != null ? new StatusMessage.fromJson(json['status']) : null;
    score = json['score'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    text = json['text'];
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
    return data;
  }
}

class StatusMessage {
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
  User user;

  StatusMessage(
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
        this.text,
        this.user});

  StatusMessage.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
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
