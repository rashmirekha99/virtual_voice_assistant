import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextProvider extends ChangeNotifier {
  SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  SpeechToText get speechToText => _speechToText;
  String get lastWords => _lastWords;

  void clearLastWord() {
    _lastWords = '';
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
    await _speechToText.stop();

    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    print('_lastWords $_lastWords');

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
  }
}
