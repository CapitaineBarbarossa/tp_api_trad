import 'package:flutter/material.dart';
import '../services/translation_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TranslationService _translationService = TranslationService();
  final TextEditingController _textController = TextEditingController();
  String _translatedText = '';

  void _translate() async {
    final text = _textController.text;
    if (text.isNotEmpty) {
      final translation = await _translationService.translate(
          text, 'French'); // Vous pouvez changer 'French' selon vos besoins
      setState(() {
        _translatedText = translation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translate App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Enter text to translate',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _translate,
              child: const Text('Translate'),
            ),
            const SizedBox(height: 16),
            Text('Translated text: $_translatedText'),
          ],
        ),
      ),
    );
  }
}
