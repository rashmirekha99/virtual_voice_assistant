import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
import 'package:voice_assistant/providers/chat_provider.dart';
import 'package:voice_assistant/providers/mic_provider.dart';
import 'package:voice_assistant/providers/speech_to_text_provider.dart';
import 'package:voice_assistant/providers/text_to_speech_provider.dart';

import 'package:voice_assistant/viewmodel/assistant_view_model.dart';

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  @override
  void initState() {
    super.initState();
    context.read<SpeechToTextProvider>().initSpeech();
    context.read<TextToSpeechProvider>().systemSpeak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstant.appBarTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<ChatProvider>(builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(spacing: 15, children: value.chatBubbleList),
          );
        }),
      ),
      floatingActionButton: _floatingActionButton,
    );
  }

  Widget get _floatingActionButton => FloatingActionButton(
      onPressed: () {
        context.read<AssistantViewModel>().onMic();
      },
      child: Icon(
          context.watch<MicProvider>().micOn ? Icons.bar_chart : Icons.mic));
}
