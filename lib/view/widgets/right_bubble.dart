import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:voice_assistant/core/constant/image_constant.dart';
import 'package:voice_assistant/core/theme/color_palette.dart';

class RightBubble extends StatelessWidget {
  const RightBubble({super.key, required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
    return SlideInRight(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //chat bubble
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: ColorPalette.rightBubbleColor,
                  borderRadius: BorderRadius.circular(20)
                      .copyWith(topRight: const Radius.circular(0)),
                  border: Border.all(color: ColorPalette.shadowColor)),
              child: Text(softWrap: true, msg),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(ImageConstant.userImage)),
            ),
          ],
        ),
      ),
    );
  }
}
