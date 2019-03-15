import "package:flutter/material.dart";

class MoneyInstructionApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MoneyInstructionAppState();
}

class MoneyInstructionAppState extends State<MoneyInstructionApp> {

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey[800],
        ),
        centerTitle: true,
        title: Text(
          "凡尔币用途",
          style: TextStyle(color: Colors.grey[800]),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("1. 凡尔币可用于代课系统，10凡尔币可完成一整门课程。\n"
                "2. 凡尔币可用于校园圈文章悬赏，悬赏将增大文章曝光度，每天系统赚取的凡尔币将在校园圈根据文章热度分配的每日最热的前2%的人。\n"
                "3. 每日最佳评论可赚取凡尔币。"),
            Container(
                margin: EdgeInsets.only(top: 8, left: 0),
                child: Text("目前为1.0版本，后续版本凡尔币将对接更多服务。", style: TextStyle(fontWeight: FontWeight.bold),)),
          ],
        ),
      )
    );
  }

}