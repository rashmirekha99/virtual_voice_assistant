import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_assistant/core/constant/image_constant.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
import 'package:voice_assistant/core/theme/color_palette.dart';
import 'package:voice_assistant/providers/speech_to_text_provider.dart';
import 'package:voice_assistant/providers/text_to_speech_provider.dart';
import 'package:voice_assistant/routes/route_names.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<TextToSpeechProvider>().stopSpeak();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text(TextConstant.appBarTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              TextConstant.appBarTitle,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: ColorPalette.darkBlue),
            ),
          ),
          Image.asset(ImageConstant.botImage),
          ElevatedButton(
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 50))),
              onPressed: () async {
                Navigator.of(context).pushNamed(RouteNames.assistantPage);
              },
              child: Text(
                TextConstant.homePageButtonText,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ))
        ],
      ),
    );
  }
}
