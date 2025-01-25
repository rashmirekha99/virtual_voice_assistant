import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_assistant/core/api/apis.dart';
import 'package:voice_assistant/core/secrets.dart';

class TextGenerationServices {
  static Future<String> textGeneration(String prompt) async {
    try {
      final res = await http.post(Uri.parse(APIS.googleAiAPI),
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

  

  
}
