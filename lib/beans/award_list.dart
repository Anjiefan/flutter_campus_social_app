import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';

class AwardList {
  List<AwardData> data;

  AwardList({this.data});

  AwardList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<AwardData>();
      json['data'].forEach((v) { data.add(new AwardData.fromJson(v)); });
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

class AwardData {
  String money;
  CommentAward comment;
  StatusAward status;
  String ranking;
  User user;
  String operateTime;
  String updatedAt;
  String objectId;
  String createdAt;
  String sincePosted;
  String statusSincePosted;
  String commentSincePosted;
  String rankingName;
  String awardTime;
  AwardData({this.commentSincePosted,this.statusSincePosted,this.rankingName,this.money, this.comment, this.status, this.ranking, this.user, this.operateTime, this.updatedAt, this.objectId, this.createdAt, this.sincePosted});

  AwardData.fromJson(Map<String, dynamic> json) {
    money = json['money'];
    status =
    json['status'] != null ? new StatusAward.fromJson(json['status']) : null;
    ranking = json['ranking'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rankingName = json['rankingName'];
    awardTime = json['awardTime'];
    operateTime = json['operateTime'];
    updatedAt = json['updatedAt'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    comment =
    json['comment'] != null ? new CommentAward.fromJson(json['comment']) : null;
    sincePosted = json['since_posted'];
    statusSincePosted = json['status_since_posted'];
    commentSincePosted = json['comment_since_posted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['money'] = this.money;
    if (this.comment != null) {
      data['comment'] = this.comment.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['ranking'] = this.ranking;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['operateTime'] = this.operateTime;
    data['updatedAt'] = this.updatedAt;
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    data['since_posted'] = this.sincePosted;
    data['status_since_posted'] = this.statusSincePosted;
    data['comment_since_posted'] = this.commentSincePosted;
    data['rankingName'] = this.rankingName;
    data['awardTime'] = this.awardTime;
    return data;
  }
}

class CommentAward {
  String updatedAt;
  String interactive;
  String objectId;
  Comments comments;
  String createdAt;
  String likes;
  StatusAward status;
  String score;
  User user;
  String text;

  CommentAward(
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

  CommentAward.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updatedAt'];
    interactive = json['interactive'];
    objectId = json['objectId'];
    comments = json['comments'] != null
        ? new Comments.fromJson(json['comments'])
        : null;
    createdAt = json['createdAt'];
    likes = json['likes'];
    status =
    json['status'] != null ? new StatusAward.fromJson(json['status']) : null;
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

class StatusAward {
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
  User userId;
  Location location;
  String text;

  StatusAward(
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
        this.text}
        );

  StatusAward.fromJson(Map<String, dynamic> json) {
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
    try{
      userId =
      json['user_id'] != null ? new User.fromJson(json['user_id']) : null;
    }catch (e) {
      json['user_id']=null;
    };
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
    if (this.userId != null) {
      data['user_id'] = this.userId.toJson();
    }
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
