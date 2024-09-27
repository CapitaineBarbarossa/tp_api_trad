import 'package:flutter/material.dart';
import '../services/translation_service.dart';
import '../services/correction_service.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TranslationService _translationService = TranslationService();
  final CorrectionService _correctionService = CorrectionService();
  final TextEditingController _translationController = TextEditingController();
  final TextEditingController _correctionController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  String _translatedText = '';
  String _correctedText = '';
  late String _selectedLanguage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initTts();
    });
  }

  void _initTts() async {
    await flutterTts.setLanguage(_getLanguageCode(_selectedLanguage));
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
  }

  String _getLanguageCode(String language) {
    switch (language) {
      case 'French':
        return 'fr-FR';
      case 'Spanish':
        return 'es-ES';
      case 'German':
        return 'de-DE';
      case 'Italian':
        return 'it-IT';
      default:
        return 'en-US';
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage(_getLanguageCode(_selectedLanguage));
    await flutterTts.speak(text);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      _selectedLanguage = args;
      _initTts();
    } else {
      _selectedLanguage =
          'English'; // Default language if no argument is passed
    }
  }

  void _translate() async {
    final text = _translationController.text;
    if (text.isNotEmpty) {
      setState(() => _isLoading = true);
      try {
        final translation =
            await _translationService.translate(text, _selectedLanguage);
        setState(() {
          _translatedText = translation;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Translation error: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _correctText() async {
    final text = _correctionController.text;
    if (text.isNotEmpty) {
      setState(() => _isLoading = true);
      try {
        final correctedText =
            await _correctionService.correctText(text, _selectedLanguage);
        setState(() {
          _correctedText = correctedText;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Correction error: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate & Correct to $_selectedLanguage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Translation', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            TextField(
              controller: _translationController,
              decoration: const InputDecoration(
                hintText: 'Write the text to translate',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _translate,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Translate'),
            ),
            const SizedBox(height: 16),
            Text('Translation result:',
                style: Theme.of(context).textTheme.titleMedium),
            Text(_translatedText),
            ElevatedButton(
              onPressed: _translatedText.isNotEmpty
                  ? () => _speak(_translatedText)
                  : null,
              child: const Text('Listen to translation'),
            ),
            const SizedBox(height: 32),
            Text('Correction', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            TextField(
              controller: _correctionController,
              decoration: const InputDecoration(
                hintText: 'Write the text to correct',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _correctText,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Correct'),
            ),
            const SizedBox(height: 16),
            Text('Correction result:',
                style: Theme.of(context).textTheme.titleMedium),
            Text(_correctedText),
            ElevatedButton(
              onPressed: _correctedText.isNotEmpty
                  ? () => _speak(_correctedText)
                  : null,
              child: const Text('Listen to correction'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    _translationController.dispose();
    _correctionController.dispose();
    super.dispose();
  }
}
