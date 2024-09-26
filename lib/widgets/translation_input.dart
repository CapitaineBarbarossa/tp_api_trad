import 'package:flutter/material.dart';

class TranslationInput extends StatefulWidget {
  final Function(String) onTranslate;

  const TranslationInput({super.key, required this.onTranslate});

  @override
  TranslationInputState createState() => TranslationInputState();
}

class TranslationInputState extends State<TranslationInput> {
  final TextEditingController _controller = TextEditingController();

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
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onTranslate(_controller.text);
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
