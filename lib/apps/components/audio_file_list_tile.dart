import 'dart:io';
import 'dart:async';
import 'package:finerit_app_flutter/icons/icons_route2.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import 'save_dialog.dart';
import 'audio_play_bar.dart';

class AudioFileListTile extends StatefulWidget {
  var state=0;
  final FileSystemEntity file;
  String baseFilePath;
  String detailFilePath;
  AudioFileListTile({Key key, this.file,this.state,this.baseFilePath,this.detailFilePath}) : super(key: key);

  @override
  AudioFileListTileState createState() {
    return new AudioFileListTileState(file: file,state: state,baseFilePath: baseFilePath,detailFilePath: detailFilePath);
  }
}

class AudioFileListTileState extends State<AudioFileListTile> {
  FileSystemEntity file;
  String filePath;
  String fileName;
  var state;
  String baseFilePath;
  String detailFilePath;

  @override
  AudioFileListTileState({Key key,this.state,this.file,this.baseFilePath,this.detailFilePath}):super();



  initFileAttributes(File file){
    // Init some convenience variables
    try{
      this.filePath = file.path;
      this.fileName = this.filePath.split("/").last.split('.').first;
    }
    catch(e){
      print(e);
    }

  }
  initFilePathAttributes(String baseFilePath){
    // Init some convenience variables
    try{
      this.filePath = baseFilePath;
      this.fileName = this.filePath.split("/").last.split('.').first;
    }
    catch(e){
      print(e);
    }

  }


  Row createTrailingButtons() {
    // Note: https://stackoverflow.com/questions/44656013
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        /*
        IconButton(
          icon: new Icon(Icons.delete),
          onPressed: (){
            showDialog(
              context: context,
              builder: (_) =>_openQueryDeleteDialog(),
            );
          }
        ),
        */
//        PopupMenuButton<String>(
//            padding: EdgeInsets.zero,
//            onSelected: (value) {},
//            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                  PopupMenuItem<String>(
//                      value: 'Rename',
//                      child: ListTile(
//                        leading: Icon(Icons.redo),
//                        title: Text('Rename'),
//                        onTap: _showSaveDialog,
//                      )),
//
//                  PopupMenuDivider(), // ignore: list_element_type_not_assignable, https://github.com/flutter/flutter/issues/5771
//                  PopupMenuItem<String>(
//                      value: 'Delete',
//                      child: ListTile(
//                        leading: Icon(Icons.delete),
//                        title: Text('Delete'),
//                        onTap: () {
//                          Navigator.pop(context);
//                          showDialog(
//                            context: context,
//                            builder: (_) => _openQueryDeleteDialog(),
//                          );
//                        },
//                      ))
//                ])
        /*
        IconButton(
          icon: new Icon(Icons.create),
          onPressed: null, //FIXME
        )
        */
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    if(state==0){
      if(detailFilePath!=null){
        initFilePathAttributes(detailFilePath);
      }
      else{
        initFilePathAttributes(baseFilePath);
      }
      return GestureDetector(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width*0.3,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/voice.png',
                fit: BoxFit.fill,
                repeat: ImageRepeat.repeatY,
              ),
              fileName[0]=="0"?new Text(fileName.replaceAll("_", ":")):Text(""),

            ],
          ),
        ),
        onTap: (){
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return AudioPlayBar(filePath: baseFilePath,detailFilePath: detailFilePath.replaceAll("_", ":"),);
              });
        },
      );
//      return new ListTile(
//          title: new Text(fileName.replaceAll("_", ":"),style: TextStyle(color: Colors.black26),),
//          dense: false,
//          leading: Icon(MyFlutterApp2.bofang,color: Colors.black26,),
//          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
//          trailing: createTrailingButtons(),
//          onTap: () {
//            showModalBottomSheet<void>(
//                context: context,
//                builder: (BuildContext context) {
//                  return AudioPlayBar(filePath: baseFilePath,detailFilePath: detailFilePath.replaceAll("_", ":"),);
//                });
//
//          });
    }
    else if(state==1){
      final VoiceModel voiceModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
      initFilePathAttributes(voiceModel.voiceFile.path);
      if(fileName.length<8){
        fileName="0"+fileName;
      }
      return GestureDetector(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width*0.3,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/voice.png',
                fit: BoxFit.fill,
                repeat: ImageRepeat.repeatY,
              ),
              fileName[0]=="0"?new Text(fileName.replaceAll("_", ":")):Text(""),

            ],
          ),
        ),
        onTap: (){
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return AudioPlayBar(filePath: voiceModel.voiceFile.path,detailFilePath: fileName.replaceAll("_", ":"),);
              });
        },
      );

//        new ListTile(
//          title: new Text(fileName.replaceAll("_", ":")),
//          dense: false,
//          leading: Icon(MyFlutterApp2.bofang),
//          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
//          trailing: createTrailingButtons(),
//          onTap: () {
//            showModalBottomSheet<void>(
//                context: context,
//                builder: (BuildContext context) {
//                  return AudioPlayBar(filePath: voiceModel.voiceFile.path,detailFilePath: fileName.replaceAll("_", ":"),);
//                });
//
//          });
    }

  }
}
