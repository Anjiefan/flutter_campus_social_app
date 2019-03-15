
import 'package:finerit_app_flutter/commons/load_locale_imgs.dart';
import 'package:finerit_app_flutter/commons/picturePage.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class ImageGridView extends StatelessWidget{
  var width ;
  List imageList;
  ImageGridView({
    key
    ,@required this.imageList
    ,this.width=360
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    if (imageList == null || imageList.length <= 0) return Container();
    if (imageList.length == 1) {
      var url = imageList[0];
      var w = 200;
      var h = 200;
      try {
        var wStr = Uri.parse(url).queryParameters['w'];
        var hStr = Uri.parse(url).queryParameters['h'];
        w = int.parse(wStr);
        h = int.parse(hStr);
      } catch (e) {}

      var imgW = 200.0;
      var imgH = 200.0;
      if (w >= h) {
        imgW = 200.0;
        imgH = h / w * imgW;
      } else {
        imgH = 200.0;
        imgW = w * imgH / h;
      }
      if (imgH == 200.0 && imgW <= 140.0) {
        imgW = 140.0;
      }
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 8.0, bottom: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(3.0),
          child: ImageShow(imageList: imageList,index: 0,),
        ),
        width: imgW,
        height: imgH,
      );
    }
    if (imageList.length == 2) {
      double size = (width - 32 - 4) / 2.0;
      return Row(
        children: <Widget>[
          ImageWidget(size: size,marginLeft: false,marginTop: false,
              child:ImageShow(imageList: imageList,index: 0)),
          ImageWidget(size: size,marginLeft: true,marginTop: false,
              child:ImageShow(imageList: imageList,index: 1)),
        ],
      );
    } else if (imageList.length == 3) {
      double size = (width - 32 - 8) / 3.0;
      return Row(
        children: <Widget>[
          ImageWidget(size: size,marginLeft: false,marginTop: false,
              child:ImageShow(imageList: imageList,index: 0)),
          ImageWidget(size: size,marginLeft: true,marginTop: false,
              child:ImageShow(imageList: imageList,index: 1)),
          ImageWidget(size: size,marginLeft: true,marginTop: false,
              child:ImageShow(imageList: imageList,index: 2)),
        ],
      );
    } else if (imageList.length == 4) {
      double size = (width - 32 - 4) / 2.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 0)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 1)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 2)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 3)),
            ],
          )
        ],
      );
    } else if (imageList.length == 5) {
      double size = (width - 32 - 4) / 2.0;
      double size1 = (width - 32 - 8) / 3.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 0)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 1)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size1,marginLeft: false,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 2)),
              ImageWidget(size: size1,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 3)),
              ImageWidget(size: size1,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 4)),
            ],
          )
        ],
      );
    } else if (imageList.length == 6) {
      double size = (width - 32 - 8) / 3.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 0)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 1)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 2)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 3)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 4)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 5)),
            ],
          )
        ],
      );
    } else if (imageList.length == 7) {
      double size = (width - 32 - 8) / 3.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: width - 32.0,marginLeft: false,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 0)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 1)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 2)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 3)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 4)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 5,)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 6,)),
            ],
          )
        ],
      );
    } else if (imageList.length == 8) {
      double size = (width - 32 - 8) / 3.0;
      double size1 = (width - 32 - 4) / 2.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 0,)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 1,)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 2,)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 3,)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 4,)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 5)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 6)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 7)),
            ],
          )
        ],
      );
    } else if (imageList.length == 9) {
      double size = (width - 32 - 8) / 3.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 0)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 1)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:ImageShow(imageList: imageList,index: 2)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 3)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:ImageShow(imageList: imageList,index: 4)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                child:ImageShow(imageList: imageList,index: 5),),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                child:ImageShow(imageList: imageList,index: 6),),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                child:ImageShow(imageList: imageList,index: 7),),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                child:ImageShow(imageList: imageList,index: 8),),
            ],
          )
        ],
      );
    }
    var imageRow = List<Widget>();
    for (var index=0;index<imageList.length;index++) {
      imageRow.add(Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
          height: 80.0,
          child: AssetView(index, imageList[index]),
        ),
      ));
    }
    return Row(
      children: imageRow,
    );
  }
}

