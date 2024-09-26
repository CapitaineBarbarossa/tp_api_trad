import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

  // final String _baseUrl = 'https://api.languagetoolplus.com/v2/check';
class CorrectionService {
  final String _baseUrl = 'https://api.groq.com/openai/v1/chat/completions';
  final String _apiKey =
      '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';
  final Logger _logger = Logger();

  Future<String> correctText(String text, String language) async {
    try {
      _logger.i('Starting text correction. Text: $text, Language: $language');

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'mixtral-8x7b-32768',  // or another model supported by Groq
          'messages': [
            {
              'role': 'system',
              'content': 'You are a helpful assistant that corrects grammar and spelling errors.'
            },
            {
              'role': 'user',
              'content': 'Please correct any errors in the following text: $text, and list the corrected words'
            }
          ],
          'temperature': 0.3,
          'max_tokens': 1000,
        }),
      );

      _logger.d('Response received. Status code: ${response.statusCode}');
      _logger.d('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final correctedText = jsonResponse['choices'][0]['message']['content'];

        _logger.i('Text correction successful: $correctedText');
        return correctedText;
      } else {
        _logger.e('API Error: ${response.statusCode} ${response.body}');
        throw Exception('Failed to correct text: ${response.body}');
      }
    } catch (e, stackTrace) {
      _logger.e('Exception during text correction: $e\nStack trace: $stackTrace');
      return 'Error correcting text: $e';
    }
  }

  String _getLanguageCode(String language) {
    switch (language.toLowerCase()) {
      case 'english':
        return 'en-US';
      case 'french':
        return 'fr';
      case 'spanish':
        return 'es';
      case 'german':
        return 'de';
      case 'italian':
        return 'it';
      default:
        return 'en-US';
    }
  }
}