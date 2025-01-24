import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
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
    context.read<AssistantViewModel>().initSpeech();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstant.appBarTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<AssistantViewModel>(builder: (context, value, child) {
          return Column(spacing: 15, children: value.chatBubbleList);
        }),
      ),
      floatingActionButton: _floatingActionButton,
    );
  }

  Widget get _floatingActionButton => Consumer(
        builder: (context, value, child) {
          return FloatingActionButton(
              onPressed: () {
                context.read<AssistantViewModel>().onMic();
              },
              child: Icon(context.watch<AssistantViewModel>().micOn
                  ? Icons.bar_chart
                  : Icons.mic));
        },
      );
}
