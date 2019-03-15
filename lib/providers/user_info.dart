import 'package:sqflite/sqflite.dart';
class UserInfo {
  int id;
  String objectId;
  double money;
  double voucher;
  String schoolName;
  String realName;
  bool ifAuth;
  String date;
  String constellation;
  String animals;
  String sex;
  int age;
  String birth;
  String headImg;
  String phone;
  String nickName;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "objectId": objectId == null?"":objectId,
      "money": money == null?0.0:money,
      "voucher": voucher == null?0.0:voucher,
      "schoolName": schoolName == null?"":schoolName,
      "realName": realName == null?"":realName,
      "ifAuth": ifAuth == null?false:ifAuth,
      "date": date == null?"":date,
      "constellation": constellation == null?"":constellation,
      "animals": animals == null?"":animals,
      "sex": sex == null?"":sex,
      "age": age == null?0:age,
      "birth": birth == null?"":birth,
      "headImg": headImg == null?"":headImg,
      "phone": phone == null?"":phone,
      "nickName": nickName == null?"":nickName,
    };
    if (id != null) {
      map["_id"] = id;
    }
    return map;
  }

  UserInfo.fromMap(Map map) {
    id = map["_id"];
    objectId = map["objectId"];
    money = map["money"];
    voucher = map["voucher"];
    schoolName = map["schoolName"];
    realName = map["realName"];
    ifAuth = map["ifAuth"];
    date = map["date"];
    constellation = map["constellation"];
    animals = map["animals"];
    sex = map["sex"];
    age = map["age"];
    birth = map["birth"];
    headImg = map["headImg"];
    phone = map["phone"];
    nickName = map["nickName"];
  }



}

class UserInfoProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table push_message ( 
  id integer primary key autoincrement, 
  objectId text not null,
  type text not null,
  title text not null,
  content text not null,
  createTime text not null,
  action text not null,
  isRead integer not null)
''');
    });
  }

  Future<UserInfo> insert(UserInfo message) async {
    message.id = await db.insert("user_info", message.toMap());
    return message;
  }

  Future<UserInfo> getMessage(int id) async {
    List<Map> maps = await db.query("user_info",
        columns: ["_id", "objectId", "type", "title", "content", "createTime", "isRead"],
        where: "_id = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new UserInfo.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete("user_info", where: "_id = ?", whereArgs: [id]);
  }

  Future<int> update(UserInfo info) async {
    return await db.update("user_info", info.toMap(),
        where: "_id = ?", whereArgs: [info.id]);
  }

  Future close() async => db.close();
}
