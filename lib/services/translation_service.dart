import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class TranslationService {
  final String _baseUrl = 'https://api.groq.com/openai/v1/chat/completions';
  final String _apiKey =
      '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';
  final Logger _logger = Logger();

  Future<String> translate(String text, String targetLanguage) async {
    try {
      _logger.i(
          'Début de la traduction. Texte: $text, Langue cible: $targetLanguage');

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "mixtral-8x7b-32768",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a translator. Translate the user's text to $targetLanguage."
            },
            {"role": "user", "content": text}
          ],
          "temperature": 0.7,
          "max_tokens": 1000,
        }),
      );

      _logger.d('Réponse reçue. Status code: ${response.statusCode}');
      _logger.d('Corps de la réponse: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final translation = jsonResponse['choices'][0]['message']['content'];
        _logger.i('Traduction réussie: $translation');
        return translation;
      } else {
        _logger.e('Erreur API: ${response.statusCode} ${response.body}');
        throw Exception('Échec de la traduction: ${response.body}');
      }
    } catch (e, stackTrace) {
      _logger
          .e('Exception lors de la traduction: $e\nStack trace: $stackTrace');
      return 'Erreur de traduction: $e';
    }
  }
}
