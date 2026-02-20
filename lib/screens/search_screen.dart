import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/app_settings.dart';
import '../models/character.dart';
import '../services/data_service.dart';
import '../services/character_image_service.dart';
import 'character_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final DataService dataService;

  const SearchScreen({Key? key, required this.dataService}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Character> _filteredCharacters = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredCharacters = widget.dataService.characters;
  }

  void _filterCharacters(String query) {
    final settings = Provider.of<AppSettings>(context, listen: false);
    final lang = settings.languageCode;

    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredCharacters = widget.dataService.characters;
      } else {
        _filteredCharacters = widget.dataService.characters.where((character) {
          final name = character.name[lang]!.toLowerCase();
          final traits = character.keyTraits[lang]!.toLowerCase();
          final lesson = character.lifeLesson[lang]!.toLowerCase();
          final searchLower = query.toLowerCase();

          return name.contains(searchLower) ||
              traits.contains(searchLower) ||
              lesson.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);
    final lang = settings.languageCode;
    final fontSize = settings.fontSizeMultiplier;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.orange.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: lang == 'en' ? 'Search characters...' : 'पात्र खोजें...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      _searchController.clear();
                      _filterCharacters('');
                    },
                  )
                : null,
          ),
          onChanged: _filterCharacters,
        ),
      ),
      body: _filteredCharacters.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    lang == 'en'
                        ? 'No characters found'
                        : 'कोई पात्र नहीं मिला',
                    style: TextStyle(
                      fontSize: 18 * fontSize,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredCharacters.length,
              itemBuilder: (context, index) {
                final character = _filteredCharacters[index];
                return _buildCharacterTile(character, lang, fontSize, isDark)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: (50 * index).ms)
                    .slideX(begin: -0.1, end: 0);
              },
            ),
    );
  }

  Widget _buildCharacterTile(
      Character character, String lang, double fontSize, bool isDark) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CharacterDetailScreen(
                character: character,
                dataService: widget.dataService,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: isDark
                  ? [Colors.orange.shade900, Colors.deepOrange.shade800]
                  : [Colors.orange.shade50, Colors.amber.shade50],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CharacterImageService.getCharacterImage(
                character.name['en']!,
                size: 56,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            character.name[lang]!,
                            style: TextStyle(
                              fontSize: 20 * fontSize,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : Colors.deepOrange.shade900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Reading time badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.schedule,
                                  size: 12, color: Colors.white),
                              const SizedBox(width: 4),
                              Text(
                                '10 min',
                                style: TextStyle(
                                  fontSize: 11 * fontSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      character.keyTraits[lang]!,
                      style: TextStyle(
                        fontSize: 13 * fontSize,
                        color: isDark
                            ? Colors.orange.shade200
                            : Colors.orange.shade700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.arrow_forward_ios,
                color: isDark
                    ? Colors.orange.shade300
                    : Colors.deepOrange.shade400,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
