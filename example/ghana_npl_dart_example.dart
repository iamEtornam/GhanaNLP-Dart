import 'dart:io';

import 'package:ghana_npl_dart/ghana_npl_dart.dart';

void main() async {
  final apiKey = 'your_api_key_here';
  final ghanaNlpAsr = GhanaNlpAsr(apiKey: apiKey);

  // Read audio file
  final file = File('path_to_your_audio_file.mp3');
  final audioBytes = await file.readAsBytes();

  try {
    final transcription =
        await ghanaNlpAsr.transcribe(audioBytes, Language.twi.code);
    print('Transcription: $transcription');
  } catch (e) {
    print('Error: $e');
  }
}
