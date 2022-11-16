import 'package:bond/screens/record_and_play.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/play_audio_provider.dart';
import '../providers/record_audio_provider.dart';
// import 'package:record_with_play/screens/record_and_play_audio.dart';

void main() {
  runApp(const EntryRoot());
}

class EntryRoot extends StatelessWidget {
  const EntryRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordAudioProvider()),
        ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Record and Play',
        home: RecordAndPlayScreen(),
      ),
    );
  }
}