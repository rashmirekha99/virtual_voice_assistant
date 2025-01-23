import 'package:flutter/material.dart';
import 'package:voice_assistant/core/constant/image_constant.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
import 'package:voice_assistant/core/theme/color_palette.dart';

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
          Row(
            children: [
              Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.amber),
                  child: Image.asset(ImageConstant.botImage)),
              //chat bubble
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: ColorPalette.secondaryWhite,
                    borderRadius: BorderRadius.circular(20)
                        .copyWith(topLeft: const Radius.circular(0)),
                    border: Border.all(color: ColorPalette.shadowColor)),
                child: const Text(TextConstant.initialBotMsg),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //chat bubble
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: ColorPalette.secondaryWhite,
                    borderRadius: BorderRadius.circular(20)
                        .copyWith(topLeft: const Radius.circular(0)),
                    border: Border.all(color: ColorPalette.shadowColor)),
                child: const Text(TextConstant.initialBotMsg),
              ),
              Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.amber),
                  child: Image.asset(ImageConstant.botImage)),
            ],
          )
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
