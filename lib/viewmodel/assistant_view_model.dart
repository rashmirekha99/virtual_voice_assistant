import 'package:voice_assistant/providers/chat_provider.dart';
import 'package:voice_assistant/providers/mic_provider.dart';
import 'package:voice_assistant/providers/speech_to_text_provider.dart';
import 'package:voice_assistant/providers/text_to_speech_provider.dart';
import 'package:voice_assistant/services/image_generation_services.dart';
import 'package:voice_assistant/services/text_generation_services.dart';
import 'package:voice_assistant/view/widgets/image_bubble.dart';
import 'package:voice_assistant/view/widgets/left_bubble.dart';
import 'package:voice_assistant/view/widgets/right_bubble.dart';

class AssistantViewModel {
  final MicProvider micProvider;
  final ChatProvider chatProvider;
  final SpeechToTextProvider speechToTextProvider;
  final TextToSpeechProvider textToSpeechProvider;

  AssistantViewModel({
    required this.micProvider,
    required this.chatProvider,
    required this.speechToTextProvider,
    required this.textToSpeechProvider,
  });
  String response = '';
  String imagePath = '';
//image or text generation
  Future<void> _generateContentBasedOnPrompt(String prompt) async {
    final textType = await TextGenerationServices.textGeneration(
        'Is this prompt about generating an image. Answer in yes or no $prompt');
    print('textType $textType');
    if (textType.trim().toLowerCase() == 'yes') {
      imagePath = await ImageGenerationServices.imageGeneration(prompt);
    } else {
      response = await TextGenerationServices.textGeneration(prompt);
    }
  }

  Future<void> _listenToMic() async {
    micProvider.setMic(true);
    textToSpeechProvider.stopSpeak();
    await speechToTextProvider.startListening();
  }

  Future<void> _endOfListenToMic() async {
    micProvider.setMic(false);
    if (speechToTextProvider.lastWords.isNotEmpty) {
      chatProvider.addChats(RightBubble(msg: speechToTextProvider.lastWords));
    }
    await speechToTextProvider.stopListening();
    await _generateContentBasedOnPrompt(speechToTextProvider.lastWords);
    if (imagePath.isNotEmpty) {
      chatProvider.addChats(ImageBubble(path: imagePath));
      textToSpeechProvider
          .systemSpeak('Here is a image of ${speechToTextProvider.lastWords}');
    } else if (response.isNotEmpty) {
      textToSpeechProvider.systemSpeak(response);
      chatProvider.addChats(LeftBubble(msg: response));
      _clearResponse();
    }
    speechToTextProvider.clearLastWord();
  }

//on pressed mic
  void onMic() async {
    if (speechToTextProvider.speechToText.isNotListening &&
        speechToTextProvider.lastWords.isEmpty) {
      await _listenToMic();
    } else {
      await _endOfListenToMic();
    }
  }

  void _clearResponse() {
    response = '';
  }
}
