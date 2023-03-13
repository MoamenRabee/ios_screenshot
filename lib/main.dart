import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ios_insecure_screen_detector/ios_insecure_screen_detector.dart';
import 'package:ios_screenshot/screenshot.dart';
import 'package:screen_protector/screen_protector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await ScreenProtector.preventScreenshotOn(); // prevent screenshot on ios
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test Screen Recorder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stream<bool> checkIfScreenRecording() async* {
    final IosInsecureScreenDetector insecureScreenDetector =
        IosInsecureScreenDetector();
    await insecureScreenDetector.initialize();
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      bool isCaptured = await insecureScreenDetector.isCaptured();
      log("isCaptured :$isCaptured");
      yield isCaptured;
    }
  }

  late StreamSubscription<bool> streamSubscription;

  @override
  void initState() {
    super.initState();
    // For iOS only.
    if (Platform.isIOS) {
      streamSubscription = checkIfScreenRecording().listen((isRecording) {
        if (isRecording) {
          streamSubscription.cancel();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return const ScreenShotScreen();
          }));
        }
      });
    }
  }

  @override
  void dispose() {
    // don't forget to cancel the streamSubscription
    if (Platform.isIOS) {
      streamSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Test Screen Recorder For Ios',
            ),
          ],
        ),
      ),
    );
  }
}
