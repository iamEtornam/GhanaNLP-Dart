// File: lib/ghananlp_translation_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class GhanaNLPTranslation {
  final String apiKey;
  final String baseUrl;

  GhanaNLPTranslation(
      {required this.apiKey,
      this.baseUrl = 'https://translation-api.ghananlp.org/v1'});

  Future<String> translate(
      {required String text, required String languagePair}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/translate'),
      headers: {
        'Content-Type': 'application/json',
        'Ocp-Apim-Subscription-Key': apiKey,
      },
      body: jsonEncode({
        'in': text,
        'lang': languagePair,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      final error = jsonDecode(response.body);
      throw Exception('${error['type']}: ${error['message']}');
    }
  }

  Future<Map<String, String>> getLanguages() async {
    final response = await http.get(
      Uri.parse('$baseUrl/languages'),
      headers: {
        'Ocp-Apim-Subscription-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return Map<String, String>.from(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception('${error['type']}: ${error['message']}');
    }
  }
}
