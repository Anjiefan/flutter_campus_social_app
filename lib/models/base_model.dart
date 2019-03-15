import 'dart:convert';
import 'dart:io';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/beans/award_list.dart';
import 'package:finerit_app_flutter/beans/bbs_detail_item.dart';
import 'package:finerit_app_flutter/beans/bbs_list.dart';
import 'package:finerit_app_flutter/beans/comment_list.dart';
import 'package:finerit_app_flutter/beans/message_comment_list.dart';
import 'package:finerit_app_flutter/beans/message_like_list.dart';
import 'package:finerit_app_flutter/beans/money_payment_info_list.dart';
import 'package:finerit_app_flutter/beans/ranking_list.dart';
import 'package:finerit_app_flutter/beans/task_info_list.dart';
import 'package:finerit_app_flutter/commons/prefs_constant.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CommonPageStatus { READY, RUNNING, DONE, ERROR }
enum FilterMenuItem { TOP, FINERCODE, TIME }

abstract class BaseModel extends Model {
  SharedPreferences prefs;
}

abstract class PushMessageModel extends BaseModel {
  int _messageLikeCount;
  int _messageCommentCount;
  int _profileYesterdayCommentCount;
  int _profileYesterdayRankingCount;
  int _profileAwardHistoryCount;
  int _profileTaskCount;

  int get messageLikeCount => _messageLikeCount;

  int get messageCommentCount => _messageCommentCount;

  int get profileYesterdayCommentCount => _profileYesterdayCommentCount;

  int get profileYesterdayRankingCount => _profileYesterdayRankingCount;

  int get profileAwardHistoryCount => _profileAwardHistoryCount;
  int get profileTaskCount => _profileTaskCount;

  Future<Null> _saveMessageLikeCount(int messageLikeCount) async {
    prefs.setInt("message_like_count", messageLikeCount);
  }

  Future<Null> _saveMessageCommentCount(int messageCommentCount) async {
    prefs.setInt("message_comment_count", messageCommentCount);
  }

  Future<Null> _saveProfileYesterdayCommentCount(
      int profileYesterdayCommentCount) async {
    prefs.setInt("profile_yesterday_comment", profileYesterdayCommentCount);
  }

  Future<Null> _saveProfileYesterdayRankingCount(
      int profileYesterdayRankingCount) async {
    prefs.setInt("profile_yesterday_ranking", profileYesterdayRankingCount);
  }

  Future<Null> _saveProfileAwardHistoryCount(
      int profileAwardHistoryCount) async {
    prefs.setInt("profile_award_history", profileAwardHistoryCount);
  }

  Future<Null> _saveProfileTaskCount(
      int profileTaskCount) async {
    prefs.setInt("task", profileTaskCount);
  }

  set messageLikeCount(int messageLikeCount) {
    _saveMessageLikeCount(messageLikeCount);
    _messageLikeCount = messageLikeCount;
    notifyListeners();
  }

  set messageCommentCount(int messageCommentCount) {
    _saveMessageCommentCount(messageCommentCount);
    _messageCommentCount = messageCommentCount;
    notifyListeners();
  }

  set profileYesterdayCommentCount(int profileYesterdayCommentCount) {
    _saveProfileYesterdayCommentCount(profileYesterdayCommentCount);
    _profileYesterdayCommentCount = profileYesterdayCommentCount;
    notifyListeners();
  }

  set profileYesterdayRankingCount(int profileYesterdayRankingCount) {
    _saveProfileYesterdayRankingCount(profileYesterdayRankingCount);
    _profileYesterdayRankingCount = profileYesterdayRankingCount;
    notifyListeners();
  }

  set profileAwardHistoryCount(int profileAwardHistoryCount) {
    _saveProfileAwardHistoryCount(profileAwardHistoryCount);
    _profileAwardHistoryCount = profileAwardHistoryCount;
    notifyListeners();
  }

  set profileTaskCount(int profileTaskCount) {
    _saveProfileTaskCount(profileTaskCount);
    _profileTaskCount = profileTaskCount;
    notifyListeners();
  }

  initCount() {
    _messageLikeCount = prefs.getInt("message_like_count") == null
        ? 0
        : prefs.getInt("message_like_count");
    _messageCommentCount = prefs.getInt("message_comment_count") == null
        ? 0
        : prefs.getInt("message_comment_count");
    _profileYesterdayCommentCount = prefs.getInt("profile_yesterday_comment") == null
        ? 0
        : prefs.getInt("profile_yesterday_comment");
    _profileYesterdayRankingCount = prefs.getInt("profile_yesterday_ranking") == null
        ? 0
        : prefs.getInt("profile_yesterday_ranking");
    profileAwardHistoryCount = prefs.getInt("profile_award_history") == null
        ? 0
        : prefs.getInt("profile_award_history");
    profileTaskCount = prefs.getInt("task") == null
        ? 0
        : prefs.getInt("task");
  }
}

