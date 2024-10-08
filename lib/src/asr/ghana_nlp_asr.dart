import 'dart:typed_data';

import 'package:http/http.dart' as http;

class GhanaNlpAsr {
  String baseUrl = 'https://translation-api.ghananlp.org/asr/v2';
  final String apiKey;
  final http.Client client;

  GhanaNlpAsr({required this.apiKey, http.Client? client})
      : client = client ?? http.Client();

  Future<String> transcribe(Uint8List audioData, String language) async {
    if (!_isValidLanguage(language)) {
      throw ArgumentError(
          'Invalid language code. Supported codes are: tw, yo, gaa, dag, ee, ki');
    }

    final url = Uri.parse('$baseUrl/transcribe?language=$language');

    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'audio/mpeg',
          'Ocp-Apim-Subscription-Key': apiKey,
        },
        body: audioData,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to transcribe audio: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during transcription: $e');
    }
  }

  bool _isValidLanguage(String language) {
    return ['tw', 'yo', 'gaa', 'dag', 'ee', 'ki'].contains(language);
  }
}
