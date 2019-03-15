import 'package:sqflite/sqflite.dart';
class PushMessage {
  int id;
  String objectId;
  String type;
  String title;
  String content;
  String action;
  String createTime;
  bool isRead;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "objectId": objectId,
      "type": type,
      "title": title,
      "content": content,
      "action": action,
      "createTime": createTime,
      "isRead": isRead == true ? 1 : 0
    };
    if (id != null) {
      map["_id"] = id;
    }
    return map;
  }

  PushMessage(this.objectId, this.type, this.title, this.content, this.action, this.createTime, this.isRead);

  PushMessage.fromMap(Map map) {
    id = map["_id"];
    type = map["type"];
    title = map["title"];
    content = map["content"];
    action = map["action"];
    createTime = map["createTime"];
    isRead = map["isRead"] == 1;
  }

  @override
  String toString() {
    return 'PushMessage{id: $id, objectId: $objectId, type: $type, title: $title, content: $content, action: $action, createTime: $createTime, isRead: $isRead}';
  }


}

class PushMessageProvider {
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

  Future<PushMessage> insert(PushMessage message) async {
    message.id = await db.insert("push_message", message.toMap());
    return message;
  }

  Future<PushMessage> getMessage(int id) async {
    List<Map> maps = await db.query("push_message",
        columns: ["_id", "objectId", "type", "title", "content", "createTime", "isRead"],
        where: "_id = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new PushMessage.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete("push_message", where: "_id = ?", whereArgs: [id]);
  }

  Future<int> update(PushMessage message) async {
    return await db.update("push_message", message.toMap(),
        where: "_id = ?", whereArgs: [message.id]);
  }

  Future close() async => db.close();
}
