// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';


enum TileStyle {
  imageOnly,
  oneLine,
  twoLine
}

typedef BannerTapCallback = void Function(Photo photo);

const double _kMinFlingVelocity = 800.0;

class Photo {
  Photo({
    this.photoId,
    this.title,
    this.caption,
    this.isFavorite = false,
    this.url
  });

  final String photoId;
  final String title;
  final String caption;
  final String url;

  bool isFavorite;
  String get tag => photoId; // Assuming that all asset names are unique.

  bool get isValid => photoId != null && title != null && caption != null && isFavorite != null && url != null;
}

class ProfileGalleryPhotoViewer extends StatefulWidget {
  const ProfileGalleryPhotoViewer({ Key key, this.photo }) : super(key: key);

  final Photo photo;

  @override
  _ProfileGalleryPhotoViewerState createState() => _ProfileGalleryPhotoViewerState();
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
}

class _ProfileGalleryPhotoViewerState extends State<ProfileGalleryPhotoViewer> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation);
  }

  @override
  void dispose() {
    if(_controller!=null){
      _controller.dispose();
    }
    super.dispose();
  }

  // The maximum offset value is 0,0. If the size of this renderer's box is w,h
  // then the minimum offset value is w - _scale * w, h - _scale * h.
  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    return Offset(offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {
    if(!this.mounted){
      return;
    }

    setState(() {
      _offset = _flingAnimation.value;
    });
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    if(!this.mounted){
      return;
    }
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      // The fling animation stops if an input gesture starts.
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    if(!this.mounted){
      return;
    }
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 4.0);
      // Ensure that image location under the focal point stays in the same place despite scaling.
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity)
      return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    final double distance = (Offset.zero & context.size).shortestSide;
    _flingAnimation = _controller.drive(Tween<Offset>(
      begin: _offset,
      end: _clampOffset(_offset + direction * distance)
    ));
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      child: ClipRect(
        child: Transform(
          transform: Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: Image.network(
            widget.photo.url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ProfileGalleryPhotoItem extends StatelessWidget {
  ProfileGalleryPhotoItem({
    Key key,
    @required this.photo,
    @required this.tileStyle,
    @required this.onBannerTap
  }) : assert(photo != null && photo.isValid),
       assert(tileStyle != null),
       assert(onBannerTap != null),
       super(key: key);

  final Photo photo;
  final TileStyle tileStyle;
  final BannerTapCallback onBannerTap; // User taps on the photo's header or footer.

  void showPhoto(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Colors.grey[800],),
            title: Text(photo.title, style: TextStyle(color: Colors.grey[800]),),
            backgroundColor: Colors.white,
          ),
          body: SizedBox.expand(
            child: Hero(
              tag: photo.tag,
              child: ProfileGalleryPhotoViewer(photo: photo),
            ),
          ),
        );
      }
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = GestureDetector(
      onTap: () { showPhoto(context); },
      child: Hero(
        key: Key(photo.photoId),
        tag: photo.tag,
        child: Image.network(
          photo.url,
          fit: BoxFit.cover,
        ),
      )
    );

    final IconData icon = photo.isFavorite ? Icons.star : Icons.star_border;

    switch (tileStyle) {
      case TileStyle.imageOnly:
        return image;

      case TileStyle.oneLine:
        return GridTile(
          header: GestureDetector(
            onTap: () { onBannerTap(photo); },
            child: GridTileBar(
              title: _GridTitleText(photo.title),
              backgroundColor: Colors.black45,
              leading: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          child: image,
        );

      case TileStyle.twoLine:
        return GridTile(
          footer: GestureDetector(
            onTap: () { onBannerTap(photo); },
            child: GridTileBar(
              backgroundColor: Colors.black45,
              title: _GridTitleText(photo.title),
              subtitle: _GridTitleText(photo.caption),
              trailing: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          child: image,
        );
    }
    assert(tileStyle != null);
    return null;
  }
}

class ProfileGalleryApp extends StatefulWidget {
  const ProfileGalleryApp({ Key key }) : super(key: key);

  @override
  ProfileGalleryAppState createState() => ProfileGalleryAppState();
}

class ProfileGalleryAppState extends State<ProfileGalleryApp> {
  TileStyle _tileStyle = TileStyle.twoLine;

  List<Photo> photos = <Photo>[
    Photo(
      photoId: "1",
      title: '暹罗猫',
      caption: '高小乐',
      url: 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2333090299,850498900&fm=5'
    ),
    Photo(
        photoId: "2",
        title: '布偶猫',
        caption: '岑晓飞',
        url: 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2247692397,1189743173&fm=5'
    ),
    Photo(
        photoId: "3",
        title: '苏格兰折耳猫',
        caption: '高小乐',
        url: 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1569462993,172008204&fm=5'
    ),
    Photo(
        photoId: "4",
        title: '英国短毛猫',
        caption: '岑晓飞',
        url: 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1667994205,255365672&fm=5'
    ),
    Photo(
        photoId: "5",
        title: '波斯猫',
        caption: '岑晓飞',
        url: 'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1853832225,307688784&fm=5'
    ),
    Photo(
        photoId: "6",
        title: '俄罗斯蓝猫',
        caption: '高小乐',
        url: 'https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1996483760,1134669411&fm=5'
    ),
    Photo(
        photoId: "7",
        title: '美国短毛猫',
        caption: '岑晓飞',
        url: 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2406161785,701397900&fm=5'
    ),
    Photo(
        photoId: "8",
        title: '异国短毛猫',
        caption: '高小乐',
        url: 'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2244238741,1217077712&fm=5'
    ),
    Photo(
        photoId: "9",
        title: '挪威森林猫',
        caption: '岑晓飞',
        url: 'https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1917461690,696184102&fm=5'
    ),
    Photo(
        photoId: "10",
        title: '孟买猫',
        caption: '高小乐',
        url: 'https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=2287816931,1201096380&fm=5'
    ),

  ];

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.grey[800],),
        title: Text("相册", style: TextStyle(color: Colors.grey[800]),),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SafeArea(
              top: false,
              bottom: false,
              child: GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(4.0),
                childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: photos.map<Widget>((Photo photo) {
                  return ProfileGalleryPhotoItem(
                    photo: photo,
                    tileStyle: _tileStyle,
                    onBannerTap: (Photo photo) {
                      if(!this.mounted){
                        return;
                      }
                      setState(() {
                        photo.isFavorite = !photo.isFavorite;
                      });
                    }
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
