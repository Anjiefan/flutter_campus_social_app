import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PictureShow extends StatelessWidget {
  final List<String> picList;

  PictureShow({this.picList});

  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: picList.length >= 3 ? 3 : picList.length < 2 ? 1 : 2,
        children: List.generate(
          picList.length,
              (index) => GestureDetector(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: CachedNetworkImage(
                  key: Key(index.toString()),
                  imageUrl: picList[index],
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                NinePicture(picList, index),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NinePicture<T> extends PopupRoute<T> {
  final String barrierLabel;
  final List picList;
  final int index;
  int startX;
  int endX;

  NinePicture(this.picList, this.index, {this.barrierLabel});

  @override
  Duration get transitionDuration => Duration(milliseconds: 2000);

  @override
  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: GestureDetector(
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) => GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: _PictureWidget(picList, index),
          ),
        ),
      ),
    );
  }
}

class _PictureWidget extends StatefulWidget {
  final List picList;
  final int index;

  _PictureWidget(this.picList, this.index);

  @override
  State createState() {
    return _PictureWidgetState();
  }
}

class _PictureWidgetState extends State<_PictureWidget> {
  int startX = 0;
  int endX = 0;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.transparent,
      child: new Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: widget.picList[index],
                  fit: BoxFit.cover,
                ),
              ),
              onHorizontalDragDown: (detail) {
                startX = detail.globalPosition.dx.toInt();
              },
              onHorizontalDragUpdate: (detail) {
                endX = detail.globalPosition.dx.toInt();
              },
              onHorizontalDragEnd: (detail) {
                _getIndex(endX - startX);
                setState(() {});
              },
              onHorizontalDragCancel: () {},
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  widget.picList.length,
                      (i) => GestureDetector(
                    child: CircleAvatar(
                      foregroundColor: Theme.of(context).primaryColor,
                      radius: 8.0,
                      backgroundColor: index == i
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        startX = endX = 0;
                        index = i;
                      });
                    },
                  ),
                ).toList(),
              ),
            )
          ],
        ),
        alignment: Alignment.center,
      ),
    );
  }

  void _getIndex(int delta) {
    if (delta > 50) {
      setState(() {
        index--;
        index = index.clamp(0, widget.picList.length - 1);
      });
    } else if (delta < 50) {
      setState(() {
        index++;
        index = index.clamp(0, widget.picList.length - 1);
      });
    }
  }
}