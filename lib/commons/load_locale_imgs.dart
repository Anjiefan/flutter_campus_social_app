import 'package:flutter/material.dart';
import 'package:multi_image_picker/asset.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class AssetView extends StatefulWidget {
  final int _index;
  final Asset _asset;

  AssetView(this._index, this._asset);

  @override
  State<StatefulWidget> createState() => AssetState(this._index, this._asset);
}

class AssetState extends State<AssetView> {
  int _index = 0;
  Asset _asset;
  AssetState(this._index, this._asset);

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    await this._asset.requestThumbnail(300, 300, quality: 50);

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (null != this._asset.thumbData) {
      return Image.memory(
        this._asset.thumbData.buffer.asUint8List(),
        fit: BoxFit.cover,
        gaplessPlayback: true,
      );
    }

    return Text(
      '${this._index}',
      style: Theme.of(context).textTheme.headline,
    );
  }
}

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Asset> images = List<Asset>();
  String _error;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        return AssetView(index, images[index]);
      }),
    );
  }

  Future<void> loadAssets() async {
    if(!this.mounted){
      return;
    }
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        options: CupertinoOptions(takePhotoIcon: "chat"),
      );
    } on PlatformException catch (e) {
      error = e.message;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Expanded(
              child: buildGridView(),
            )
          ],
        ),
      ),
    );
  }
}