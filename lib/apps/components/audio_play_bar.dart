

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';

enum PlayerState { stopped, playing, paused }


class AudioPlayBar extends StatefulWidget{
  
  final FileSystemEntity file;
  String filePath;
  String detailFilePath;
  AudioPlayBar({Key key, this.file,this.filePath,this.detailFilePath}) : super(key: key);

  @override
  AudioPlayBarState createState(){
    return new AudioPlayBarState(file: file,filePath: filePath,detailFilePath: detailFilePath);
  }
}



class AudioPlayBarState extends State<AudioPlayBar>{
  File file;
  AudioPlayer audioPlayer;
  Duration duration; // full duration of file
  Duration position; 
  String filePath;
  PlayerState playerState = PlayerState.stopped;
  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;
  String detailFilePath;


  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;



  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  @override 
  AudioPlayBarState({this.file,this.filePath,this.detailFilePath});

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }



  void initAudioPlayer() {
    audioPlayer = new AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) {
      if(!this.mounted){
        return;
      }
          setState(() => position = p);
        });
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        if(!this.mounted){
          return;
        }
        setState(() => duration = audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        if(!this.mounted){
          return;
        }
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
          if(!this.mounted){
            return;
          }
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  void onComplete() {
    if(!this.mounted){
      return;
    }
    setState(
      () => playerState = PlayerState.stopped
    );
  }

  Future play() async {
    if(filePath[0]=="/"){
      await audioPlayer.play(filePath,isLocal: true);
    }
    else{
      await audioPlayer.play(filePath);
    }

    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future pause() async {
    print ("Pressed pause");
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = new Duration();
    });
  }

  Future fastForward() async {     
    try{
      int dur = audioPlayer.duration.inSeconds;
      audioPlayer.seek(dur.toDouble()*0.8);
      setState( (){
       playerState = PlayerState.playing;
       duration = Duration(seconds: dur.toInt());  
      });
    } catch(e){
      print( "Error attempting to fast forward");
    }
  }

  Future fastRewind() async {
    
    try{
      int dur = audioPlayer.duration.inSeconds;
      audioPlayer.seek(dur.toDouble()*0.2);
      setState( (){
       playerState = PlayerState.playing;
       duration = Duration(seconds: dur);  
     });
    }catch(e){
      print( "Error attempting to fast rewind");
    }
  }

movedSlider(double value){
  try{
    audioPlayer.seek( (value/1000.0).roundToDouble() ); 
  }catch(e){
    print("Error attempting to seek to time");
  }
  int dur = audioPlayer.duration.inSeconds.toInt();
  setState((){ 
      duration = Duration(seconds: dur);
    }
  );
}

Widget build(BuildContext context){
  String file_name='';
    try{
      file_name= detailFilePath.split('/').last.split('.').first;
    }
    catch(e){
      print(e);
    }

    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
              children: [
                Spacer(flex:1),
                // Display the filename
                Text(
                  file_name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5,
                  ),
                Container(height:12.0),
                // Display the audio position (time)
                position == null ?
                  Container() : Text(positionText,textScaleFactor: 1.2,),
                // Display the slider
                duration == null 
                ?  Container() :
                   Slider(
                  value: position?.inMilliseconds?.toDouble() ?? 0.0 , 
                  min: 0.0,
                  max: duration.inMilliseconds.toDouble(),
                  onChanged: movedSlider,   
                ),
                Container(height:20.0),
                // Display the audio control buttons
                ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //new FloatingActionButton(
                      //  child: new Icon(Icons.fast_rewind),
                      //  onPressed: ()=>fastRewind(),
                      //  mini: true,
                      //),
                      new FloatingActionButton(
                        child: isPlaying
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                        onPressed: isPlaying ? () => pause() : () => play(),
                      ),
                      //new FloatingActionButton(
                      //  child: new Icon(Icons.fast_forward),
                      // mini: true,
                      //  onPressed: () => fastForward(),
                      //),
                    ]),
                    Spacer(),
              ],
            )));
  }

}