class AssertGridView extends StatelessWidget{
  var width ;
  List imageList;
  AssertGridView({
    key
    ,@required this.imageList
    ,this.width=360
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    print(imageList);
    if (imageList == null || imageList.length <= 0) return Container();
    if (imageList.length == 1) {
      var url = imageList[0];
      var w = 200;
      var h = 200;
      try {
        var wStr = Uri.parse(url).queryParameters['w'];
        var hStr = Uri.parse(url).queryParameters['h'];
        w = int.parse(wStr);
        h = int.parse(hStr);
      } catch (e) {}

      var imgW = 200.0;
      var imgH = 200.0;
      if (w >= h) {
        imgW = 200.0;
        imgH = h / w * imgW;
      } else {
        imgH = 200.0;
        imgW = w * imgH / h;
      }
      if (imgH == 200.0 && imgW <= 140.0) {
        imgW = 140.0;
      }
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 8.0, bottom: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(3.0),
          child: AssertShow(imageList: imageList,index: 0,),
        ),
        width: imgW,
        height: imgH,
      );
    }
    if (imageList.length == 2) {
      double size = (width - 32 - 4) / 2.0;
      return Container(
        child: Row(
          children: <Widget>[
            ImageWidget(size: size,marginLeft: false,marginTop: false,
                child:AssertShow(imageList: imageList,index: 0)),
            ImageWidget(size: size,marginLeft: true,marginTop: false,
                child:AssertShow(imageList: imageList,index: 1)),
          ],
        ),
      );
    } else if (imageList.length == 3) {
      double size = (width - 32 - 8) / 3.0;
      return Row(
        children: <Widget>[
          ImageWidget(size: size,marginLeft: false,marginTop: false,
              child:AssertShow(imageList: imageList,index: 0)),
          ImageWidget(size: size,marginLeft: true,marginTop: false,
              child:AssertShow(imageList: imageList,index: 1)),
          ImageWidget(size: size,marginLeft: true,marginTop: false,
              child:AssertShow(imageList: imageList,index: 2)),
        ],
      );
    } else if (imageList.length == 4) {
      double size = (width - 32 - 4) / 2.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 0)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 1)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 2)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 3)),
            ],
          )
        ],
      );
    } else if (imageList.length == 5) {
      double size = (width - 32 - 4) / 2.0;
      double size1 = (width - 32 - 8) / 3.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 0)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 1)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size1,marginLeft: false,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 2)),
              ImageWidget(size: size1,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 3)),
              ImageWidget(size: size1,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 4)),
            ],
          )
        ],
      );
    } else if (imageList.length == 6) {
      double size = (width - 32 - 8) / 3.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 0)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 1)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 2)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 3)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 4)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 5)),
            ],
          )
        ],
      );
    } else if (imageList.length == 7) {
      double size = (width - 32 - 8) / 3.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: width - 32.0,marginLeft: false,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 0)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 1)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 2)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 3)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 4)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 5,)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 6,)),
            ],
          )
        ],
      );
    } else if (imageList.length == 8) {
      double size = (width - 32 - 8) / 3.0;
      double size1 = (width - 32 - 4) / 2.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 0,)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 1,)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 2,)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 3,)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 4,)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 5)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 6)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 7)),
            ],
          )
        ],
      );
    } else if (imageList.length == 9) {
      double size = (width - 32 - 8) / 3.0;
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 0)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 1)),
              ImageWidget(size: size,marginLeft: true,marginTop: false,
                  child:AssertShow(imageList: imageList,index: 2)),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 3)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                  child:AssertShow(imageList: imageList,index: 4)),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                child:AssertShow(imageList: imageList,index: 5),),
            ],
          ),
          Row(
            children: <Widget>[
              ImageWidget(size: size,marginLeft: false,marginTop: true,
                child:AssertShow(imageList: imageList,index: 6),),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                child:AssertShow(imageList: imageList,index: 7),),
              ImageWidget(size: size,marginLeft: true,marginTop: true,
                child:AssertShow(imageList: imageList,index: 8),),
            ],
          )
        ],
      );
    }
    var imageRow = List<Widget>();
    for (var index=0;index<imageList.length;index++) {
      imageRow.add(Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
          height: 80.0,
          child: AssetView(index, imageList[index]),
        ),
      ));
    }
    return Row(
      children: imageRow,
    );
  }
}


class ImageWidget extends StatelessWidget{
  double size;
  Widget child;
  bool marginTop;
  bool marginLeft;
  ImageWidget({
    key
    ,@required this.size
    ,@required this.child
    ,@required this.marginTop
    ,@required this.marginLeft
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      margin: EdgeInsets.only(top: marginTop ? 4.0 : 0.0, left: marginLeft ? 4.0 : 0.0),
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(3.0),
        child: child,
      ),
    );
  }
}

class ImageShow extends StatelessWidget{
  List imageList;
  int index;
  bool ifOnTap;
  ImageShow({
    key
    ,@required this.imageList
    ,@required this.index
    ,this.ifOnTap=true
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    // TODO: implement build
    return InkWell(
      child: Container(
          child:
          new Image.network(
            imageList[index],
            fit: BoxFit.cover,
          )
      ),
      onTap: () {
        if(ifOnTap){
          Navigator.of(context).push(
            NinePicture(imageList, index),
          );
        }
      },
    );
  }
}

class AssertShow extends StatelessWidget{
  List imageList;
  int index;
  bool ifOnTap=false;
  AssertShow({
    key
    ,@required this.imageList
    ,@required this.index
    ,this.ifOnTap
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
          child:  AssetView(index, imageList[index])
      ),
      onTap: () {
        if(ifOnTap){
          Navigator.of(context).push(
            NinePicture(imageList, index),
          );
        }
      },
    );
  }
}