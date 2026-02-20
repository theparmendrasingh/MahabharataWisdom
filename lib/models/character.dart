class Character {
  final int id;
  final Map<String, String> name;
  final Map<String, String> keyTraits;
  final Map<String, String> lifeLesson;
  final Map<String, String> story;
  final Shloka shloka;

  Character({
    required this.id,
    required this.name,
    required this.keyTraits,
    required this.lifeLesson,
    required this.story,
    required this.shloka,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: Map<String, String>.from(json['name']),
      keyTraits: Map<String, String>.from(json['key_traits']),
      lifeLesson: Map<String, String>.from(json['life_lesson']),
      story: Map<String, String>.from(json['story']),
      shloka: Shloka.fromJson(json['shloka']),
    );
  }
}

class Shloka {
  final String sanskrit;
  final String transliteration;
  final Map<String, String> meaning;
  final String reference;

  Shloka({
    required this.sanskrit,
    required this.transliteration,
    required this.meaning,
    required this.reference,
  });

  factory Shloka.fromJson(Map<String, dynamic> json) {
    return Shloka(
      sanskrit: json['sanskrit'],
      transliteration: json['transliteration'],
      meaning: Map<String, String>.from(json['meaning']),
      reference: json['reference'],
    );
  }
}

class Quote {
  final int id;
  final String sanskrit;
  final String transliteration;
  final Map<String, String> meaning;
  final String reference;
  final String category;

  Quote({
    required this.id,
    required this.sanskrit,
    required this.transliteration,
    required this.meaning,
    required this.reference,
    required this.category,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      sanskrit: json['sanskrit'],
      transliteration: json['transliteration'],
      meaning: Map<String, String>.from(json['meaning']),
      reference: json['reference'],
      category: json['category'],
    );
  }
}
