import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';

class TextToSpeechProvider extends ChangeNotifier {
  FlutterTts flutterTts = FlutterTts();

  Future<void> systemSpeak([String response=TextConstant.initialBotMsg]) async {
    await flutterTts.speak(response);
  }

  Future<void> stopSpeak() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
