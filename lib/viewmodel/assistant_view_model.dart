import 'package:voice_assistant/providers/chat_provider.dart';
import 'package:voice_assistant/providers/mic_provider.dart';
import 'package:voice_assistant/providers/speech_to_text_provider.dart';
import 'package:voice_assistant/providers/text_to_speech_provider.dart';
import 'package:voice_assistant/services/image_generation_services.dart';
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

  void onMic() async {
    if (speechToTextProvider.speechToText.isNotListening &&
        speechToTextProvider.lastWords.isEmpty) {
      micProvider.setMic(true);
      textToSpeechProvider.stopSpeak();
      await speechToTextProvider.startListening();
    } else {
      micProvider.setMic(false);
      if (speechToTextProvider.lastWords.isNotEmpty) {
        chatProvider.addChats(RightBubble(msg: speechToTextProvider.lastWords));
      }

      await speechToTextProvider.stopListening();
      // _response = await TextGenerationServices.textGeneration(_lastWords);
      final image = await ImageGenerationServices.imageGeneration(
          speechToTextProvider.lastWords);
      if (image.isNotEmpty) {
        chatProvider.addChats(ImageBubble(path: image));
        textToSpeechProvider.systemSpeak(
            'Here is a image of ${speechToTextProvider.lastWords}');
      }

      speechToTextProvider.clearLastWord();
      if (response != '') {
        textToSpeechProvider.systemSpeak(response);
        chatProvider.addChats(LeftBubble(msg: response));
      }
    }
  }
}
