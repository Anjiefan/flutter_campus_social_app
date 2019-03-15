import 'package:finerit_app_flutter/apps/components/asset.dart';
import 'package:finerit_app_flutter/apps/money/model/money_model.dart';
import 'package:finerit_app_flutter/apps/money/money_detail.dart';
import 'package:finerit_app_flutter/apps/money/money_instructions.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class MoneyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MoneyAppState();
}

class MoneyAppState extends State<MoneyApp> {
  static const CHANNEL_PAYMENT_INVOKE =
      const MethodChannel("com.finerit.campus/payment/invoke");
  static const CHANNEL_PAYMENT_CONFIRM =
      const EventChannel("com.finerit.campus/payment/confirm");
  var paymentResult = "";
  var sessionToken = "";
  var money = "";
  UserAuthModel userAuthModel;
  UserInfoModel userInfoModel;
  var _textController = new TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    CHANNEL_PAYMENT_CONFIRM.receiveBroadcastStream().listen(_onPaymentEvent);
  }

  void _onPaymentEvent(Object event) {
    if(!this.mounted){
      return;
    }
    setState(() {
      paymentResult = event;
      print("bill_no=$paymentResult");
      if (paymentResult != "-1") {
        //充值凡尔币
        NetUtil.post(Api.POPUP_URL, (data) {
          if(!this.mounted){
            return;
          }
          setState(() {
            money = data["money"].toString();
          });
        },
            headers: {"Authorization": "Token ${userAuthModel.session_token}"},
            params: {"bill_no": paymentResult});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_textController != null) {
      _textController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading == false) {
      userAuthModel =
          ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
      userInfoModel =
          ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
      getSessionToken();
      _textController.text = userInfoModel.userInfo.phone;
    }
    var _money='';
    try{
      _money=double.parse(money).toStringAsFixed(2);
    }
    catch(e){
      print(e);
    }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey[800],
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("账单明细"),
            onPressed: _handleAccountDetail,
          )
        ],
        title: Text(
          "我的钱包",
          style: TextStyle(color: Colors.grey[800]),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: FractionalOffset.topCenter,
            margin: EdgeInsets.only(top: 30),
            child: Icon(
              MyFlutterApp.money,
              size: 72,
              color: Colors.amber,
            ),
          ),
          Container(
            alignment: FractionalOffset.topCenter,
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "我的凡尔币",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            alignment: FractionalOffset.topCenter,
            margin: EdgeInsets.only(top: 5),
            child: Text(
              "\$${_money}",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              alignment: FractionalOffset.topCenter,
              margin: EdgeInsets.only(top: 40),
              child: MaterialButton(
                height: 30.0,
                minWidth: 150.0,
                color: FineritColor.color1_pressed,
                textColor: Colors.white,
                child: new Text("充值"),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MoneyInstructionApp(),
                                            ),
                                          );
                                        },
                                        child: Text("用途"),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Align(
                                      alignment: FractionalOffset.center,
                                      child: Text("凡尔币充值"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Align(
                                      alignment: FractionalOffset.centerRight,
                                      child: FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("取消")),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "充值金额仅限凡尔APP使用",
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: (){
                                        CHANNEL_PAYMENT_INVOKE.invokeMethod("doAlipay", [500]);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(MyFlutterApp.money, color: Colors.amber,),
                                                Text("  25", style: TextStyle(fontSize: 16),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text("  5.0元", style: TextStyle(color: Colors.grey[500]),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            )
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width: MediaQuery.of(context).size.width *
                                            0.25,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        CHANNEL_PAYMENT_INVOKE.invokeMethod("doAlipay", [1000]);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(MyFlutterApp.money, color: Colors.amber,),
                                                Text("  50", style: TextStyle(fontSize: 16),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text("  10.0元", style: TextStyle(color: Colors.grey[500]),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            )
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        ),
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.15,
                                        width: MediaQuery.of(context).size.width *
                                            0.25,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        CHANNEL_PAYMENT_INVOKE.invokeMethod("doAlipay", [2000]);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(MyFlutterApp.money, color: Colors.amber,),
                                                Text("  100", style: TextStyle(fontSize: 16),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text("  20.0元", style: TextStyle(color: Colors.grey[500]),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            )
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        ),
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.15,
                                        width: MediaQuery.of(context).size.width *
                                            0.25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                MediaQuery.of(context).size.height * 0.15,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: (){
                                        CHANNEL_PAYMENT_INVOKE.invokeMethod("doAlipay", [4000]);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(MyFlutterApp.money, color: Colors.amber,),
                                                Text("  200", style: TextStyle(fontSize: 16),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text("  40.0元", style: TextStyle(color: Colors.grey[500]),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            )
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        ),
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.15,
                                        width: MediaQuery.of(context).size.width *
                                            0.25,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        CHANNEL_PAYMENT_INVOKE.invokeMethod("doAlipay", [10000]);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(MyFlutterApp.money, color: Colors.amber,),
                                                Text("  500", style: TextStyle(fontSize: 16),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text("  100.0元", style: TextStyle(color: Colors.grey[500]),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            )
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        ),
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.15,
                                        width: MediaQuery.of(context).size.width *
                                            0.25,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        CHANNEL_PAYMENT_INVOKE.invokeMethod("doAlipay", [20000]);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(MyFlutterApp.money, color: Colors.amber,),
                                                Text("  1000", style: TextStyle(fontSize: 16),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text("  200.0元", style: TextStyle(color: Colors.grey[500]),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            )
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        ),
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.15,
                                        width: MediaQuery.of(context).size.width *
                                            0.25,
                                      ),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.only(top: 5),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
//                  showPaymentDialog<int>(
//                      context: context,
//                      child: SimpleDialog(
//                          title: const Text('选择充值金额'),
//                          children: <Widget>[
//                            PaymentDialogItem(
//                                icon: MyFlutterApp.money,
//                                text: '25个凡尔币',
//                                onPressed: () {
//                                  Navigator.pop(context, 500);
//                                }),
//                            PaymentDialogItem(
//                                icon: MyFlutterApp.money,
//                                text: '50个凡尔币',
//                                onPressed: () {
//                                  Navigator.pop(context, 1000);
//                                }),
//                            PaymentDialogItem(
//                                icon: MyFlutterApp.money,
//                                text: '100个凡尔币',
//                                onPressed: () {
//                                  Navigator.pop(context, 2000);
//                                }),
//                            PaymentDialogItem(
//                                icon: MyFlutterApp.money,
//                                text: '500个凡尔币',
//                                onPressed: () {
//                                  Navigator.pop(context, 10000);
//                                }),
//                            PaymentDialogItem(
//                                icon: MyFlutterApp.money,
//                                text: '1000个凡尔币',
//                                onPressed: () {
//                                  Navigator.pop(context, 20000);
//                                }),
//                          ]));
                },
              )),
          Container(
              alignment: FractionalOffset.topCenter,
              margin: EdgeInsets.only(top: 5),
              child: MaterialButton(
                height: 30.0,
                minWidth: 150.0,
                color: Colors.grey[200],
                child: new Text("提现"),
                onPressed: _handle_alypay,
              )),
        ],
      ),
    );
  }

  void _handle_alypay() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, a, b) => AlertDialog(
        title: Text('输入提现的支付宝账户'),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: (MediaQuery.of(context).size.height / 2) * 0.3,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              new Theme(
                data: ThemeData(
                  hintColor: Colors.black26,
                ),
                child:
                new Container(
//                  decoration: new BoxDecoration(
//                    border: new Border.all(width: 2.0, color: Colors.black54),
//                    color: Colors.white,
//                    borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
//                  ),
                  height: 30,
                  width: MediaQuery.of(context).size.width*1,
                  child:TextField(
                    controller: _textController,
                    autofocus: true,
                    cursorColor:Colors.black26,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: "输入支付宝账号...",
                      errorBorder:UnderlineInputBorder(
                        borderSide:
                        BorderSide( width: 0.5,color: Colors.black26),

                      ),
                      disabledBorder:UnderlineInputBorder(
                        borderSide:
                        BorderSide( width: 0.5,color: Colors.black26),

                      ),
                      enabledBorder:UnderlineInputBorder(
                        borderSide:
                        BorderSide( width: 0.5,color: Colors.black26),

                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderSide:
                        BorderSide( width: 0.8,color: Colors.black26),

                      ),
                      border:UnderlineInputBorder(
                        borderSide:
                        BorderSide(width: 0.5,color: Colors.black26),

                      ),
                    ),
                    style:TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('确认'),
            onPressed: () async {

              if (_textController.text == '') {
                requestToast('请输入提现的支付宝账户');
                return;
              }
              _handleWithDraw(_textController.text);
              Navigator.pop(context);

            },
          ),
        ],
      ),
      barrierDismissible: false,
      barrierLabel: '提现',
      transitionDuration: Duration(milliseconds: 400),
    );
