import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_assistant/core/theme/theme.dart';
import 'package:voice_assistant/providers/chat_provider.dart';
import 'package:voice_assistant/providers/mic_provider.dart';
import 'package:voice_assistant/providers/speech_to_text_provider.dart';
import 'package:voice_assistant/providers/text_to_speech_provider.dart';
import 'package:voice_assistant/routes/routes.dart';
import 'package:voice_assistant/view/pages/home_page.dart';
import 'package:voice_assistant/viewmodel/assistant_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => MicProvider()),
        ChangeNotifierProvider(create: (context) => SpeechToTextProvider()),
        ChangeNotifierProvider(create: (context) => TextToSpeechProvider()),
        ProxyProvider4<ChatProvider, MicProvider, SpeechToTextProvider,
            TextToSpeechProvider, AssistantViewModel>(
          update: (_, chatProvider, micProvider, speechToTextProvider,
                  textToSpeechProvider,viewModel) =>
              AssistantViewModel(
                  micProvider: micProvider,
                  chatProvider: chatProvider,
                  speechToTextProvider: speechToTextProvider,
                  textToSpeechProvider: textToSpeechProvider),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: routes,
    );
  }
}
