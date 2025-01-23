import 'package:flutter/material.dart';
import 'package:voice_assistant/core/constant/image_constant.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
import 'package:voice_assistant/core/secrets.dart';
import 'package:voice_assistant/routes/route_names.dart';
import 'package:voice_assistant/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstant.appBarTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset(ImageConstant.botImage),
          ElevatedButton(
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 50))),
              onPressed: () async {
                await GoogleAiServices.textGeneration();
                //  Navigator.of(context).pushNamed(RouteNames.assistantPage);
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