//    showDialog(
//        context: context,
//        builder: (context) {
//          return StatefulBuilder(builder: (context, state) {
//            return new FinerAssetGiffyDialog(
//              title: Text(
//                '输入提现的支付宝账户',
//                textAlign: TextAlign.center,
//                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
//              ),
//              description: Container(
//                child: Column(
//                  children: <Widget>[
//                    TextField(
//                      controller: _textController,
//                      maxLines: 1,
//                      autofocus: true,
//                      cursorColor: FineritColor.color2_normal,
//                      decoration: InputDecoration(
//                        contentPadding: EdgeInsets.all(10.0),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              buttonOkText: Text('确定'),
//              buttonCancelText: Text('取消'),
//              onOkButtonPressed: () async {
//                if (_textController.text == '') {
//                  requestToast('请输入提现的支付宝账户');
//                  return;
//                }
//                _handleWithDraw(_textController.text);
//                Navigator.pop(context);
//              },
//            );
//          });
//        });
  }

  void _handleWithDraw(username) {
    NetUtil.post(
      Api.WITHDRAW_URL,
      (data) {
        if(!this.mounted){
          return;
        }
        setState(() {
          money = data["money"].toString();
        });
        requestToast(data['info']);
      },
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
      params: {"alipay_user_account": username},
    );
  }


  void showPaymentDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) async {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        CHANNEL_PAYMENT_INVOKE.invokeMethod("doAlipay", [value]);

      }
    });
  }


  Future getSessionToken() async {
    NetUtil.post(
      Api.DISPLAY_MONEY_URL,
      (data) {
        if(!this.mounted){
          return;
        }
        setState(() {
          money = data["money"].toString();
          loading = true;
        });
      },
      headers: {"Authorization": "Token ${userAuthModel.session_token}"},
    );
  }

  void _handleAccountDetail() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScopedModel<BaseMoneyPaymentInfoModel>(
                  child: MoneyDetailApp(),
                  model: MoneyPaymentInfoModel(),
                )));
  }
}
