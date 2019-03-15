import 'dart:convert';
import 'dart:io';
import 'package:finerit_app_flutter/extra_apps/flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:finerit_app_flutter/extra_apps/flutter_datetime_picker/src/i18n_model.dart';
import 'package:finerit_app_flutter/icons/icons_route2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:finerit_app_flutter/apps/home/home_base.dart';
import 'package:finerit_app_flutter/beans/audit_info.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart' as ImagePickerResolver;
import 'package:http/http.dart' as http;
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:scoped_model/scoped_model.dart';

class PaymentDialogItem extends StatelessWidget {
  const PaymentDialogItem(
      {Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}

class ProfileVerifyBaseApp extends StatefulWidget {
  int authState;
  final AuditInfo auditInfo;

  ProfileVerifyBaseApp({Key key, @required this.auditInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ProfileVerifyBaseAppState(auditInfo: auditInfo);
}

class ProfileVerifyBaseAppState extends State<ProfileVerifyBaseApp> {
  final AuditInfo auditInfo;

  ProfileVerifyBaseAppState({@required this.auditInfo});

  final TextEditingController _realNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();

  FocusNode focusNode;
  DateTime _dateTime;
  int _genderRadioValue = 0;
  String gender = "0";
  MainStateModel model;
  int authState = 0;
  bool isLoading = true;

  bool isSubmitting = false;

  File _frontIdCardImage;
  File _backIdCardImage;
  File _insideStudentCardImage;
  File _outsideStudentCardImage;

  void showFrontIdImagePickerDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) async {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        File image = null;
        if (value == 0) {
          //相机
          image = await ImagePicker.pickImage(
              source: ImagePickerResolver.ImageSource.camera);
        } else if (value == 1) {
          //图库
          image = await ImagePicker.pickImage(
              source: ImagePickerResolver.ImageSource.gallery);
        }
        if(!this.mounted){
          return;
        }
        setState(() {
          _frontIdCardImage = image;
        });
      }
    });
  }