abstract class UserAuthModel extends BaseModel {
  bool _isLogin = false;
  bool _ifAgreeEULA=false;
  String _session_token;
  String _phone;
  String _objectId;
  String _password;

  bool get ifAgreeEULA=> _ifAgreeEULA;

  set ifAgreeEULA(bool ifAgree){
    _saveAgreeEULA(ifAgree);
    _ifAgreeEULA=true;
  }


  CommonPageStatus _state = CommonPageStatus.READY;

  bool get isLogin => _isLogin;

  String get session_token => _session_token;

  String get phone => _phone;

  String get objectId => _objectId;

  String get password => _password;

  CommonPageStatus get state => _state;

  set session_token(String session_token) {
    _saveToken(session_token);
    _session_token = session_token;
    notifyListeners();
  }

  Future<Null> _saveToken(String session_token) async {
    prefs.setString(Constant.SESSION_TOKEN, session_token);
  }
  Future<Null> _saveAgreeEULA(bool ifAgree) async {
    prefs.setBool(Constant.AGREE_EULA, ifAgree);
  }

  Future<Null> _savePassword(String password) async {
    prefs.setString(Constant.PASSWORD, password);
  }

  Future<Null> _saveObjectId(String objectId) async {
    prefs.setString(Constant.OBJECTID, objectId);
  }

  Future<Null> _savePhone(String phone) async {
    prefs.setString(Constant.PHONE, phone);
  }

  set password(String password) {
    _savePassword(password);
    _password = password;
    notifyListeners();
  }

  set objectId(String objectId) {
    _saveObjectId(objectId);
    _objectId = objectId;
    notifyListeners();
  }

  set phone(String phone) {
    _savePhone(phone);
    _phone = phone;
    notifyListeners();
  }

  initAuth() async {
    _session_token=prefs.getString(Constant.SESSION_TOKEN);
    if (_session_token != null && _session_token != "") {
      _isLogin = true;
    }
    _password = prefs.getString('password');
    _phone = prefs.getString('phone');
    _objectId = prefs.getString('objectId');
    _state = CommonPageStatus.RUNNING;
  }

  Future<Null> logout() async {
    bool is_read_licence=prefs.get('is_read_licence');
    prefs.clear();
    _saveAgreeEULA(_ifAgreeEULA);
    prefs.setBool('is_read_licence', is_read_licence);
    _isLogin = false;
    _session_token = null;
    _phone = null;
    _objectId = null;
    _password = null;
    notifyListeners();
  }

  Future<Null> login(String session_token) async {

    _saveToken(session_token);
    _session_token = session_token;
    _ifAgreeEULA=prefs.getBool(Constant.AGREE_EULA);
    _isLogin = true;
    notifyListeners();
  }
}

abstract class UserInfoModel extends BaseModel  {
  User _userInfo;

  User get userInfo => _userInfo;

  set userInfo(User userInfo) {
    _saveUserInfo(userInfo);
    _userInfo = userInfo;
    notifyListeners();
  }

  Future<Null> _saveUserInfo(User userInfo) async {
    prefs.setString(Constant.USER_INFO, json.encode(userInfo));
  }

  initUserInfo() {
    var jsonStr = prefs.getString(Constant.USER_INFO);
    if(jsonStr!=null){
      _userInfo = User.fromJson(json.decode(jsonStr));
    }
  }
}

abstract class BaseBBSModel extends Model {
  BBSItemList _bbsItemList = new BBSItemList();

  List<BBSDetailItem> getData() {
    return _bbsItemList.data;
  }

  void setData(List<BBSDetailItem> bbsItemList) {
    _bbsItemList.data = bbsItemList;
    notifyListeners();
  }

  addAll(List<BBSDetailItem> bbsItemList) {
    _bbsItemList.data.addAll(bbsItemList);
    notifyListeners();
  }

  update(BBSDetailItem data, int index) {
    _bbsItemList.data[index] = data;
    notifyListeners();
  }

  addBegin(BBSDetailItem element) {
    if (_bbsItemList.data != null) {
      _bbsItemList.data.insert(0, element);
      notifyListeners();
    }
  }

  removeByIndex(int index){
    _bbsItemList.data.removeAt(index);
    notifyListeners();
  }

  bool _initData = false;

  set initData(bool b) {
    _initData = b;
  }

  get initData => _initData;
  FilterMenuItem _filterMenuItem = FilterMenuItem.TIME;

  FilterMenuItem get filterMenuItem => _filterMenuItem;

  set filterMenuItem(FilterMenuItem item) {
    _filterMenuItem = item;
  }
}

