import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
import 'package:voice_assistant/services/api_services.dart';
import 'package:voice_assistant/view/widgets/left_bubble.dart';
import 'package:voice_assistant/view/widgets/right_bubble.dart';

class AssistantViewModel extends ChangeNotifier {
  SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  String _response = '';
  bool _micOn = false;
  List<Widget> _chatBubbleList = [
    LeftBubble(msg: TextConstant.initialBotMsg),
  ];
  SpeechToText get speechToText => _speechToText;
  String get lastWords => _lastWords;
  String get response => _response;
  bool get micOn => _micOn;
  List<Widget> get chatBubbleList => _chatBubbleList;

  void addChats(Widget bubble) {
    _chatBubbleList.add(bubble);
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
    addChats(RightBubble(msg: _lastWords));
    await _speechToText.stop();
    print('Stopped Listening');
    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    print(_lastWords);
    notifyListeners();
  }

  void onMic() async {
    if (_speechToText.isNotListening) {
      print('inside 1');
      _setMic(true);

      notifyListeners();
      await startListening();
    } else {
      _setMic(false);

      notifyListeners();
      print('inside 2');
      await stopListening();
      _response = await GoogleAiServices.textGeneration(_lastWords);
      if (_response != '') {
        addChats(LeftBubble(msg: _response));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
  }
}
