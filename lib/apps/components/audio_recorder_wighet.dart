
import 'dart:io';

import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:finerit_app_flutter/extra_apps/audio/audio_recorder.dart';
import 'package:path/path.dart' as p;
import 'package:scoped_model/scoped_model.dart';

// Files used by this package
import 'save_dialog.dart';
import 'package:path_provider/path_provider.dart';


class AudioRecorderWidget extends StatefulWidget {
  AudioRecorderWidget({Key key,this.callback}) : super(key: key);
  VoidCallback callback;
  @override
  AudioRecorderPageState createState() {
    return new AudioRecorderPageState(callback: callback);
  }
}

class AudioRecorderPageState extends State<AudioRecorderWidget> {
  // The AudioRecorderPageState holds info based on
  // whether the app is currently
  // FIXME! Disable TabController when recording
  AudioRecorderPageState({Key key,this.callback}) :super();
  Recording _recording;
  bool _isRecording = false;
  bool _doQuerySave = false; //Activates save or delete buttons
  @override
  void dispose() {
    if(_isRecording){
      stopRecording();
    }
    super.dispose();

  }

  // Note: The following variables are not state variables.
  String tempFilename = "TempRecording"; //Filename without path or extension
  File defaultAudioFile;
  String fileName;
  VoidCallback callback;

  stopRecording() async {
    // Await return of Recording object
    var recording = await AudioRecorder.stop();
    bool isRecording = await AudioRecorder.isRecording;

    //final storage = SharedAudioContext.of(context).storage;
    //Directory docDir = await storage.docDir;
    Directory docDir = await getApplicationDocumentsDirectory();

    fileName=p.join(docDir.path, recording.duration.toString().split(".")[0].replaceAll(":", "_")+'.m4a');

//    fileName=p.join(docDir.path, "0_00_05"+'.m4a');
    if(!this.mounted){
      return;
    }
    setState(() {
      //Tells flutter to rerun the build method
      _isRecording = isRecording;
      _doQuerySave = true;
      defaultAudioFile = File(p.join(docDir.path, this.tempFilename+'.m4a'));
    });
  }



  startRecording() async {
    try {
      //final storage = SharedAudioContext.of(context).storage;
      //Directory docDir = await storage.docDir;
      Directory docDir = await getApplicationDocumentsDirectory();
      String newFilePath = p.join(docDir.path, this.tempFilename);
      File tempAudioFile = File(newFilePath+'.m4a');
//      Scaffold
//          .of(context)
//          .showSnackBar(new SnackBar(content: new Text("Recording."),
//        duration: Duration(milliseconds: 1400), ));
      if (await tempAudioFile.exists()){
        await tempAudioFile.delete();
      }
      if (await AudioRecorder.hasPermissions) {
        await AudioRecorder.start(
            path: newFilePath, audioOutputFormat: AudioOutputFormat.AAC);
      } else {
        Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Error! Audio recorder lacks permissions.")));
      }
      bool isRecording = await AudioRecorder.isRecording;
      if(!this.mounted){
        return;
      }
      setState(() {
        //Tells flutter to rerun the build method
        _recording = new Recording(duration: new Duration(), path: newFilePath);
        _isRecording = isRecording;
        defaultAudioFile = tempAudioFile;
      });
    } catch (e) {
      print(e);
    }
  }

  _deleteCurrentFile() async {
    //Clear the default audio file and reset query save and recording buttons
    if (defaultAudioFile != null){
      if(!this.mounted){
        return;
      }
      setState(() {
        //Tells flutter to rerun the build method
        _isRecording = false;
        _doQuerySave = false;
        defaultAudioFile.delete();
      });
    }else{
      print ("Error! defaultAudioFile is $defaultAudioFile");
    }

  }



  @override

  //TODO: do an async check of audio recorder state before building everything else
  Widget build(BuildContext context) {

    // Check if the AudioRecorder is currently recording before building the rest of the Page
    // If we do not check this,
    return FutureBuilder<bool>(
        future: AudioRecorder.isRecording,
        builder: audioCardBuilder
    );
  }

  Widget audioCardBuilder (BuildContext context, AsyncSnapshot snapshot ) {
    final VoiceModel voiceModel = ScopedModel.of<MainStateModel>(context,rebuildOnChange: true);
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return Container();
      default:
        if (snapshot.hasError){
          return new Text('Error: ${snapshot.error}');
        }else{
          bool isRecording = snapshot.data;

          // Note since this is being called in build(), we do not call set setState to change
          // the value of _isRecording
          _isRecording = isRecording;

          return new Container(
            child: new Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: new Column(
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Container(
                      width: 120.0,
                      height: 120.0,
                      child:
                      CircularProgressIndicator(
                        strokeWidth: 14.0,
                        valueColor: _isRecording ? AlwaysStoppedAnimation<Color>(Colors.blue):AlwaysStoppedAnimation<Color>(Colors.blueGrey[50]),
                        value: _isRecording ? null : 100.0,
                      )),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          children: [
                            Container(height:12.0),
                            _doQuerySave ?new FloatingActionButton(
                              child: _doQuerySave ? new Icon(Icons.cancel) : null,
                              backgroundColor:
                              _doQuerySave ? Colors.blueAccent : Colors.transparent,
                              onPressed: _doQuerySave ? (
                                  (){
                                    _deleteCurrentFile();
                                    if(!this.mounted){
                                      return;
                                    }
                                    setState(() {
                                      _doQuerySave=false;
                                    });
                                  }
                              ): null,
                              mini: true,
                            ):Container(),
                          ]
                      ),
                      Container(width: 38.0),
                      Column( children: [
                        Container(height:12.0),
                        new FloatingActionButton(
                          child: _isRecording
                              ? new Icon(Icons.stop, size: 36.0)
                              : new Icon(Icons.mic, size: 36.0),
                          onPressed: _isRecording ? stopRecording : startRecording,
                        ),]),
                      Container(width: 38.0),
                      Column(
                          children:[
                            Container(height:12.0),
                            _doQuerySave ?FloatingActionButton(
                              child: _doQuerySave ? new Icon(Icons.check_circle) : Container(),
                              backgroundColor:
                              _doQuerySave ? Colors.blueAccent : Colors.transparent,
                              mini: true,
                              onPressed: _doQuerySave ? () async {
                                defaultAudioFile=await defaultAudioFile.rename(fileName);
                                print(voiceModel.voiceFile);
                                voiceModel.voiceFile=defaultAudioFile;
                                widget.callback();
                                if(!this.mounted){
                                  return;
                                }
                                setState(() {
                                  _doQuerySave=false;
                                });
                              } : null,
                            ):Container(),]),
                    ],
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          );
        }
    }
  }}