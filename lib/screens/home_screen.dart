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
  String _selectedLanguage = 'English'; // Langue par défaut

  // Liste des langues disponibles
  final List<String> _languages = [
    'English',
    'French',
    'Spanish',
    'German',
    'Italian'
  ];

  void _translate() async {
    final text = _textController.text;
    if (text.isNotEmpty) {
      final translation =
          await _translationService.translate(text, _selectedLanguage);
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
                hintText: 'Ecris le texte à traduire',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: _languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _translate,
              child: const Text('Traduire'),
            ),
            const SizedBox(height: 16),
            Text('Traduction ($_selectedLanguage): $_translatedText'),
          ],
        ),
      ),
    );
  }
}
