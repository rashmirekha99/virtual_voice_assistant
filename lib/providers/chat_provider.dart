import 'package:flutter/material.dart';
import 'package:voice_assistant/core/constant/text_constant.dart';
import 'package:voice_assistant/core/utils/scroll_to_bottom.dart';
import 'package:voice_assistant/view/widgets/left_bubble.dart';

class ChatProvider extends ChangeNotifier {
  List<Widget> _chatBubbleList = [
    LeftBubble(msg: TextConstant.initialBotMsg),
  ];

  ScrollController chatScrollController = ScrollController();

  List<Widget> get chatBubbleList => _chatBubbleList;
  void addChats(Widget bubble) {
    _chatBubbleList.add(bubble);
    scrollToBottom(chatScrollController);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    chatScrollController.dispose();
  }
}
