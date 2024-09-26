class Translation {
  final String originalText;
  final String translatedText;
  final DateTime timestamp;

  Translation({
    required this.originalText,
    required this.translatedText,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'originalText': originalText,
      'translatedText': translatedText,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      originalText: json['originalText'],
      translatedText: json['translatedText'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
