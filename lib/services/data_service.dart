import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character.dart';

class DataService {
  List<Character> _characters = [];
  List<Quote> _quotes = [];
  
  List<Character> get characters => _characters;
  List<Quote> get quotes => _quotes;

  Future<void> loadData() async {
    final String response = await rootBundle.loadString('assets/data/mahabharata_characters.json');
    final data = json.decode(response);
    
    _characters = (data['characters'] as List)
        .map((json) => Character.fromJson(json))
        .toList();
    
    _quotes = (data['quotes'] as List)
        .map((json) => Quote.fromJson(json))
        .toList();
  }

  Character getCharacterOfDay() {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    final index = dayOfYear % _characters.length;
    return _characters[index];
  }

  Character? getNextCharacter(int currentId) {
    final currentIndex = _characters.indexWhere((c) => c.id == currentId);
    if (currentIndex == -1 || currentIndex >= _characters.length - 1) {
      return null;
    }
    return _characters[currentIndex + 1];
  }

  Future<Quote?> getQuoteOfDay() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final currentMonth = '${now.year}-${now.month}';
    
    final shownQuotesJson = prefs.getString('shown_quotes_$currentMonth');
    Set<int> shownQuotes = {};
    if (shownQuotesJson != null) {
      shownQuotes = Set<int>.from(json.decode(shownQuotesJson));
    }
    
    if (shownQuotes.length >= _quotes.length) {
      shownQuotes.clear();
    }
    
    final availableQuotes = _quotes.where((q) => !shownQuotes.contains(q.id)).toList();
    
    if (availableQuotes.isEmpty) {
      return null;
    }
    
    final lastQuoteDate = prefs.getString('last_quote_date');
    final today = '${now.year}-${now.month}-${now.day}';
    
    if (lastQuoteDate == today) {
      final lastQuoteId = prefs.getInt('last_quote_id');
      if (lastQuoteId != null) {
        return _quotes.firstWhere((q) => q.id == lastQuoteId);
      }
    }
    
    availableQuotes.shuffle();
    final selectedQuote = availableQuotes.first;
    
    shownQuotes.add(selectedQuote.id);
    await prefs.setString('shown_quotes_$currentMonth', json.encode(shownQuotes.toList()));
    await prefs.setString('last_quote_date', today);
    await prefs.setInt('last_quote_id', selectedQuote.id);
    
    return selectedQuote;
  }
}
