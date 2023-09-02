import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech/flutter_speech.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(Speech_to_text());
}

const languages = const [
  const Language('English', 'en_US'),
  const Language('Francais', 'fr_FR'),
  const Language('Pусский', 'ru_RU'),
  const Language('Italiano', 'it_IT'),
  const Language('Español', 'es_ES'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class Speech_to_text extends StatefulWidget {
  @override
  _Speech_to_textState createState() => _Speech_to_textState();
}

class _Speech_to_textState extends State<Speech_to_text> {
  late SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    print('_Speech_to_textState.activateSpeechRecognizer... ');
    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.setErrorHandler(errorHandler);
    _speech.activate('en_US').then((res) {
      setState(() => _speechRecognitionAvailable = res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Speech To Text'),
      ),
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.grey.shade200,
                        child: Text(
                          transcription,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ))),
                _buildButton(
                  onPressed: _speechRecognitionAvailable && !_isListening
                      ? () => start()
                      : null,
                  label: _isListening ? 'Listening...' : 'Speak',
                ),
                _buildButton(
                  onPressed: _isListening ? () => cancel() : null,
                  label: 'Cancel',
                ),
                _buildButton(
                  onPressed: _isListening ? () => stop() : null,
                  label: 'Stop',
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildButton({required String label, VoidCallback? onPressed}) =>
      Padding(
          padding: EdgeInsets.all(12.0),
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ));

  void start() => _speech.activate(selectedLang.code).then((_) {
        return _speech.listen().then((result) {
          print('_Speech_to_textState.start => result $result');
          setState(() {
            _isListening = result;
          });
        });
      });

  void cancel() =>
      _speech.cancel().then((_) => setState(() => _isListening = false));

  void stop() => _speech.stop().then((_) {
        setState(() => _isListening = false);
      });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) {
    print('_Speech_to_textState.onCurrentLocale... $locale');
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionStarted() {
    setState(() => _isListening = true);
  }

  void onRecognitionResult(String text) {
    print('_Speech_to_textState.onRecognitionResult... $text');
    setState(() => transcription = text);
  }

  void onRecognitionComplete(String text) {
    print('_Speech_to_textState.onRecognitionComplete... $text');
    setState(() => _isListening = false);
  }

  void errorHandler() => activateSpeechRecognizer();
}
