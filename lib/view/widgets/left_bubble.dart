import 'package:flutter/material.dart';
import 'package:voice_assistant/core/constant/image_constant.dart';
import 'package:voice_assistant/core/theme/color_palette.dart';

class LeftBubble extends StatelessWidget {
  const LeftBubble({super.key, required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(ImageConstant.botImage)),
        //chat bubble
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: ColorPalette.secondaryWhite,
              borderRadius: BorderRadius.circular(20)
                  .copyWith(topLeft: const Radius.circular(0)),
              border: Border.all(color: ColorPalette.shadowColor)),
          child: Text(msg),
        ),
      ],
    );
  }
}
