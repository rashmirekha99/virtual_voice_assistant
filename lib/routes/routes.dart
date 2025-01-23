import 'package:flutter/material.dart';
import 'package:voice_assistant/routes/route_names.dart';
import 'package:voice_assistant/view/pages/assistant_page.dart';
import 'package:voice_assistant/view/pages/home_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  // RouteNames.initialRoute: (context) => const AssistantPage(),
  RouteNames.homePage: (context) => const HomePage(),
  RouteNames.assistantPage: (context) => const AssistantPage()
};
