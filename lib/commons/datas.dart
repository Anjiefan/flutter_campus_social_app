import 'package:finerit_app_flutter/apps/contact/components/suspension_listview.dart';
import 'package:lpinyin/lpinyin.dart';

class MessageItem implements Comparable<MessageItem> {
  MessageItem({ this.index, this.name, this.message, this.imageUrl });

  MessageItem.from(MessageItem item)
      : index = item.index, name = item.name, message = item.message, imageUrl = item.imageUrl;

  final int index;
  final String name;
  final String message;
  final String imageUrl;

  @override
  int compareTo(MessageItem other) => index.compareTo(other.index);
}

class FakeAvatars{
  static final String avatar1 = "http://img01.store.sogou.com/app/a/10010016/9b8482b0b0e30e3940d8425fd88c2c89";
  static final String avatar2 = "http://img03.store.sogou.com/app/a/10010016/5d6a1f07d8f5c16ce98a33f2148e64b6";
  static final String avatar3 = "http://img04.store.sogou.com/app/a/10010016/b7f5faea1e64b4bfb4f7d88aa5d1d186";
}

class ContactInfo extends ISuspensionBean {
  String id;
  String name;
  String school;
  String tagIndex;
  String namePinyin;
  String imageUrl;

  ContactInfo({
    this.name,
    this.id,
    this.school,
    this.tagIndex,
    this.namePinyin,
    this.imageUrl
  });

  ContactInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'tagIndex': tagIndex,
    'namePinyin': namePinyin,
    'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() {
    return 'ContactInfo{id: $id, name: $name, school: $school, tagIndex: $tagIndex, namePinyin: $namePinyin, imageUrl: $imageUrl}';
  }


}