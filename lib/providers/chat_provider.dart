import 'package:flutter/material.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
import 'package:voice_assistant/view/widgets/left_bubble.dart';

class ChatProvider extends ChangeNotifier{
  List<Widget> _chatBubbleList = [
    LeftBubble(msg: TextConstant.initialBotMsg),
  ];

   List<Widget> get chatBubbleList => _chatBubbleList;
  void addChats(Widget bubble) {
    _chatBubbleList.add(bubble);
    notifyListeners();
  }

}