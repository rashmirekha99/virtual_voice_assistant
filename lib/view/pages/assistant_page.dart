import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
import 'package:voice_assistant/view/widgets/left_bubble.dart';
import 'package:voice_assistant/view/widgets/right_bubble.dart';
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
          return Column(
            spacing: 15,
            children: value.chatBubbleList,

            // [
            //   const LeftBubble(msg: TextConstant.initialBotMsg),
            //   if (value.lastWords != '') RightBubble(msg: value.lastWords),
            //   if (value.response != '') LeftBubble(msg: value.response),
            // ],
          );
        }),
      ),
      floatingActionButton: _floatingActionButton,
    );
  }

  Widget get _floatingActionButton => FloatingActionButton(
        onPressed: () {
          print('pressed mic');
          context.read<AssistantViewModel>().onMic();
        },
        child: 
        Icon(context.watch<AssistantViewModel>().micOn ? Icons.mic_off : Icons.mic)
        
        // context.watch<AssistantViewModel>().micOn
        //     ? const Icon(Icons.bar_chart)
        //     : const Icon(Icons.mic),
      );
}
