import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/translation.dart';

class StorageService {
  static const String _key = 'translation_history';

  Future<void> saveTranslation(Translation translation) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_key) ?? [];
    history.add(jsonEncode(translation.toJson()));
    await prefs.setStringList(_key, history);
  }

  Future<List<Translation>> getTranslationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_key) ?? [];
    return history
        .map((item) => Translation.fromJson(jsonDecode(item)))
        .toList();
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
