import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final List<Map<String, String>> languages = [
    {'name': 'English', 'flag': '🇬🇧'},
    {'name': 'French', 'flag': '🇫🇷'},
    {'name': 'Spanish', 'flag': '🇪🇸'},
    {'name': 'German', 'flag': '🇩🇪'},
    {'name': 'Italian', 'flag': '🇮🇹'},
  ];

  LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text(
                languages[index]['flag']!,
                style: const TextStyle(fontSize: 30),
              ),
              title: Text(languages[index]['name']!),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                  arguments: languages[index]['name'],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
