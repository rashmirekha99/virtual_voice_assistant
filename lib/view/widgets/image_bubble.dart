import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:voice_assistant/core/constant/image_constant.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
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
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20)
                        .copyWith(topLeft: const Radius.circular(0)),
                    child: Image.file(
                      File(path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (path.isEmpty) const LinearProgressIndicator()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
