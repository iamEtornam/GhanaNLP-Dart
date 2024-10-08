// File: test/ghananlp_translation_api_test.dart

import 'package:ghana_npl_dart/ghana_npl_dart.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('GhanaNLPTranslation', () {
    late GhanaNLPTranslation api;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      api = GhanaNLPTranslation(apiKey: 'test_api_key');
    });

    test('translate success', () async {
      when(mockClient.post(Uri.parse(''),
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Translated text', 200));

      final result = await api.translate(text: 'Hello', languagePair: 'en-tw');
      expect(result, 'Translated text');
    });

    test('translate failure', () async {
      when(mockClient.post(Uri.parse(''),
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async =>
              http.Response('{"type":"Error","message":"Bad Request"}', 400));

      expect(() => api.translate(text: 'Hello', languagePair: 'en-tw'),
          throwsA(isA<Exception>()));
    });

    test('getLanguages success', () async {
      when(mockClient.get(Uri.parse(''), headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response('{"en":"English","tw":"Twi"}', 200));

      final result = await api.getLanguages();
      expect(result, {'en': 'English', 'tw': 'Twi'});
    });

    test('getLanguages failure', () async {
      when(mockClient.get(Uri.parse(''), headers: anyNamed('headers'))).thenAnswer(
          (_) async =>
              http.Response('{"type":"Error","message":"Unauthorized"}', 401));

      expect(() => api.getLanguages(), throwsA(isA<Exception>()));
    });
  });
}
