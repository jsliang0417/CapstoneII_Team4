import 'package:bond/providers/library_provider.dart';
import 'package:bond/screens/library.dart';
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
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => RecordAudioProvider()),
    //     ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
    //   ],
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
          //   tabBarTheme: const TabBarTheme(
        //     // labelColor: Colors.red
        //   // )
        // ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.library_music_rounded)),
                  Tab(icon: Icon(Icons.favorite_sharp)),
                  Tab(icon: Icon(Icons.settings)),
                ],
              ),
              title: const Text('BOND'),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              //tab 1
              children: [
                MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => LibraryProvider()),
                  ],
                  child: const MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'BOND',
                    home: LibraryScreen(),
                  ),
                ),
                //tab 2
                MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => RecordAudioProvider()),
                    ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
                  ],
                  child: const MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'BOND',
                    home: RecordAndPlayScreen(),
                  ),
                ),
                //tab 3
                Icon(Icons.settings),
              ],
            ),
          ),
        ),
      );
    // );
  }
}