abstract class BaseMoneyPaymentInfoModel extends Model {
   PaymentInfoList _paymentInfoList = new PaymentInfoList();

  List<PaymentInfoItem> getData() {
    return _paymentInfoList.data;
  }
  double _income = 0.0;
  double _outcome = 0.0;

  set income(double _income){
    _income = _paymentInfoList.income;
  }

  get income => _income;

   set outcome(double _outcome){
     _outcome = _paymentInfoList.outcome;
   }

   get outcome => _outcome;

   void getIncome(){
     _income = _paymentInfoList.income;
   }

  void setData(List<PaymentInfoItem> paymentInfoList) {
    _paymentInfoList.data = paymentInfoList;
    notifyListeners();
  }

  addAll(List<PaymentInfoItem> paymentInfoList) {
    _paymentInfoList.data.addAll(paymentInfoList);
    notifyListeners();
  }

  update(PaymentInfoItem data, int index) {
    _paymentInfoList.data[index] = data;
    notifyListeners();
  }

  addBegin(PaymentInfoItem element) {
    _paymentInfoList.data.insert(0, element);
    notifyListeners();
  }

  bool _initData = false;

  set initData(bool b) {
    _initData = b;
  }

  get initData => _initData;
}

abstract class BaseMessageCommentModel extends Model {
  MessageCommentList _messageCommentList = new MessageCommentList();

  List<MessageCommentItem> getData() {
    return _messageCommentList.data;
  }

  void setData(List<MessageCommentItem> messageCommentList) {
    _messageCommentList.data = messageCommentList;
    notifyListeners();
  }

  addAll(List<MessageCommentItem> messageCommentList) {
    _messageCommentList.data.addAll(messageCommentList);
    notifyListeners();
  }

  update(MessageCommentItem data, int index) {
    _messageCommentList.data[index] = data;
    notifyListeners();
  }

  addBegin(MessageCommentItem element) {
    _messageCommentList.data.insert(0, element);
    notifyListeners();
  }

  bool _initData = false;

  set initData(bool b) {
    _initData = b;
  }

  get initData => _initData;
}

abstract class BaseMessageLikeModel extends Model {
  MessageLikeList _messageLikeList = MessageLikeList();

  List<MessageLikeItem> getData() {
    return _messageLikeList.data;
  }

  void setData(List<MessageLikeItem> messageLikeList) {
    _messageLikeList.data = messageLikeList;
    notifyListeners();
  }

  addAll(List<MessageLikeItem> messageLikeList) {
    _messageLikeList.data.addAll(messageLikeList);
    notifyListeners();
  }

  update(MessageLikeItem data, int index) {
    _messageLikeList.data[index] = data;
    notifyListeners();
  }

  addBegin(MessageLikeItem element) {
    _messageLikeList.data.insert(0, element);
    notifyListeners();
  }

  bool _initData = false;

  set initData(bool b) {
    _initData = b;
  }

  get initData => _initData;
}

abstract class BaseComment extends Model {
  CommentList _commentList = new CommentList();

  List<DataComment> get commentList => _commentList.data ?? [];

  set commentList(List<DataComment> dataComment) {
    _commentList.data = dataComment;
    notifyListeners();
  }

  addAllComments(List<DataComment> dataComment) {
    _commentList.data.addAll(dataComment);
    notifyListeners();
  }

  addBeginComment(DataComment element) {
    _commentList.data.insert(0, element);
    notifyListeners();
  }

  updateComment(DataComment data, int index) {
    _commentList.data[index] = data;
    notifyListeners();
  }
//  removeCommentByIndex(int index){
//    _commentList.data.removeAt(index);
//    notifyListeners();
//  }
}

abstract class VoiceModel extends Model {
  File _voiceFile;

  get voiceFile => _voiceFile;

  set voiceFile(File element) {
    _voiceFile = element;
    notifyListeners();
  }

  void clear() {
    _voiceFile = null;
    notifyListeners();
  }
}

abstract class StatusModel extends Model {
  List<String> _searchs = [];

  List<String> get searchs => _searchs;

  void insert(String searchItem) {
    _searchs.add(searchItem);
    notifyListeners();
  }

  void remove(String item) {
    _searchs.remove(item);
    notifyListeners();
  }
}

abstract class BaseFrendInfoModel extends Model {
  List<User> _userInfos;

  get userInfos => _userInfos;

  set userInfos(List<User> queryset) {
    _userInfos = queryset;
    notifyListeners();
  }

  void addAll(List<User> queryset) {
    _userInfos.addAll(queryset);
    notifyListeners();
  }

  void insertBegin(User searchItem) {
    _userInfos.insert(0, searchItem);
    notifyListeners();
  }

