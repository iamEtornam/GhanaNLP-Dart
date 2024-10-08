# GhanaNLP Dart Package

This Dart package provides a client for the GhanaNLP API, including Automatic Speech Recognition (ASR) and Text-To-Speech (TTS) functionalities. It allows you to easily transcribe audio and synthesize speech in various Ghanaian and African languages.

## Supported Languages

- Twi (tw)
- Yoruba (yo)
- Ga (gaa)
- Dagbani (dag)
- Ewe (ee)
- Kikuyu (ki)

## Installation

Add this package to your project's `pubspec.yaml` file:

```yaml
dependencies:
  ghana_nlp_dart:
    git:
      url: https://github.com/yourusername/ghana_nlp_dart.git
      ref: main  # or use a specific tag/commit
```

Then run:

```
dart pub get
```

## Usage

Here are basic examples of how to use the GhanaNLP Dart package:

### Automatic Speech Recognition (ASR)

```dart
import 'dart:io';
import 'package:ghana_nlp_dart/ghana_nlp_dart.dart';

void main() async {
  final apiKey = 'your_api_key_here';
  final ghanaNlpAsr = GhanaNlpAsr(apiKey: apiKey);

  // Read audio file
  final file = File('path_to_your_audio_file.mp3');
  final audioBytes = await file.readAsBytes();

  try {
    final transcription = await ghanaNlpAsr.transcribe(audioBytes, Language.twi.code);
    print('Transcription: $transcription');
  } catch (e) {
    print('Error: $e');
  }
}
```

### Text-To-Speech (TTS)

```dart
import 'dart:io';
import 'package:ghana_nlp_dart/ghana_nlp_dart.dart';

void main() async {
  final apiKey = 'your_api_key_here';
  final ghanaNlpTts = GhanaNlpTts(apiKey: apiKey);

  try {
    final audioBytes = await ghanaNlpTts.synthesize('Ɛte sɛn?', Language.twi.code);
    await File('output.mp3').writeAsBytes(audioBytes);
    print('Audio saved to output.mp3');
  } catch (e) {
    print('Error: $e');
  }
}
```

## API Reference

### `GhanaNlpAsr`

The class for interacting with the GhanaNLP ASR API.

#### Constructor

```dart
GhanaNlpAsr({required String apiKey, http.Client? client})
```

#### Methods

```dart
Future<String> transcribe(Uint8List audioData, String language)
```

### `GhanaNlpTts`

The class for interacting with the GhanaNLP TTS API.

#### Constructor

```dart
GhanaNlpTts({required String apiKey, http.Client? client})
```

#### Methods

```dart
Future<List<int>> synthesize(String text, String language)
```

Synthesizes speech from the given text in the specified language.

- `text`: The text to be converted to speech.
- `language`: The language code (e.g., 'tw' for Twi).

Returns a `Future<List<int>>` containing the audio data as bytes.

### `Language`

An enum representing the supported languages.

```dart
enum Language {
  twi('tw'),
  yoruba('yo'),
  ga('gaa'),
  dagbani('dag'),
  ewe('ee'),
  kikuyu('ki')
}
```

Use `Language.fromCode(String code)` to get the enum value from a language code string.

## Error Handling

The package throws exceptions in the following cases:

- `ArgumentError`: If an invalid language code is provided.
- `Exception`: If there's an error during the API call or if the API returns a non-200 status code.

Make sure to wrap your API calls in a try-catch block to handle these exceptions.

## Authentication

This package uses API key authentication. You need to provide your API key when initializing the `GhanaNlpAsr` or `GhanaNlpTts` classes. The API key is sent in the `Ocp-Apim-Subscription-Key` header for each request.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.