  void showBackIdImagePickerDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) async {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        File image = null;
        if (value == 0) {
          //相机
          image = await ImagePicker.pickImage(
              source: ImagePickerResolver.ImageSource.camera);
        } else if (value == 1) {
          //图库
          image = await ImagePicker.pickImage(
              source: ImagePickerResolver.ImageSource.gallery);
        }
        if(!this.mounted){
          return;
        }
        setState(() {
          _backIdCardImage = image;
        });
      }
    });
  }

  void showInsideStudentImagePickerDialog<T>(
      {BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) async {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        File image = null;
        if (value == 0) {
          //相机
          image = await ImagePicker.pickImage(
              source: ImagePickerResolver.ImageSource.camera);
        } else if (value == 1) {
          //图库
          image = await ImagePicker.pickImage(
              source: ImagePickerResolver.ImageSource.gallery);
        }
        if(!this.mounted){
          return;
        }
        setState(() {
          _insideStudentCardImage = image;
        });
      }
    });
  }

  void showOutsideStudentImagePickerDialog<T>(
      {BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) async {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        File image = null;
        if (value == 0) {
          //相机
          image = await ImagePicker.pickImage(
              source: ImagePickerResolver.ImageSource.camera);
        } else if (value == 1) {
          //图库
          image = await ImagePicker.pickImage(
              source: ImagePickerResolver.ImageSource.gallery);
        }
        if(!this.mounted){
          return;
        }
        setState(() {
          _outsideStudentCardImage = image;
        });
      }
    });
  }

  void _handleGenderRadioValueChange(int value) {
    setState(() {
      _genderRadioValue = value;
    });

    switch (_genderRadioValue) {
      case 0:
        gender = "0";
        break;
      case 1:
        gender = "1";
        break;
    }
    print("gender=$gender");
  }

  Widget _buildTopCard(int _authState) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10),
      color: Colors.white,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            _authState == 2 ? MyFlutterApp2.auth : MyFlutterApp2.notauth,
            color: _authState == 2 ? Colors.blue : Colors.red,
          ),
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                _handleTopCardMessage(_authState),
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  Widget _buildBothNameBar(MainStateModel model) {
    return Container(
      height: 90,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _realNameController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.grey,
              maxLines: 1,
              maxLength: 16,
              style: TextStyle(color: Colors.grey, fontSize: 18),
              obscureText: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                labelText: "真实姓名",
//                icon: Icon(Icons.star)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnVerifiedSchoolBar(MainStateModel model) {
    return Container(
      height: 90,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _schoolNameController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.grey,
              maxLines: 1,
              maxLength: 16,
              style: TextStyle(color: Colors.grey, fontSize: 18),
              obscureText: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                labelText: "学校名称",
//                icon: Icon(Icons.star)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnVerifiedGenderBar(MainStateModel model) {
    return Container(
      height: 40,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Radio(
                      value: 0,
                      groupValue: _genderRadioValue,
                      onChanged: _handleGenderRadioValueChange),
                  Text("男"),
                  Radio(
                      value: 1,
                      groupValue: _genderRadioValue,
                      onChanged: _handleGenderRadioValueChange),
                  Text("女")
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildUnVerifiedBirthdayBar(MainStateModel model) {
    return Container(
      height: 90,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: _handleDatePickerUpdate,
              child: Container(
                color: Colors.transparent,
                child: IgnorePointer(
                  child: TextField(
                    enabled: false,
                    focusNode: focusNode,
                    controller: _birthDateController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.grey,
                    maxLines: 1,
                    maxLength: 16,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                    obscureText: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      labelText: "出生日期",
//                icon: Icon(Icons.star)
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnVerifiedMidCard(MainStateModel model) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    _buildBothNameBar(model),
                    Divider(
                      height: 2,
                    ),
                    _buildUnVerifiedGenderBar(model),
                    Divider(
                      height: 2,
                    ),
                    _buildUnVerifiedSchoolBar(model),
                    Divider(
                      height: 2,
                    ),
                    _buildUnVerifiedBirthdayBar(model),
                    Divider(
                      height: 2,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                      //front_id_card
                                      onTap: isSubmitting
                                          ? null
                                          : () {
                                              showFrontIdImagePickerDialog<int>(
                                                  context: context,
                                                  child: SimpleDialog(
                                                      title: const Text(
                                                          '获取身份证人像面'),
                                                      children: <Widget>[
                                                        PaymentDialogItem(
                                                            icon: Icons.camera,
                                                            text: '拍照',
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context, 0);
                                                            }),
                                                        PaymentDialogItem(
                                                            icon: Icons
                                                                .picture_in_picture,
                                                            text: '从图库选择',
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context, 1);
                                                            }),
                                                      ]));
                                            },
                                      child: Container(
                                          margin: EdgeInsets.all(12),
                                          height: 75,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: _frontIdCardImage == null
                                                ? AssetImage(
                                                    "assets/idcardinside.png")
                                                : FileImage(_frontIdCardImage),
                                            fit: BoxFit.cover,
                                          ))),
                                    ),
                                    InkWell(
                                      //back_id_card
                                      onTap: isSubmitting
                                          ? null
                                          : () {
                                              showBackIdImagePickerDialog<int>(
                                                  context: context,
                                                  child: SimpleDialog(
                                                      title: const Text(
                                                          '获取身份证国徽面'),
                                                      children: <Widget>[
                                                        PaymentDialogItem(
                                                            icon: MyFlutterApp2.camera,
                                                            text: '拍照',
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context, 0);
                                                            }),
                                                        PaymentDialogItem(
                                                            icon: MyFlutterApp2
                                                                .image,
                                                            text: '从图库选择',
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context, 1);
                                                            }),
                                                      ]));
                                            },
                                      child: Container(
                                          margin: EdgeInsets.all(12),
                                          height: 75,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: _backIdCardImage == null
                                                ? AssetImage(
                                                    "assets/idcardourside.png")
                                                : FileImage(_backIdCardImage),
                                            fit: BoxFit.cover,
                                          ))),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 2,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                      //inside_student_card
                                      onTap: isSubmitting
                                          ? null
                                          : () {
                                              showInsideStudentImagePickerDialog<
                                                      int>(
                                                  context: context,
                                                  child: SimpleDialog(
                                                      title:
                                                          const Text('获取学生证内页'),
                                                      children: <Widget>[
                                                        PaymentDialogItem(
                                                            icon: Icons.camera,
                                                            text: '拍照',
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context, 0);
                                                            }),
                                                        PaymentDialogItem(
                                                            icon: Icons
                                                                .picture_in_picture,
                                                            text: '从图库选择',
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context, 1);
                                                            }),
                                                      ]));
                                            },
                                      child: Container(
                                          margin: EdgeInsets.all(12),
                                          height: 75,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: _insideStudentCardImage ==
                                                    null
                                                ? AssetImage(
                                                    "assets/studentinside.png")
                                                : FileImage(
                                                    _insideStudentCardImage),
                                            fit: BoxFit.cover,
                                          ))),
                                    ),
                                    InkWell(
                                      //outside_student_card
                                      onTap: isSubmitting
                                          ? null
                                          : () {
                                              showOutsideStudentImagePickerDialog<
                                                      int>(
                                                  context: context,
                                                  child: SimpleDialog(
                                                      title:
                                                          const Text('获取学生证外页'),
                                                      children: <Widget>[
                                                        PaymentDialogItem(
                                                            icon: Icons.camera,
                                                            text: '拍照',
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context, 0);
                                                            }),
                                                        PaymentDialogItem(
                                                            icon: Icons
                                                                .picture_in_picture,
                                                            text: '从图库选择',
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context, 1);
                                                            }),
                                                      ]));
                                            },
                                      child: Container(
                                          margin: EdgeInsets.all(12),
                                          height: 75,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: _outsideStudentCardImage ==
                                                    null
                                                ? AssetImage(
                                                    "assets/studentoutside.png")
                                                : FileImage(
                                                    _outsideStudentCardImage),
                                            fit: BoxFit.cover,
                                          ))),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            authState == 1
                                ? Container(
                                    width: 150,
                                    height: 40,
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: InkWell(
                                      onTap: () {
                                        isSubmitting
                                            ? null
                                            : _handleVerifySubmitUpdate(model);
                                      },
                                      child: Material(
                                        color: isSubmitting
                                            ? Colors.grey
                                            : FineritColor.login_button,
                                        //设置控件的背景色
                                        child: Padding(
                                          padding: EdgeInsets.all(6.0),
                                          //只是为了给 Text 加一个内边距，好看点~
                                          child: Center(
                                            child: Text(
                                              isSubmitting ? "提交中..." : "修改提交",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        //设置矩形的圆角弧度，具体根据 UI 标注为准
                                        shadowColor: Colors.grey,
                                        //可以设置 阴影的颜色
                                        elevation:
                                            5.0, //安卓中的井深(大概就是阴影颜色的深度吧╮(╯▽╰)╭)
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 150,
                                    height: 40,
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: InkWell(
                                      onTap: () {
                                        isSubmitting
                                            ? null
                                            : _handleVerifySubmit(model);
                                      },
                                      child: Material(
                                        color: isSubmitting
                                            ? Colors.grey
                                            : FineritColor.login_button,
                                        //设置控件的背景色
                                        child: Padding(
                                          padding: EdgeInsets.all(6.0),
                                          //只是为了给 Text 加一个内边距，好看点~
                                          child: Center(
                                            child: Text(
                                              isSubmitting ? "提交中..." : "提交",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        //设置矩形的圆角弧度，具体根据 UI 标注为准
                                        shadowColor: Colors.grey,
                                        //可以设置 阴影的颜色
                                        elevation:
                                            5.0, //安卓中的井深(大概就是阴影颜色的深度吧╮(╯▽╰)╭)
                                      ),
                                    ),
                                  ),
                            authState == 1
                                ? Container(
                                    margin: EdgeInsets.only(left: 8),
                                    width: 150,
                                    height: 40,
                                    child: InkWell(
                                      onTap: () {
                                        _handleVerifyCancel(model);
                                      },
                                      child: Material(
                                        color: Colors.red,
                                        //设置控件的背景色
                                        child: Padding(
                                          padding: EdgeInsets.all(6.0),
                                          //只是为了给 Text 加一个内边距，好看点~
                                          child: Center(
                                            child: Text(
                                              "放弃认证",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        //设置矩形的圆角弧度，具体根据 UI 标注为准
                                        shadowColor: Colors.grey,
                                        //可以设置 阴影的颜色
                                        elevation:
                                            5.0, //安卓中的井深(大概就是阴影颜色的深度吧╮(╯▽╰)╭)
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),

//                  _buildUnVerifiedBottomCard(model)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    focusNode = FocusNode();
    setState(() {
      if (auditInfo == null) {
        authState = 0;
      } else {
        authState = auditInfo.ifAuth;
        _realNameController.text = auditInfo.realName;
        _schoolNameController.text = auditInfo.schoolName;
        _birthDateController.text = auditInfo.birth;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    model = ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, widget, MainStateModel model) {
      return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            leading: BackButton(
              color: Colors.grey[800],
            ),
            title: Text(
              "实名认证",
              style: TextStyle(color: Colors.grey[800]),
            ),
            backgroundColor: Colors.white,
          ),
          body: _handleVerifyDisplay());
    });
  }

  Future _handleVerifySubmit(MainStateModel model) async {
    if (_realNameController.text == null ||
        _schoolNameController.text == null ||
        _birthDateController.text == null ||
        _frontIdCardImage == null ||
        _backIdCardImage == null ||
        _insideStudentCardImage == null ||
        _outsideStudentCardImage == null) {
      requestToast("信息填写不全。");
      return;
    }
    setState(() {
      isSubmitting = true;
    });
    print("verify submit");

    String sessionToken = model.session_token;
    String realName = _realNameController.text;
    String school = _schoolNameController.text;
    String date = _birthDateController.text;
    print("this.gender=${this.gender}");
    int gender = int.parse(this.gender);
    String frontIdCardImageUrl = "";
    String frontIdCardImageStatus = "";
    String backIdCardImageUrl = "";
    String backIdCardImageStatus = "";
    String insideStudentCardImageUrl = "";
    String insideStudentCardImageStatus = "";
    String outsideStudentCardImageUrl = "";
    String outsideStudentCardImageStatus = "";
    print("realName=$realName,school=$school,date=$date,gender=$gender");
    frontIdCardImageStatus = //身份证人像页上传
        await NetUtil.putFile(_frontIdCardImage, (value) async {
      Map uploadInfo = json.decode(value);
      frontIdCardImageUrl = uploadInfo["url"];
      print("frontIdCardImageUrl=$frontIdCardImageUrl");
      backIdCardImageStatus = //身份证国徽页上传
          await NetUtil.putFile(_backIdCardImage, (value) async {
        Map uploadInfo = json.decode(value);
        backIdCardImageUrl = uploadInfo["url"];
        print("backIdCardImageUrl=$backIdCardImageUrl");
        insideStudentCardImageStatus = //学生证内页上传
            await NetUtil.putFile(_insideStudentCardImage, (value) async {
          Map uploadInfo = json.decode(value);
          insideStudentCardImageUrl = uploadInfo["url"];
          print("insideStudentCardImageUrl=$insideStudentCardImageUrl");
          outsideStudentCardImageStatus = //学生证内页上传
              await NetUtil.putFile(_outsideStudentCardImage, (value) {
            Map uploadInfo = json.decode(value);
            outsideStudentCardImageUrl = uploadInfo["url"];
            print("outsideStudentCardImageUrl=$outsideStudentCardImageUrl");
            NetUtil.post(
              Api.AUDITS_VERIFY,
              (data) {
                requestToast("认证成功,等待审核");
                Navigator.popUntil(context, (Route<dynamic> route) {
                  bool shouldPop = false;
                  if (route.settings.name == HomeApp.routeName) {
                    shouldPop = true;
                  }
                  return shouldPop;
                });
              },
              params: {
                "real_name": realName,
                "school_name": school,
                "sex": gender,
                "birth": date,
                "front_of_id_card": frontIdCardImageUrl,
                "back_of_id_card": backIdCardImageUrl,
                "outside_stu_card": outsideStudentCardImageUrl,
                "inside_stu_card": insideStudentCardImageUrl,
              },
              headers: {"Authorization": "Token $sessionToken"},
            );
          });
        });
      });
    });

    if (frontIdCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        backIdCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        insideStudentCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        outsideStudentCardImageStatus == "FILE_TYPE_NOT_SUPPORTED") {
      requestToast("图片上传失败：文件类型不受支持");
    } else if (frontIdCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        backIdCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        insideStudentCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        outsideStudentCardImageStatus == "FILE_TYPE_NOT_SUPPORTED") {
      requestToast("图片上传失败：上传服务暂不可用");
    }
  }

  Future _handleVerifySubmitUpdate(MainStateModel model) async {
    if (_realNameController.text == null ||
        _schoolNameController.text == null ||
        _birthDateController.text == null) {
      requestToast("信息填写不全。");
      return;
    }
    if (_frontIdCardImage == null ||
        _backIdCardImage == null ||
        _insideStudentCardImage == null ||
        _outsideStudentCardImage == null) {
      requestToast("请重新上传新的认证照片。");
      return;
    }
    setState(() {
      isSubmitting = true;
    });
    print("verify submit");

    String sessionToken = model.session_token;
    String realName = _realNameController.text;
    String school = _schoolNameController.text;
    String date = _birthDateController.text;
    print("this.gender=${this.gender}");
    int gender = int.parse(this.gender);
    String frontIdCardImageUrl = "";
    String frontIdCardImageStatus = "";
    String backIdCardImageUrl = "";
    String backIdCardImageStatus = "";
    String insideStudentCardImageUrl = "";
    String insideStudentCardImageStatus = "";
    String outsideStudentCardImageUrl = "";
    String outsideStudentCardImageStatus = "";
    print("realName=$realName,school=$school,date=$date,gender=$gender");
    frontIdCardImageStatus = //身份证人像页上传
        await NetUtil.putFile(_frontIdCardImage, (value) async {
      Map uploadInfo = json.decode(value);
      frontIdCardImageUrl = uploadInfo["url"];
      print("frontIdCardImageUrl=$frontIdCardImageUrl");
      backIdCardImageStatus = //身份证国徽页上传
          await NetUtil.putFile(_backIdCardImage, (value) async {
        Map uploadInfo = json.decode(value);
        backIdCardImageUrl = uploadInfo["url"];
        print("backIdCardImageUrl=$backIdCardImageUrl");
        insideStudentCardImageStatus = //学生证内页上传
            await NetUtil.putFile(_insideStudentCardImage, (value) async {
          Map uploadInfo = json.decode(value);
          insideStudentCardImageUrl = uploadInfo["url"];
          print("insideStudentCardImageUrl=$insideStudentCardImageUrl");
          outsideStudentCardImageStatus = //学生证内页上传
              await NetUtil.putFile(_outsideStudentCardImage, (value) {
            Map uploadInfo = json.decode(value);
            outsideStudentCardImageUrl = uploadInfo["url"];
            print("outsideStudentCardImageUrl=$outsideStudentCardImageUrl");
            NetUtil.put(
              Api.AUDITS_VERIFY + model.userInfo.id + "/",
              (data) {
                requestToast("重新认证成功,等待审核");
                Navigator.popUntil(context, (Route<dynamic> route) {
                  bool shouldPop = false;
                  if (route.settings.name == HomeApp.routeName) {
                    shouldPop = true;
                  }
                  return shouldPop;
                });
              },
              params: {
                "real_name": realName,
                "school_name": school,
                "sex": gender,
                "birth": date,
                "front_of_id_card": frontIdCardImageUrl,
                "back_of_id_card": backIdCardImageUrl,
                "outside_stu_card": outsideStudentCardImageUrl,
                "inside_stu_card": insideStudentCardImageUrl,
              },
              headers: {"Authorization": "Token $sessionToken"},
            );
          });
        });
      });
    });

    if (frontIdCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        backIdCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        insideStudentCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        outsideStudentCardImageStatus == "FILE_TYPE_NOT_SUPPORTED") {
      requestToast("图片上传失败：文件类型不受支持");
    } else if (frontIdCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        backIdCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        insideStudentCardImageStatus == "FILE_TYPE_NOT_SUPPORTED" ||
        outsideStudentCardImageStatus == "FILE_TYPE_NOT_SUPPORTED") {
      requestToast("图片上传失败：上传服务暂不可用");
    }
  }

  void _handleDatePickerUpdate() {
    print("focus");
    _selectDatePicker(context);
    FocusScope.of(context).requestFocus(focusNode);
  }

  void _handlePictureDownload() async {
    if (auditInfo != null && _frontIdCardImage == null) {
      var frontIdCardResponse = await http.get(auditInfo.frontOfIdCard);
      var frontIdCardFilePath = await ImagePickerSaver.saveFile(
          fileData: frontIdCardResponse.bodyBytes);
      var frontIdCardSavedFile = File.fromUri(Uri.file(frontIdCardFilePath));
      setState(() {
        Future<File>.sync(() => frontIdCardSavedFile).then((value) {
          _frontIdCardImage = value;
        });
      });
    }

    if (auditInfo != null && _backIdCardImage == null) {
      var backIdCardResponse = await http.get(auditInfo.backOfIdCard);
      var backIdCardFilePath = await ImagePickerSaver.saveFile(
          fileData: backIdCardResponse.bodyBytes);
      var backIdCardSavedFile = File.fromUri(Uri.file(backIdCardFilePath));
      setState(() {
        Future<File>.sync(() => backIdCardSavedFile).then((value) {
          _backIdCardImage = value;
        });
      });
    }

    if (auditInfo != null && _insideStudentCardImage == null) {
      var insideStuResponse = await http.get(auditInfo.insideStuCard);
      var insideStuFilePath = await ImagePickerSaver.saveFile(
          fileData: insideStuResponse.bodyBytes);
      var insideStuSavedFile = File.fromUri(Uri.file(insideStuFilePath));
      setState(() {
        Future<File>.sync(() => insideStuSavedFile).then((value) {
          _insideStudentCardImage = value;
        });
      });
    }

    if (auditInfo != null && _outsideStudentCardImage == null) {
      var outsideStuResponse = await http.get(auditInfo.outsideStuCard);
      var outsideStuFilePath = await ImagePickerSaver.saveFile(
          fileData: outsideStuResponse.bodyBytes);
      var outsideStuSavedFile = File.fromUri(Uri.file(outsideStuFilePath));
      setState(() {
        Future<File>.sync(() => outsideStuSavedFile).then((value) {
          _outsideStudentCardImage = value;
        });
      });
    }
  }

  _selectDatePicker(BuildContext context){
    DatePicker.showDatePicker(
      context,
      isShowRightList: true,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime.now(),
      onChanged: (date) {

      },
      onConfirm: (date) {
        setState(() {
          _birthDateController.text =
          "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}";
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.zh,
    );
  }

  _handleVerifyDisplay() {
    switch (authState) {
      case 0: //待认证
        return Column(
          children: <Widget>[
            _buildTopCard(authState),
            _buildUnVerifiedMidCard(model),
          ],
        );
        break;
      case 1: //审核中
        return Column(
          children: <Widget>[
            _buildTopCard(authState),
            _buildUnVerifiedMidCard(model),
          ],
        );
        break;
      case 2: //已认证
        return Column(
          children: <Widget>[
            _buildTopCard(authState),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(0.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            Container(
                              height: 50,
                              color: Colors.white,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "真实姓名",
                                          ))),
                                  Align(
                                    alignment: FractionalOffset.centerRight,
                                    child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          auditInfo.realName,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 2,
                            ),
                            Container(
                              height: 50,
                              color: Colors.white,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "性别",
                                          ))),
                                  Align(
                                    alignment: FractionalOffset.centerRight,
                                    child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          auditInfo.sex == 0 ? "男" : "女",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 2,
                            ),
                            Container(
                              height: 50,
                              color: Colors.white,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "年龄",
                                          ))),
                                  Align(
                                    alignment: FractionalOffset.centerRight,
                                    child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          auditInfo.age.toString(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 2,
                            ),
                            Container(
                              height: 50,
                              color: Colors.white,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "出生日期",
                                          ))),
                                  Align(
                                    alignment: FractionalOffset.centerRight,
                                    child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          auditInfo.birth,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 2,
                            ),
                            Container(
                              height: 50,
                              color: Colors.white,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "所在院校",
                                          ))),
                                  Align(
                                    alignment: FractionalOffset.centerRight,
                                    child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          auditInfo.schoolName,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 2,
                            ),
                            Container(
                              height: 50,
                              color: Colors.white,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "认证日期",
                                          ))),
                                  Align(
                                    alignment: FractionalOffset.centerRight,
                                    child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          auditInfo.date.substring(0, 10),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
    }
  }

  String _handleTopCardMessage(int authState) {
    switch (authState) {
      case 0:
        return "尚未完成认证，请完成认证操作。";
      case 1:
        _handlePictureDownload();
        if (auditInfo != null) {
          if (isLoading) {
            _genderRadioValue = auditInfo.sex;
            isLoading = false;
          }
        }
        return "认证审核中，您可以修改认证信息或放弃认证。";
      case 2:
        return "你已完成大学生认证";
    }
  }

  void _handleVerifyCancel(MainStateModel model) {
    NetUtil.delete(
      Api.AUDITS_VERIFY + model.userInfo.id + "/",
      (data) {
        requestToast("认证信息已取消。");
        Navigator.popUntil(context, (Route<dynamic> route) {
          bool shouldPop = false;
          if (route.settings.name == HomeApp.routeName) {
            shouldPop = true;
          }
          return shouldPop;
        });
      },
      headers: {"Authorization": "Token ${model.session_token}"},
    );
  }
}
