import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../providers/library_provider.dart';
import '../providers/play_audio_provider.dart';
import '../providers/record_audio_provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => keepAlive();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _libaryProvider = Provider.of<LibraryProvider>(context);

    // if (_libaryProvider.playingAudio) {
    //   updateKeepAlive();
    // }
    // else {
    //   state = false;
    // }
    return FutureBuilder<Iterable<File>>(
        future: _libaryProvider.getFilesList(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<Iterable<File>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: <Widget>[
                  if (_libaryProvider.playingAudio == false)
                    ListView(
                      children: <Widget>[
                        for (var file in _libaryProvider.entities)
                          Card(
                            child: ListTile(
                              onTap: () async =>
                              await _libaryProvider.playRecording(file),
                              leading: const Icon(
                                Icons.audiotrack_outlined,
                                color: Colors.blue,
                              ),
                              title: Text(file.path),
                              subtitle: Text(file.path
                                  .substring(file.path.indexOf('recordings/') +
                                  11)),
                              trailing: const Icon(Icons.more_vert),
                            ),
                          ),
                      ],
                    ),
                  // const SizedBox(height: 80),
                  if (_libaryProvider.playingAudio)
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _recordHeading(),
                          _backButton(),
                        ]
                    ),
                ],
              ),
            );
          }
          else {
            return Text('State: ${snapshot.connectionState}');
          }
        }
        );
  }

  keepAlive() {
    // if(wantKeepAlive == false) {
    //   return true;
    // }
    // else {
    //   return false;
    // }
    return false;
  }
  _recordHeading() {
    return const Center(
      child: Text(
        'Record Audio',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
      ),
    );
  }

  _backButton() {
    final _libraryProvider =
        Provider.of<LibraryProvider>(context, listen: false);

    return InkWell(
      onTap: () => _libraryProvider.stopPlaying(),
      child: Center(
        child: Container(
          width: 80,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Back',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  _playAudioHeading() {
    return const Center(
      child: Text(
        'Play Audio',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
      ),
    );
  }

  _recordingSection() {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);
    final _recordProviderWithoutListener =
        Provider.of<RecordAudioProvider>(context, listen: false);

    if (_recordProvider.isRecording) {
      return InkWell(
        onTap: () async => await _recordProviderWithoutListener.stopRecording(),
        child: RippleAnimation(
          repeat: true,
          color: Colors.grey,
          minRadius: 40,
          ripplesCount: 6,
          child: _commonIconSection(),
        ),
      );
    }

    return InkWell(
      onTap: () async => await _recordProviderWithoutListener.recordVoice(),
      child: _commonIconSection(),
    );
  }

  _commonIconSection() {
    return Container(
      width: 70,
      height: 70,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff4BB543),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Icon(Icons.keyboard_voice_rounded,
          color: Colors.white, size: 30),
    );
  }

  _audioPlayingSection() {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width - 110,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white24,
      ),
      child: Row(
        children: [
          _audioControllingSection(_recordProvider.recordedFilePath),
          _audioProgressSection(),
        ],
      ),
    );
  }

  _audioControllingSection(String songPath) {
    final _playProvider = Provider.of<PlayAudioProvider>(context);
    final _playProviderWithoutListen =
        Provider.of<PlayAudioProvider>(context, listen: false);

    return IconButton(
      onPressed: () async {
        if (songPath.isEmpty) return;

        await _playProviderWithoutListen.playAudio(File(songPath));
      },
      icon: Icon(
          _playProvider.isSongPlaying ? Icons.pause : Icons.play_arrow_rounded),
      color: Colors.green,
      iconSize: 30,
    );
  }

  _audioProgressSection() {
    final _playProvider = Provider.of<PlayAudioProvider>(context);

    return Expanded(
        child: Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: LinearPercentIndicator(
        percent: _playProvider.currLoadingStatus,
        backgroundColor: Colors.black26,
        progressColor: Colors.blue,
      ),
    ));
  }



// _resetButton() {
//   final _recordProvider = Provider.of<RecordAudioProvider>(context, listen: false);
//
//   return InkWell(
//     onTap: () => _recordProvider.clearOldData(),
//     child: Center(
//       child: Container(
//         width: 80,
//         alignment: Alignment.center,
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: const Text(
//           'Reset',
//           style: TextStyle(fontSize: 18, color: Colors.white),
//         ),
//       ),
//     ),
//   );
}
