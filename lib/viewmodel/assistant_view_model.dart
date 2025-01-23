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
  Future<void> _startListening() async {
    _setMic(true);
    await _speechToText.listen(onResult: _onSpeechResult);

    notifyListeners();
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> _stopListening() async {
    addChats(RightBubble(msg: _lastWords));
    await _speechToText.stop();
    _setMic(false);

    notifyListeners();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    notifyListeners();
  }

  void onMic() async {
    // print('listening ${_speechToText.isListening}');
    if (await _speechToText.hasPermission && _speechToText.isNotListening) {
      print('inside 1');

      await _startListening();
    } else {
      print('inside 2');
      _chatBubbleList.add(LeftBubble(msg: _lastWords));
      await _stopListening();
      _response = await GoogleAiServices.textGeneration(_lastWords);
      if (response != '') {
        _chatBubbleList.add(RightBubble(msg: _response));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
  }
}
