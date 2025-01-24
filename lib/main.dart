import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_assistant/core/theme/theme.dart';
import 'package:voice_assistant/routes/routes.dart';
import 'package:voice_assistant/view/pages/home_page.dart';
import 'package:voice_assistant/viewmodel/assistant_view_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AssistantViewModel(),
    child: const MyApp(),
  ));
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
