import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_settings.dart';
import '../models/character.dart';
import '../services/data_service.dart';
import '../services/tts_service.dart';
import '../services/character_image_service.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;
  final DataService dataService;

  const CharacterDetailScreen({
    Key? key,
    required this.character,
    required this.dataService,
  }) : super(key: key);

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  final TtsService _ttsService = TtsService();
  final ScrollController _scrollController = ScrollController();
  bool _isPlaying = false;
  double _scrollProgress = 0.0;
  int _minutesLeft = 10;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollProgress);
  }

  void _updateScrollProgress() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      setState(() {
        _scrollProgress = maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;
        _minutesLeft = (10 * (1 - _scrollProgress)).ceil();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _ttsService.dispose();
    super.dispose();
  }

  void _toggleTts(String text, String language) async {
    if (_isPlaying) {
      await _ttsService.stop();
      setState(() => _isPlaying = false);
    } else {
      await _ttsService.speak(text, language: language);
      setState(() => _isPlaying = true);
    }
  }

  void _navigateToNext() {
    final nextCharacter = widget.dataService.getNextCharacter(widget.character.id);
    if (nextCharacter != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CharacterDetailScreen(
            character: nextCharacter,
            dataService: widget.dataService,
          ),
        ),
      );
    } else {
      final settings = Provider.of<AppSettings>(context, listen: false);
      final lang = settings.languageCode;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(lang == 'en' ? 'This is the last character' : 'यह अंतिम पात्र है'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);
    final lang = settings.languageCode;
    final fontSize = settings.fontSizeMultiplier;
    final character = widget.character;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.orange.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          character.name[lang]!,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          if (_scrollProgress > 0)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.schedule, size: 16, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        '$_minutesLeft min',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          IconButton(
            icon: Icon(_isPlaying ? Icons.stop_circle : Icons.play_circle),
            onPressed: () => _toggleTts(character.story[lang]!, lang),
            color: Colors.white,
            iconSize: 32,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: _scrollProgress,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.deepOrange, Colors.orange.shade600],
                ),
              ),
              child: Column(
                children: [
                  CharacterImageService.getCharacterImage(
                    character.name['en']!,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    character.name[lang]!,
                    style: TextStyle(
                      fontSize: 36 * fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time, size: 18, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          lang == 'en' ? '10 min read' : '10 मिनट पढ़ें',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: character.keyTraits[lang]!.split(',').map((trait) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                        ),
                        child: Text(
                          trait.trim(),
                          style: TextStyle(
                            fontSize: 14 * fontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [Colors.amber.shade900, Colors.orange.shade900]
                      : [Colors.amber.shade100, Colors.orange.shade100],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: isDark 
                        ? Colors.black.withOpacity(0.3)
                        : Colors.orange.shade300.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark 
                              ? Colors.amber.shade800.withOpacity(0.3)
                              : Colors.amber.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.lightbulb,
                          color: isDark ? Colors.amber.shade200 : Colors.amber.shade900,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          lang == 'en' ? 'Life Lesson' : 'जीवन का पाठ',
                          style: TextStyle(
                            fontSize: 20 * fontSize,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.amber.shade100 : Colors.orange.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    character.lifeLesson[lang]!,
                    style: TextStyle(
                      fontSize: 17 * fontSize,
                      height: 1.6,
                      color: isDark ? Colors.white : Colors.brown.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_stories,
                        color: isDark ? Colors.orange.shade300 : Colors.deepOrange.shade700,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        lang == 'en' ? 'The Story' : 'कहानी',
                        style: TextStyle(
                          fontSize: 24 * fontSize,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.orange.shade200 : Colors.deepOrange.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark 
                          ? Colors.grey.shade800
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark 
                            ? Colors.orange.shade800
                            : Colors.orange.shade200,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      character.story[lang]!,
                      style: TextStyle(
                        fontSize: 16 * fontSize,
                        color: isDark ? Colors.white : Colors.brown.shade900,
                        height: 1.8,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [Colors.orange.shade900, Colors.deepOrange.shade900]
                      : [Colors.orange.shade100, Colors.amber.shade100],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : Colors.orange.shade300.withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.orange.shade800.withOpacity(0.3)
                              : Colors.orange.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.menu_book,
                          color: isDark ? Colors.orange.shade200 : Colors.orange.shade900,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          lang == 'en' ? 'Sacred Verse' : 'पवित्र श्लोक',
                          style: TextStyle(
                            fontSize: 20 * fontSize,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.orange.shade100 : Colors.orange.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? Colors.orange.shade700
                            : Colors.orange.shade300,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: isDark ? Colors.amber.shade300 : Colors.amber.shade700,
                          size: 32,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          character.shloka.sanskrit,
                          style: TextStyle(
                            fontSize: 18 * fontSize,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.amber.shade100 : Colors.brown.shade900,
                            height: 2.0,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.orange.shade900.withOpacity(0.3)
                                : Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            character.shloka.transliteration,
                            style: TextStyle(
                              fontSize: 14 * fontSize,
                              color: isDark ? Colors.orange.shade200 : Colors.brown.shade700,
                              fontStyle: FontStyle.italic,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.translate,
                        color: isDark ? Colors.orange.shade300 : Colors.orange.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        lang == 'en' ? 'Meaning:' : 'अर्थ:',
                        style: TextStyle(
                          fontSize: 16 * fontSize,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.orange.shade200 : Colors.orange.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    character.shloka.meaning[lang]!,
                    style: TextStyle(
                      fontSize: 16 * fontSize,
                      color: isDark ? Colors.white : Colors.brown.shade800,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.book,
                        size: 16,
                        color: isDark ? Colors.orange.shade400 : Colors.orange.shade700,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '— ${character.shloka.reference}',
                        style: TextStyle(
                          fontSize: 14 * fontSize,
                          color: isDark ? Colors.orange.shade300 : Colors.orange.shade700,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _navigateToNext,
                  icon: const Icon(Icons.arrow_forward, size: 24),
                  label: Text(
                    lang == 'en' ? 'Read Next Character' : 'अगला पात्र पढ़ें',
                    style: TextStyle(
                      fontSize: 18 * fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}