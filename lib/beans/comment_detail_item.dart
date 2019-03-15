class CommentItem {
  String updatedAt;
  String interactive;
  String objectId;
  String createdAt;
  String likes;
  String score;
  User user;
  String text;
  String sincePosted;

  CommentItem(
      {this.updatedAt,
        this.interactive,
        this.objectId,
        this.createdAt,
        this.likes,
        this.score,
        this.user,
        this.text,
        this.sincePosted});

  CommentItem.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updatedAt'];
    interactive = json['interactive'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    likes = json['likes'];
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
    data['score'] = this.score;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['text'] = this.text;
    data['since_posted'] = this.sincePosted;
    return data;
  }
}

class User {
  String id;
  String money;
  String voucher;
  String schoolName;
  String realName;
  bool ifAuth;
  String date;
  String constellation;
  String animals;
  String sex;
  String age;
  String birth;
  String headImg;
  String phone;
  String nickName;

  User(
      {this.id,
        this.money,
        this.voucher,
        this.schoolName,
        this.realName,
        this.ifAuth,
        this.date,
        this.constellation,
        this.animals,
        this.sex,
        this.age,
        this.birth,
        this.headImg,
        this.phone,
        this.nickName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    money = json['money'];
    voucher = json['voucher'];
    schoolName = json['school_name'];
    realName = json['real_name'];
    ifAuth = json['if_auth'];
    date = json['date'];
    constellation = json['constellation'];
    animals = json['animals'];
    sex = json['sex'];
    age = json['age'];
    birth = json['birth'];
    headImg = json['head_img'];
    phone = json['phone'];
    nickName = json['nick_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['money'] = this.money;
    data['voucher'] = this.voucher;
    data['school_name'] = this.schoolName;
    data['real_name'] = this.realName;
    data['if_auth'] = this.ifAuth;
    data['date'] = this.date;
    data['constellation'] = this.constellation;
    data['animals'] = this.animals;
    data['sex'] = this.sex;
    data['age'] = this.age;
    data['birth'] = this.birth;
    data['head_img'] = this.headImg;
    data['phone'] = this.phone;
    data['nick_name'] = this.nickName;
    return data;
  }
}