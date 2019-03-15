import 'package:finerit_app_flutter/beans/base_user_item.dart';

class CommentList {
  List<DataComment> data;

  CommentList({this.data});

  CommentList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DataComment>();
      json['data'].forEach((v) {
        data.add(new DataComment.fromJson(v));
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

class DataComment {
  List<String> likesUser;
  List<String> commentsUser;
  Comment comment;
  String createdAt;
  String updatedAt;
  String objectId;
  String sincePosted;
  bool like;
  DataComment(
      {this.likesUser,
        this.commentsUser,
        this.comment,
        this.createdAt,
        this.updatedAt,
        this.objectId,
        this.sincePosted});

  DataComment.fromJson(Map<String, dynamic> json) {
    likesUser = json['likes_user'].cast<String>();
    commentsUser = json['comments_user'].cast<String>();
    comment =
    json['comment'] != null ? new Comment.fromJson(json['comment']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    objectId = json['objectId'];
    sincePosted = json['since_posted'];
    like = json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likes_user'] = this.likesUser;
    data['comments_user'] = this.commentsUser;
    if (this.comment != null) {
      data['comment'] = this.comment.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['objectId'] = this.objectId;
    data['since_posted'] = this.sincePosted;
    data['like'] = this.like;
    return data;
  }
}

class Comment {
  String updatedAt;
  String interactive;
  String objectId;
  Comments comments;
  String createdAt;
  String likes;
  Status status;
  String score;
  User user;
  String text;

  Comment(
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

  Comment.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updatedAt'];
    interactive = json['interactive'];
    objectId = json['objectId'];
    comments = json['comments'] != null
        ? new Comments.fromJson(json['comments'])
        : null;
    createdAt = json['createdAt'];
    likes = json['likes'];
    status =
    json['status'] != null ? new Status.fromJson(json['status']) : null;
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
  Status status;
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
    json['status'] != null ? new Status.fromJson(json['status']) : null;
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

class Status {
  String address;
  String updatedAt;
  String music;
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