  void remove(User searchItem) {
    _userInfos.remove(searchItem);
    notifyListeners();
  }
}

abstract class RankingInfoModel extends Model {
  String _rankingDayStr;

  get rankingDayStr => _rankingDayStr;

  set rankingDayStr(String rankingStr) {
    _rankingDayStr = rankingStr;
  }

  List<RankingData> _rankings;

  get rankings => _rankings;

  set rankings(List<RankingData> queryset) {
    _rankings = queryset;
    notifyListeners();
  }

  void addAllRank(List<RankingData> queryset) {
    _rankings.addAll(queryset);
    notifyListeners();
  }

  void insertBeginRank(RankingData searchItem) {
    _rankings.insert(0, searchItem);
    notifyListeners();
  }

  void removeRank(RankingData searchItem) {
    _rankings.remove(searchItem);
    notifyListeners();
  }
}

abstract class TaskInfoModel extends Model {

  List<TaskData> _tasks;

  get tasks => _tasks;

  set tasks(List<TaskData> queryset) {
    _tasks = queryset;
    notifyListeners();
  }

  void addAllTask(List<TaskData> queryset) {
    _tasks.addAll(queryset);
    notifyListeners();
  }

  void insertBeginTask(TaskData item) {
    _tasks.insert(0, item);
    notifyListeners();
  }
  void replaceInIndexTask(int index,TaskData item){
    _tasks[index]=item;
    notifyListeners();
  }
  void removeTask(TaskData item) {
    _tasks.remove(item);
    notifyListeners();
  }
}

abstract class AwardInfoModel extends Model {
  List<AwardData> _awards;

  get awards => _awards;

  set awards(List<AwardData> queryset) {
    _awards = queryset;
    notifyListeners();
  }

  void addAllAward(List<AwardData> queryset) {
    _awards.addAll(queryset);
    notifyListeners();
  }

  void insertBeginAward(AwardData data) {
    _awards.insert(0, data);
    notifyListeners();
  }

  void removeAward(AwardData searchItem) {
    _awards.remove(searchItem);
    notifyListeners();
  }
}

abstract class AwardCommentInfoModel extends Model {
  String _awardCommentDayStr;

  get awardCommentStr => _awardCommentDayStr;

  set awardCommentStr(String rankingStr) {
    _awardCommentDayStr = rankingStr;
  }

  List<AwardData> _awardComments;

  get awardComments => _awardComments;

  set awardComments(List<AwardData> queryset) {
    _awardComments = queryset;
    notifyListeners();
  }

  void addAllCommentAward(List<AwardData> queryset) {
    _awardComments.addAll(queryset);
    notifyListeners();
  }

  void insertBeginCommentAward(AwardData data) {
    _awardComments.insert(0, data);
    notifyListeners();
  }

  void removeCommentAward(AwardData searchItem) {
    _awardComments.remove(searchItem);
    notifyListeners();
  }
}

abstract class AwardStatusInfoModel extends Model {
  String _awardStatusDayStr;

  get awardStatusStr => _awardStatusDayStr;

  set awardStatusStr(String rankingStr) {
    _awardStatusDayStr = rankingStr;
  }

  List<AwardData> _awardStatuss;

  get awardStatuss => _awardStatuss;

  set awardStatuss(List<AwardData> queryset) {
    _awardStatuss = queryset;
    notifyListeners();
  }

  void addAllStatusAward(List<AwardData> queryset) {
    _awardStatuss.addAll(queryset);
    notifyListeners();
  }

  void insertBeginStatusAward(AwardData data) {
    _awardStatuss.insert(0, data);
    notifyListeners();
  }

  void removeStatusAward(AwardData searchItem) {
    _awardStatuss.remove(searchItem);
    notifyListeners();
  }
}

abstract class FrendNumInfoModel extends Model{
  int _follower_num=0;
  int _followee_num=0;
  int _frend_num=0;
  get follower_num=>_follower_num;
  get followee_num=>_followee_num;
  get frend_num=>_frend_num;
  void setFrendInfo(int follower_num,int followee_num,int frend_num){
    _follower_num=follower_num;
    _followee_num=followee_num;
    _frend_num=frend_num;
    notifyListeners();
  }
}

class MainStateModel extends Model
    with
        BaseModel,
        UserAuthModel,
        UserInfoModel,
        StatusModel,
        VoiceModel,
        RankingInfoModel,
        AwardInfoModel,
        AwardCommentInfoModel,
        AwardStatusInfoModel,
        TaskInfoModel,
        FrendNumInfoModel,
        PushMessageModel {
  MainStateModel(SharedPreferences _prefs) {
    prefs=_prefs;
    initAuth();
    initUserInfo();
    initCount();
  }
}
