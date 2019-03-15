import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class SaveDialog extends StatefulWidget {
  // The SaveDialog will take the [defaultAudioFile] as input and rename it
  // with a new filename based on [dialogText] if the user presses the "Save" button.
  // If [doLookupLargestIndex] is true, the default new file filename will be
  // automatically numbered based on files already in the appDocumentsDirectory.

  final File defaultAudioFile;
  final String dialogText;
  final bool doLookupLargestIndex;

  SaveDialog({
    Key key,
    this.defaultAudioFile,
    this.dialogText = "给录音取个名字吧！",
    this.doLookupLargestIndex = true,
  }) : super(key: key);

  @override
  SaveDialogState createState() {
    return SaveDialogState(defaultAudioFile, dialogText, doLookupLargestIndex);
  }
}

class SaveDialogState extends State<SaveDialog> {
  File defaultAudioFile;
  String dialogText;
  String newFilePath;
  TextEditingController _textController;
  bool doLookupLargestIndex;

  SaveDialogState(
      this.defaultAudioFile, this.dialogText, this.doLookupLargestIndex);

  @override
  initState() {
    super.initState();
    initTextController(true);
  }

  @override
  dispose() {
    super.dispose();
    this._textController.dispose();
  }

  initTextController(bool doRebuildTextController) {
    if (doLookupLargestIndex) {
      initTextControllerWithLargestFileName(
          doRebuildTextController: doRebuildTextController);
    } else {
      initTextControllerWithCurrentFileName(
          doRebuildTextController: doRebuildTextController);
    }
  }

  Future<Null> initTextControllerWithCurrentFileName(
      {bool doRebuildTextController = true}) async {
    if(!this.mounted){
      return;
    }
    setState(() {
      this.newFilePath = defaultAudioFile.path;
      String defaultFileName =
          defaultAudioFile.path.split('/').last.split('.').first;
      if (doRebuildTextController) {
        this._textController = TextEditingController(text: defaultFileName);
      }
    });
  }

  Future<Null> initTextControllerWithLargestFileName(
      {bool doRebuildTextController = true}) async {
    Directory directory = await getApplicationDocumentsDirectory();

    String fname = await _largestNumberedFilename();
    print("new $fname");
    String fpath = p.join(directory.path, fname + '.m4a');
    if(!this.mounted){
      return;
    }
    setState(() {
      this.newFilePath = fpath;
      if (doRebuildTextController) {
        this._textController = TextEditingController(text: fname);
      }
    });
  }

  void _renameAudioFile() async {
    newFilePath =
        p.join(p.dirname(defaultAudioFile.path), _textController.text + '.m4a');
    if (defaultAudioFile != null && newFilePath != null) {
      try {
        print("New file path $newFilePath");
        defaultAudioFile.rename(newFilePath); //FIXME!!!!
        //Reset the textController state
        initTextController(false);
      } catch (e) {
        if (await defaultAudioFile.exists()) {
          //FIXME: add file already exists warning
          print("File $defaultAudioFile already exists");
        } else {
          print('Error renaming file');
        }
      }
    } else {
      print("File $defaultAudioFile is null!");
    }
    // Close the save dialog and return a newFilePath which can be passed to
    // the Widget that called showDialog()
    Navigator.pop(context, File(newFilePath));
  }

  Future<String> _largestNumberedFilename(
      {String filenamePrefix: "Recording-", String delimiter: "-"}) async {
    // Get the largest numbered filename with a given [filenamePrefix] and [delimiter]
    // from the ApplicationDocumentsDirectory

    bool isNumeric(String s) {
      //Helper method. See https://stackoverflow.com/questions/24085385/
      if (s == null) {
        return false;
      }
      // TODO according to DartDoc num.parse() includes both (double.parse and int.parse)
      return double.parse(s, (e) => null) != null ||
          int.parse(s, onError: (e) => null) != null;
    }

    try {
      Directory directory = await getApplicationDocumentsDirectory();
      int largestInt = 0;
      print("Dir $directory");
      List<FileSystemEntity> entities = directory.listSync();
      for (FileSystemEntity entity in entities) {
        String filePath = entity.path;
        if (filePath.endsWith('.m4a') && !(filePath.startsWith('Temp'))) {
          String bname = p.basename(filePath);
          if (bname.startsWith(filenamePrefix)) {
            final String noExt = bname.split('.')[0];
            String strIndex = noExt.split(delimiter).last;
            if (isNumeric(strIndex)) {
              int curInt = int.parse(strIndex);
              largestInt = max(largestInt, curInt);
            }
          }
        }
      }

      largestInt += 1;
      print("Found largest index $largestInt");
      return filenamePrefix + largestInt.toString();
    } catch (e) {
      print(
          "Error, failed to get documents directory and calculate largest numbered filename");
      return "1234";
    }
  }

  @override
  Widget build(BuildContext context) {
    //FIXME: This should be done with a SharedAudioFile context

    print("Building");
    return AlertDialog(
        title: Text(dialogText),
        content: TextFormField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: "Filename:",
            hintText: "Enter a filename with no extension.",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter a filename";
            }
          },
        ),
        actions: <Widget>[
          new FlatButton(
            child: const Text("SAVE"),
            onPressed: () =>
                _renameAudioFile(), //FIXME (change default audio file name to specified name)
          ),
          new FlatButton(
            child: const Text("CANCEL"),
            onPressed: () => Navigator.pop(
                context, null), //Pass null to the Widget that called showDialog
          )
        ]);
  }
}
