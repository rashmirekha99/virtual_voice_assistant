import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
import 'package:voice_assistant/services/image_generation_services.dart';
import 'package:voice_assistant/services/text_generation_services.dart';
import 'package:voice_assistant/view/widgets/image_bubble.dart';
import 'package:voice_assistant/view/widgets/left_bubble.dart';
import 'package:voice_assistant/view/widgets/right_bubble.dart';

class AssistantViewModel extends ChangeNotifier {
  SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  String _response = '';
  String _imagePath = '';
  bool _micOn = false;
  List<Widget> _chatBubbleList = [
    LeftBubble(msg: TextConstant.initialBotMsg),
  ];
  SpeechToText get speechToText => _speechToText;
  String get lastWords => _lastWords;
  String get response => _response;
  String get imagePath => _imagePath;
  bool get micOn => _micOn;
  List<Widget> get chatBubbleList => _chatBubbleList;

  FlutterTts flutterTts = FlutterTts();

  Future<void> _systemSpeak(String response) async {
    await flutterTts.speak(response);
  }

  Future<void> _stopSpeak() async {
    await flutterTts.stop();
  }

  void addChats(Widget bubble) {
    _chatBubbleList.add(bubble);
    notifyListeners();
  }

  void clearLastWord() {
    _lastWords = '';
    notifyListeners();
  }

  void _setMic(bool status) {
    _micOn = status;
    notifyListeners();
  }

  /// This has to happen only once per app
  Future<void> initSpeech() async {
    await _speechToText.initialize();
    notifyListeners();
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);

    notifyListeners();
  }

  Future<void> stopListening() async {
    if (_lastWords.isNotEmpty) {
      addChats(RightBubble(msg: _lastWords));
    }

    await _speechToText.stop();

    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;

    notifyListeners();
  }

  void onMic() async {
    if (_speechToText.isNotListening && _lastWords.isEmpty) {
      _setMic(true);
      _stopSpeak();
      notifyListeners();
      await startListening();
    } else {
      _setMic(false);
      notifyListeners();
      await stopListening();
      // _response = await TextGenerationServices.textGeneration(_lastWords);
      final image = await ImageGenerationServices.imageGeneration(_lastWords);

      addChats(ImageBubble(path: image));

      clearLastWord();
      if (_response != '') {
        _systemSpeak(response);
        addChats(LeftBubble(msg: _response));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
    flutterTts.stop();
  }
}
