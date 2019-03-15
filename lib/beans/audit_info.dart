class AuditInfo {
  int id;
  int ifAuth;
  String date;
  String realName;
  String schoolName;
  int sex;
  String birth;
  String frontOfIdCard;
  String backOfIdCard;
  String outsideStuCard;
  String insideStuCard;
  int age;

  AuditInfo(
      {this.id,
        this.ifAuth,
        this.date,
        this.realName,
        this.schoolName,
        this.sex,
        this.birth,
        this.frontOfIdCard,
        this.backOfIdCard,
        this.outsideStuCard,
        this.insideStuCard,
        this.age});

  AuditInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ifAuth = json['if_auth'];
    date = json['date'];
    realName = json['real_name'];
    schoolName = json['school_name'];
    sex = json['sex'];
    birth = json['birth'];
    frontOfIdCard = json['front_of_id_card'];
    backOfIdCard = json['back_of_id_card'];
    outsideStuCard = json['outside_stu_card'];
    insideStuCard = json['inside_stu_card'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['if_auth'] = this.ifAuth;
    data['date'] = this.date;
    data['real_name'] = this.realName;
    data['school_name'] = this.schoolName;
    data['sex'] = this.sex;
    data['birth'] = this.birth;
    data['front_of_id_card'] = this.frontOfIdCard;
    data['back_of_id_card'] = this.backOfIdCard;
    data['outside_stu_card'] = this.outsideStuCard;
    data['inside_stu_card'] = this.insideStuCard;
    data['age'] = this.age;
    return data;
  }
}