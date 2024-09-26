import 'package:http/http.dart' as http;
import 'dart:convert';

class TranslationService {
  final String _baseUrl = 'https://api.groq.com/v1/translate';
  final String _apiKey = 'VOTRE_CLE_API_GROQ';

  Future<String> translate(String text) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'text': text,
          'source_lang': 'auto',
          'target_lang': 'fr', // Changez ceci selon vos besoins
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['translated_text'];
      } else {
        throw Exception('Échec de la traduction');
      }
    } catch (e) {
      return 'Erreur de traduction';
    }
  }
}
