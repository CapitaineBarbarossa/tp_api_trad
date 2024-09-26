import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TranslationResult extends StatelessWidget {
  final String translatedText;

  const TranslationResult({super.key, required this.translatedText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Traduction :',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(translatedText),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: translatedText));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Texte copié dans le presse-papiers')),
            );
          },
          icon: const Icon(Icons.copy),
          label: const Text('Copier'),
        ),
      ],
    );
  }
}
