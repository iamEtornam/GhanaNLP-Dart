import 'dart:typed_data';

import 'package:ghana_npl_dart/ghana_npl_dart.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('GhanaNlpAsr', () {
    late GhanaNlpAsr ghanaNlpAsr;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      ghanaNlpAsr = GhanaNlpAsr(apiKey: 'test_api_key', client: mockClient);
      ghanaNlpAsr.baseUrl = 'http://example.com/asr/v2';
    });

    test('transcribe should return transcription on successful API call',
        () async {
      when(mockClient.post(
        Uri.parse('${ghanaNlpAsr.baseUrl}/transcribe?language=tw'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Transcription result', 200));

      final result =
          await ghanaNlpAsr.transcribe(Uint8List(0), Language.twi.code);
      expect(result, equals('Transcription result'));

      verify(mockClient.post(
        Uri.parse('${ghanaNlpAsr.baseUrl}/transcribe?language=tw'),
        headers: {
          'Content-Type': 'audio/mpeg',
          'Ocp-Apim-Subscription-Key': 'test_api_key',
        },
        body: any,
      )).called(1);
    });

    test('transcribe should throw exception on API error', () async {
      when(mockClient.post(
        Uri.parse('${ghanaNlpAsr.baseUrl}/transcribe?language=tw'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Error', 400));

      expect(
        () => ghanaNlpAsr.transcribe(Uint8List(0), Language.twi.code),
        throwsA(isA<Exception>()),
      );
    });

    test('transcribe should throw ArgumentError for invalid language', () {
      expect(
        () => ghanaNlpAsr.transcribe(Uint8List(0), 'invalid_language'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Language', () {
    test('fromCode should return correct Language enum', () {
      expect(Language.fromCode('tw'), equals(Language.twi));
      expect(Language.fromCode('yo'), equals(Language.yoruba));
      expect(Language.fromCode('gaa'), equals(Language.ga));
      expect(Language.fromCode('dag'), equals(Language.dagbani));
      expect(Language.fromCode('ee'), equals(Language.ewe));
      expect(Language.fromCode('ki'), equals(Language.kikuyu));
    });

    test('fromCode should throw ArgumentError for invalid code', () {
      expect(
        () => Language.fromCode('invalid'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
