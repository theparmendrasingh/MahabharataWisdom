import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/character.dart';
import '../models/app_settings.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);
    final lang = settings.languageCode;
    final fontSize = settings.fontSizeMultiplier;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Colors.amber.shade900, Colors.orange.shade900]
                : [Colors.amber.shade50, Colors.orange.shade100],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -20,
              bottom: -20,
              child: Icon(
                Icons.format_quote,
                size: 120,
                color: (isDark ? Colors.white : Colors.amber.shade300).withOpacity(0.1),
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
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.auto_awesome,
                          color: isDark ? Colors.amber.shade200 : Colors.amber.shade800,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          lang == 'en' ? 'Wisdom of the Day' : 'आज की सूक्ति',
                          style: TextStyle(
                            fontSize: 18 * fontSize,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.amber.shade200 : Colors.orange.shade900,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.orange.shade800.withOpacity(0.3)
                              : Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          quote.category,
                          style: TextStyle(
                            fontSize: 11 * fontSize,
                            color: isDark ? Colors.orange.shade200 : Colors.orange.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.amber.shade800 : Colors.amber.shade200,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.menu_book,
                          color: isDark ? Colors.amber.shade300 : Colors.brown.shade700,
                          size: 28,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          quote.sanskrit,
                          style: TextStyle(
                            fontSize: 17 * fontSize,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.amber.shade100 : Colors.brown.shade900,
                            height: 1.8,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.amber.shade900.withOpacity(0.2)
                                : Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            quote.transliteration,
                            style: TextStyle(
                              fontSize: 13 * fontSize,
                              color: isDark ? Colors.amber.shade300 : Colors.brown.shade600,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.light_mode,
                        color: isDark ? Colors.amber.shade300 : Colors.orange.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang == 'en' ? 'Meaning' : 'अर्थ',
                              style: TextStyle(
                                fontSize: 14 * fontSize,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.amber.shade200 : Colors.orange.shade800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              quote.meaning[lang]!,
                              style: TextStyle(
                                fontSize: 15 * fontSize,
                                height: 1.6,
                                color: isDark ? Colors.white : Colors.brown.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.book,
                        size: 16,
                        color: isDark ? Colors.amber.shade400 : Colors.orange.shade700,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '— ${quote.reference}',
                        style: TextStyle(
                          fontSize: 13 * fontSize,
                          color: isDark ? Colors.amber.shade300 : Colors.orange.shade700,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
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
    ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3, end: 0);
  }
}
