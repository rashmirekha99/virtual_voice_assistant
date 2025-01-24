import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:voice_assistant/core/api/apis.dart';
import 'package:http/http.dart' as http;
import 'package:voice_assistant/core/secrets.dart';

class ImageGenerationServices {
  static Future<String> imageGeneration(String prompt) async {
    print('Inside image generation');
    try {
      final res = await http.post(
        Uri.parse(APIS.imageGenerationApi),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $huggingFaceApiKey"
        },
        body: jsonEncode(
          {"inputs": prompt},
        ),
      );
      if (res.statusCode == 200) {
        // Wait for the directory path
        final directory = await getApplicationDocumentsDirectory();
        final filePath =
            '${directory.path}/${DateTime.timestamp()}_${prompt.substring(1, 5)}.jpg';

        // Write binary data to a file
        final file = File(filePath);
        await file.writeAsBytes(res.bodyBytes);

        return filePath;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
