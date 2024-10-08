import 'dart:io';

import 'package:ghana_npl_dart/ghana_npl_dart.dart';

final apiKey = 'your_api_key_here';

void main() async {
  ghanaNLPAsr();
  ghanaNLPTextToSpeech();
  ghanaNLPTranslation();
}

  /// Example of using the GhanaNLP ASR API to transcribe an audio file.
  ///
  /// Replace `'path_to_your_audio_file.mp3'` with the path to an audio file on
  /// your local machine.
  ///
  /// This example transcribes the audio file using the Twi language.
void ghanaNLPAsr() async {
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

  /// Example of using the GhanaNLP TTS API to synthesize speech from a given
  /// text string.
  ///
  /// This example synthesizes the text "Ɛte sɛn?" in the Twi language and saves
  /// the audio to a file named "output.mp3".
void ghanaNLPTextToSpeech() async {
  final ghanaNlpTts = GhanaNlpTts(apiKey: apiKey);

  try {
    final audioBytes =
        await ghanaNlpTts.synthesize('Ɛte sɛn?', Language.twi.code);
    await File('output.mp3').writeAsBytes(audioBytes);
    print('Audio saved to output.mp3');
  } catch (e) {
    print('Error: $e');
  }
}

  /// Example of using the GhanaNLP Translation API to translate text and
  /// retrieve supported languages.
  ///
  /// This example translates the text "Hello, how are you?" from English to Twi,
  /// and prints the supported languages.
void ghanaNLPTranslation() async {
  final api = GhanaNLPTranslation(apiKey: apiKey);

  // Translate text
  try {
    final translatedText = await api.translate(
      text: 'Hello, how are you?',
      languagePair: 'en-tw',
    );
    print('Translated text: $translatedText');
  } catch (e) {
    print('Translation error: $e');
  }

  // Get supported languages
  try {
    final languages = await api.getLanguages();
    print('Supported languages: $languages');
  } catch (e) {
    print('Error fetching languages: $e');
  }
}
