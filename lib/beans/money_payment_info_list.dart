import 'package:finerit_app_flutter/beans/base_user_item.dart';

class PaymentInfoList {
  List<PaymentInfoItem> data;
  double income;
  double outcome;
  PaymentInfoList({this.data, this.income, this.outcome});

  PaymentInfoList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<PaymentInfoItem>();
      json['data'].forEach((v) {
        data.add(new PaymentInfoItem.fromJson(v));
      });
    }
    income = json['income'];
    outcome = json['outcome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['income'] = this.income;
    data['outcome'] = this.outcome;
    return data;
  }
}

class PaymentInfoItem {
  String billFee;
  String billNo;
  String buyerId;
  String channel;
  String couponId;
  String createTime;
  String discount;
  String id;
  String lastRefundNo;
  String operatorId;
  String currentFee;
  String optional;
  String partitionId;
  bool refundResult;
  bool revertResult;
  String sellerId;
  bool spayResult;
  String subChannel;
  String successTime;
  String title;
  String totalFee;
  String tradeNo;
  User user;
  String wdErrorDetail;
  String wdId;
  String wdResultCode;
  String wdResultMsg;
  String wdUrl;
  String infoType;
  String updatedAt;
  String objectId;
  String createdAt;
  String operate;

  PaymentInfoItem(
      {this.billFee,
        this.billNo,
        this.buyerId,
        this.channel,
        this.couponId,
        this.createTime,
        this.discount,
        this.id,
        this.lastRefundNo,
        this.operatorId,
        this.currentFee,
        this.optional,
        this.partitionId,
        this.refundResult,
        this.revertResult,
        this.sellerId,
        this.spayResult,
        this.subChannel,
        this.successTime,
        this.title,
        this.totalFee,
        this.tradeNo,
        this.user,
        this.wdErrorDetail,
        this.wdId,
        this.wdResultCode,
        this.wdResultMsg,
        this.wdUrl,
        this.infoType,
        this.updatedAt,
        this.objectId,
        this.createdAt,
        this.operate});

  PaymentInfoItem.fromJson(Map<String, dynamic> json) {
    billFee = json['bill_fee'];
    billNo = json['bill_no'];
    buyerId = json['buyer_id'];
    channel = json['channel'];
    couponId = json['coupon_id'];
    createTime = json['create_time'];
    discount = json['discount'];
    id = json['id'];
    lastRefundNo = json['last_refund_no'];
    operatorId = json['operator_id'];
    currentFee = json['current_fee'];
    optional = json['optional'];
    partitionId = json['partition_id'];
    refundResult = json['refund_result'];
    revertResult = json['revert_result'];
    sellerId = json['seller_id'];
    spayResult = json['spay_result'];
    subChannel = json['sub_channel'];
    successTime = json['success_time'];
    title = json['title'];
    totalFee = json['total_fee'];
    tradeNo = json['trade_no'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    wdErrorDetail = json['wd_error_detail'];
    wdId = json['wd_id'];
    wdResultCode = json['wd_result_code'];
    wdResultMsg = json['wd_result_msg'];
    wdUrl = json['wd_url'];
    infoType = json['info_type'];
    updatedAt = json['updatedAt'];
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    operate = json['operate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bill_fee'] = this.billFee;
    data['bill_no'] = this.billNo;
    data['buyer_id'] = this.buyerId;
    data['channel'] = this.channel;
    data['coupon_id'] = this.couponId;
    data['create_time'] = this.createTime;
    data['discount'] = this.discount;
    data['id'] = this.id;
    data['last_refund_no'] = this.lastRefundNo;
    data['operator_id'] = this.operatorId;
    data['current_fee'] = this.currentFee;
    data['optional'] = this.optional;
    data['partition_id'] = this.partitionId;
    data['refund_result'] = this.refundResult;
    data['revert_result'] = this.revertResult;
    data['seller_id'] = this.sellerId;
    data['spay_result'] = this.spayResult;
    data['sub_channel'] = this.subChannel;
    data['success_time'] = this.successTime;
    data['title'] = this.title;
    data['total_fee'] = this.totalFee;
    data['trade_no'] = this.tradeNo;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['wd_error_detail'] = this.wdErrorDetail;
    data['wd_id'] = this.wdId;
    data['wd_result_code'] = this.wdResultCode;
    data['wd_result_msg'] = this.wdResultMsg;
    data['wd_url'] = this.wdUrl;
    data['info_type'] = this.infoType;
    data['updatedAt'] = this.updatedAt;
    data['objectId'] = this.objectId;
    data['createdAt'] = this.createdAt;
    data['operate'] = this.operate;
    return data;
  }
}

//class User {
//  String id;
//  String money;
//  String voucher;
//  String schoolName;
//  String realName;
//  bool ifAuth;
//  String date;
//  String constellation;
//  String animals;
//  String sex;
//  String age;
//  String birth;
//  String headImg;
//  String nickName;
//  String installationid;
//  String phone;
//
//  User(
//      {this.id,
//        this.money,
//        this.voucher,
//        this.schoolName,
//        this.realName,
//        this.ifAuth,
//        this.date,
//        this.constellation,
//        this.animals,
//        this.sex,
//        this.age,
//        this.birth,
//        this.headImg,
//        this.nickName,
//        this.installationid,
//        this.phone});
//
//  User.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    money = json['money'];
//    voucher = json['voucher'];
//    schoolName = json['school_name'];
//    realName = json['real_name'];
//    ifAuth = json['if_auth'];
//    date = json['date'];
//    constellation = json['constellation'];
//    animals = json['animals'];
//    sex = json['sex'];
//    age = json['age'];
//    birth = json['birth'];
//    headImg = json['head_img'];
//    nickName = json['nick_name'];
//    installationid = json['installationid'];
//    phone = json['phone'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['money'] = this.money;
//    data['voucher'] = this.voucher;
//    data['school_name'] = this.schoolName;
//    data['real_name'] = this.realName;
//    data['if_auth'] = this.ifAuth;
//    data['date'] = this.date;
//    data['constellation'] = this.constellation;
//    data['animals'] = this.animals;
//    data['sex'] = this.sex;
//    data['age'] = this.age;
//    data['birth'] = this.birth;
//    data['head_img'] = this.headImg;
//    data['nick_name'] = this.nickName;
//    data['installationid'] = this.installationid;
//    data['phone'] = this.phone;
//    return data;
//  }
//}