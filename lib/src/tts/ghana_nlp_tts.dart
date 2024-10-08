// File: lib/src/tts/ghana_nlp_tts.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class GhanaNlpTts {
  final String baseUrl = 'https://translation-api.ghananlp.org/tts/v1';
  final String apiKey;
  final http.Client client;

  GhanaNlpTts({required this.apiKey, http.Client? client})
      : client = client ?? http.Client();

  Future<List<int>> synthesize(String text, String language) async {
    final url = Uri.parse('$baseUrl/tts');

    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Ocp-Apim-Subscription-Key': apiKey,
        },
        body: jsonEncode({
          'text': text,
          'language': language,
        }),
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Failed to synthesize speech: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during speech synthesis: $e');
    }
  }
}
