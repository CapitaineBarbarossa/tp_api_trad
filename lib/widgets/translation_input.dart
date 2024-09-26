import 'package:flutter/material.dart';

class TranslationInput extends StatefulWidget {
  final Function(String, String) onTranslate;
  final Future<String> Function(String, String) onCorrect;

  const TranslationInput({
    super.key, 
    required this.onTranslate, 
    required this.onCorrect
  });

  @override
  TranslationInputState createState() => TranslationInputState();
}

class TranslationInputState extends State<TranslationInput> {
  final TextEditingController _controller = TextEditingController();
  String _selectedLanguage = 'French';
  bool _isLoading = false;

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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _correctText,
              child: _isLoading 
                ? const SizedBox(
                    width: 20, 
                    height: 20, 
                    child: CircularProgressIndicator(strokeWidth: 2)
                  ) 
                : const Text('Corriger'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _translate,
              child: const Text('Traduire'),
            ),
          ],
        ),
      ],
    );
  }

  void _translate() {
    if (_controller.text.isNotEmpty) {
      widget.onTranslate(_controller.text, _selectedLanguage);
    }
  }

  void _correctText() async {
    if (_controller.text.isNotEmpty) {
      setState(() => _isLoading = true);
      try {
        final correctedText = await widget.onCorrect(_controller.text, _selectedLanguage);
        setState(() {
          _controller.text = correctedText;
        });
      } catch (e) {
        // Handle error (e.g., show a snackbar with the error message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Correction error: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}