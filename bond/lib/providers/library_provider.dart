import 'dart:io';

import 'package:flutter/material.dart';

import '../services/storage_management.dart';

class LibraryProvider extends ChangeNotifier {

  List<FileSystemEntity> files = [];
  Iterable<File> entities = [];
  String _afterRecordingFilePath = '';
  String get recordedFilePath => _afterRecordingFilePath;
  bool playingAudio = false;

  Future<Iterable<File>> getFilesList() async {
    final _voiceDirPath = await StorageManagement.getAudioDir;
    // print(_voiceDirPath);
    Directory dir = Directory('$_voiceDirPath');
    // print(dir);
    files = dir.listSync(recursive: true, followLinks: false);
    entities = files.whereType<File>();
    return entities;
  }

  reset(){
    print('----------------HEREHREHEHRe');
    files = [];
    entities = [];
    playingAudio = false;
  }

  playRecording(File incomingAudioFile)async{
    playingAudio = true;
    // String? _audioFilePath;
    //
    // // if(await _record.isRecording()){
    // //   _audioFilePath = await _record.stop();
    // //   showToast('Recording Stopped');
    // // }
    //
    // print('Audio file path: $_audioFilePath');
    //
    // _isRecording = false;
    // _afterRecordingFilePath = _audioFilePath!;
    notifyListeners();
  }


  stopPlaying()async{
    playingAudio = false;
    notifyListeners();
  }
  //
  // playAudio(File incomingAudioFile, {bool update = true}) async {
  //   try {
  //     _justAudioPlayer.positionStream.listen((event) {
  //       _currAudioPlaying = event.inMicroseconds.ceilToDouble();
  //       if (update) notifyListeners();
  //     });
  //
  //     _justAudioPlayer.playerStateStream.listen((event) {
  //       if (event.processingState == ProcessingState.completed) {
  //         _justAudioPlayer.stop();
  //         _reset();
  //       }
  //     });
  //
  //     if (_audioFilePath != incomingAudioFile.path) {
  //       setAudioFilePath(incomingAudioFile.path);
  //
  //       await _justAudioPlayer.setFilePath(incomingAudioFile.path);
  //       updateSongPlayingStatus(true);
  //       await _justAudioPlayer.play();
  //     }
  //
  //     if (_justAudioPlayer.processingState == ProcessingState.idle) {
  //       await _justAudioPlayer.setFilePath(incomingAudioFile.path);
  //       updateSongPlayingStatus(true);
  //
  //       await _justAudioPlayer.play();
  //     } else if (_justAudioPlayer.playing) {
  //       updateSongPlayingStatus(false);
  //
  //       await _justAudioPlayer.pause();
  //     } else if (_justAudioPlayer.processingState == ProcessingState.ready) {
  //       updateSongPlayingStatus(true);
  //
  //       await _justAudioPlayer.play();
  //     } else if (_justAudioPlayer.processingState ==
  //         ProcessingState.completed) {
  //       _reset();
  //     }
  //   } catch (e) {
  //     print('Error in playaudio: $e');
  //   }
  // }
}