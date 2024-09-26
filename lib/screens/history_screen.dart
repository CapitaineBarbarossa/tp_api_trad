import 'package:flutter/material.dart';
import '../models/translation.dart';
import '../services/storage_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  final StorageService _storageService = StorageService();
  List<Translation> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() async {
    final history = await _storageService.getTranslationHistory();
    setState(() {
      _history = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des traductions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _storageService.clearHistory();
              _loadHistory();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _history.length,
        itemBuilder: (context, index) {
          final translation = _history[index];
          return ListTile(
            title: Text(translation.originalText),
            subtitle: Text(translation.translatedText),
            trailing: Text(
              '${translation.timestamp.day}/${translation.timestamp.month}/${translation.timestamp.year}',
            ),
          );
        },
      ),
    );
  }
}
