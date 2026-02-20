import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/character.dart';
import '../models/app_settings.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);
    final lang = settings.languageCode;
    final fontSize = settings.fontSizeMultiplier;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [Colors.orange.shade900, Colors.deepOrange.shade800]
                  : [Colors.orange.shade50, Colors.deepOrange.shade100],
            ),
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned(
                right: -30,
                top: -30,
                child: Icon(
                  Icons.auto_stories_outlined,
                  size: 150,
                  color: (isDark ? Colors.white : Colors.orange.shade200).withOpacity(0.1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.person,
                            color: isDark ? Colors.orange.shade200 : Colors.deepOrange.shade700,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang == 'en' ? 'Character of the Day' : 'आज का पात्र',
                                style: TextStyle(
                                  fontSize: 13 * fontSize,
                                  color: isDark ? Colors.orange.shade200 : Colors.orange.shade800,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateTime.now().toString().split(' ')[0],
                                style: TextStyle(
                                  fontSize: 11 * fontSize,
                                  color: isDark ? Colors.orange.shade300 : Colors.orange.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      character.name[lang]!,
                      style: TextStyle(
                        fontSize: 32 * fontSize,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.deepOrange.shade900,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: character.keyTraits[lang]!.split(',').map((trait) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.orange.shade800.withOpacity(0.3)
                                : Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDark ? Colors.orange.shade700 : Colors.orange.shade300,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 14,
                                color: isDark ? Colors.orange.shade300 : Colors.orange.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                trait.trim(),
                                style: TextStyle(
                                  fontSize: 12 * fontSize,
                                  color: isDark ? Colors.orange.shade200 : Colors.orange.shade900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withOpacity(0.2)
                            : Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark ? Colors.orange.shade800 : Colors.orange.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: isDark ? Colors.amber.shade300 : Colors.amber.shade700,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              character.lifeLesson[lang]!,
                              style: TextStyle(
                                fontSize: 15 * fontSize,
                                height: 1.5,
                                color: isDark ? Colors.white : Colors.brown.shade900,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: onTap,
                          icon: const Icon(Icons.menu_book, size: 20),
                          label: Text(
                            lang == 'en' ? 'Read Full Story' : 'पूरी कहानी पढ़ें',
                            style: TextStyle(
                              fontSize: 14 * fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }
}
