import 'package:flutter/material.dart';

void scrollToBottom(ScrollController scrollController) {
  final position = scrollController.position.maxScrollExtent;
  scrollController.animateTo(position + 500,
      duration: const Duration(seconds: 1), curve: Curves.easeIn);
}
