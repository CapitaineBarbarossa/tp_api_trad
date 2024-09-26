import 'package:flutter/material.dart';
import '../widgets/translation_input.dart';
import '../widgets/translation_result.dart';
import '../services/translation_service.dart';
import '../services/storage_service.dart';
import '../models/translation.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _translatedText = '';
  final TranslationService _translationService = TranslationService();
  final StorageService _storageService = StorageService();

  void _handleTranslation(String text, String targetLanguage) async {
    final result = await _translationService.translate(text, targetLanguage);
    setState(() {
      _translatedText = result;
    });

    // Sauvegarder la traduction dans l'historique
    final translation = Translation(
      originalText: text,
      translatedText: result,
      timestamp: DateTime.now(),
    );
    await _storageService.saveTranslation(translation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translate App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TranslationInput(onTranslate: _handleTranslation),
            const SizedBox(height: 20),
            TranslationResult(translatedText: _translatedText),
          ],
        ),
      ),
    );
  }
}
