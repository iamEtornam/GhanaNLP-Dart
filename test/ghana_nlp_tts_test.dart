// File: test/ghana_nlp_dart_test.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:ghana_npl_dart/ghana_npl_dart.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('GhanaNlpTts', () {
    late GhanaNlpTts ghanaNlpTts;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      ghanaNlpTts = GhanaNlpTts(apiKey: 'test_api_key', client: mockClient);
    });

    test(
        'synthesize should send correct request and return audio data on successful API call',
        () async {
      final audioBytes = Uint8List.fromList([1, 2, 3, 4, 5]);
      when(mockClient.post(
        Uri.parse('https://translation-api.ghananlp.org/tts/v1/tts'),
        headers: {
          'Content-Type': 'application/json',
          'Ocp-Apim-Subscription-Key': 'test_api_key',
        },
        body: jsonEncode({
          'text': 'Ɛte sɛn?',
          'language': 'tw',
        }),
      )).thenAnswer((_) async => http.Response.bytes(audioBytes, 200));

      final result = await ghanaNlpTts.synthesize('Ɛte sɛn?', 'tw');
      expect(result, equals(audioBytes));
    });

    test('synthesize should throw exception on API error', () async {
      when(mockClient.post(
        Uri.parse(''),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Error', 400));

      expect(
        () => ghanaNlpTts.synthesize('Ɛte sɛn?', 'tw'),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ... (Language tests remain the same)
}
