import 'package:flutter/material.dart';
import 'package:voice_assistant/core/constant/image_constant.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
import 'package:voice_assistant/core/theme/color_palette.dart';
import 'package:voice_assistant/view/widgets/right_bubble.dart';
import 'package:voice_assistant/view/widgets/left_bubble.dart';

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstant.appBarTitle),
        centerTitle: true,
      ),
      body: Column(
        spacing: 15,
        children: [
          LeftBubble(msg: TextConstant.initialBotMsg),
          RightBubble(msg: 'What is the sum of hdhc?'),
          LeftBubble(msg: TextConstant.initialBotMsg),
          RightBubble(
              msg:
                  'What is the sum of hdhc?What is the sum of hdhc?What is the sum of hdhc?What is the sum of hdhc?What is the sum of hdhc?What is the sum of hdhc?What is the sum of hdhc?What is the sum of hdhc?')
        ],
      ),
      floatingActionButton: _floatingActionButton,
    );
  }

  Widget get _floatingActionButton => FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.mic),
      );
}
