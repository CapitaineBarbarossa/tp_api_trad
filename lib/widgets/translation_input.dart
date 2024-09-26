import 'package:flutter/material.dart';

class TranslationInput extends StatefulWidget {
  final Function(String, String) onTranslate;

  const TranslationInput({super.key, required this.onTranslate});

  @override
  TranslationInputState createState() => TranslationInputState();
}

class TranslationInputState extends State<TranslationInput> {
  final TextEditingController _controller = TextEditingController();
  String _selectedLanguage = 'French';

  final List<String> _languages = [
    'French',
    'Spanish',
    'German',
    'Italian',
    'Portuguese'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Entrez le texte à traduire',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onTranslate(_controller.text, _selectedLanguage);
            }
          },
          child: const Text('Traduire'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
