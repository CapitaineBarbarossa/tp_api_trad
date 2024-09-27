import 'package:flutter/material.dart';
import '../services/translation_service.dart';
import '../services/correction_service.dart';

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
  String _translatedText = '';
  String _correctedText = '';
  late String _selectedLanguage; // Default language
  bool _isLoading = false;

  final List<String> _languages = [
    'English',
    'French',
    'Spanish',
    'German',
    'Italian'
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLanguage =
        ModalRoute.of(context)!.settings.arguments as String? ?? 'English';
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
        title: const Text('Translate & Correct App'),
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
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedLanguage,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLanguage = newValue!;
                      });
                    },
                    items: _languages
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isLoading ? null : _translate,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Translate'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Translation result:',
                style: Theme.of(context).textTheme.titleMedium),
            Text(_translatedText),
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _translationController.dispose();
    _correctionController.dispose();
    super.dispose();
  }
}
