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
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "model": "mixtral-8x7b-32768",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a translator. Translate the following text to $targetLanguage. Do not add any explanations or additional content. Translate word-for-word if necessary."
            },
            {"role": "user", "content": text}
          ],
          "temperature": 0.1,
          "max_tokens": 1000,
        }),
      );

      _logger.d('Réponse reçue. Status code: ${response.statusCode}');
      _logger.d('Corps de la réponse: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        String translation =
            jsonResponse['choices'][0]['message']['content'].trim();

        // Vérification côté client
        translation = _verifyTranslation(text, translation, targetLanguage);

        _logger.i('Traduction vérifiée: $translation');
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

  String _verifyTranslation(
      String original, String translation, String targetLanguage) {
    // Vérifier si la traduction est significativement plus longue que l'original
    if (translation.length > original.length * 2) {
      return 'Erreur : La traduction semble contenir du contenu supplémentaire.';
    }

    // Vérifier si la traduction contient des mots-clés spécifiques à une recette
    List<String> recipeKeywords = [
      'ingrédients',
      'préparation',
      'cuisson',
      'recette',
      'mélanger',
      'four'
    ];
    for (var keyword in recipeKeywords) {
      if (translation.toLowerCase().contains(keyword)) {
        return 'Erreur : La traduction semble contenir des instructions de recette.';
      }
    }

    // Vérifier si la traduction contient le texte original
    if (translation.toLowerCase().contains(original.toLowerCase())) {
      return 'Erreur : La traduction semble contenir le texte original.';
    }

    // Si toutes les vérifications passent, retourner la traduction
    return translation;
  }
}
