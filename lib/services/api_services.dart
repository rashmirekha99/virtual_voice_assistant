import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_assistant/core/api/apis.dart';
import 'package:voice_assistant/core/secrets.dart';

class GoogleAiServices {
  static Future<String> textGeneration(String prompt) async {
    try {
      final res = await http.post(Uri.parse(APIS.GoogleAiAPI),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $huggingFaceApiKey"
          },
          body: jsonEncode({
            "model": "google/gemma-2-2b-it",
            "messages": [
              {"role": "user", "content": prompt}
            ],
            "max_tokens": 500,
            "stream": false
          }));
      final response = jsonDecode(res.body);
      String answer = response['choices'][0]['message']['content'];
      answer = answer.replaceAll('*', '');

      return answer;
    } catch (e) {
      return '';
    }
  }

  static void dalle() {}
  static void chatGptText() {}
}
