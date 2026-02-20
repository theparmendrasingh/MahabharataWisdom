import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../models/app_settings.dart';
import '../models/character.dart';
import '../services/data_service.dart';
import '../widgets/character_card.dart';
import '../widgets/quote_card.dart';
import 'character_detail_screen.dart';
import 'settings_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataService _dataService = DataService();
  Character? _characterOfDay;
  Quote? _quoteOfDay;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await _dataService.loadData();
    _characterOfDay = _dataService.getCharacterOfDay();
    _quoteOfDay = await _dataService.getQuoteOfDay();
    setState(() => _isLoading = false);
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
        title: Row(
          children: [
            Icon(Icons.auto_stories, color: Colors.white, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    lang == 'en' ? 'Mahabharata Wisdom' : 'महाभारत ज्ञान',
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(dataService: _dataService),
              ),
            ),
          ),
          PopupMenuButton<AppLanguage>(
            icon: const Icon(Icons.language, color: Colors.white),
            onSelected: settings.setLanguage,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: AppLanguage.english,
                child: Row(
                  children: [
                    Icon(Icons.language, size: 20),
                    SizedBox(width: 8),
                    Text('English'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AppLanguage.hindi,
                child: Row(
                  children: [
                    Icon(Icons.language, size: 20),
                    SizedBox(width: 8),
                    Text('हिंदी'),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.deepOrange),
                  const SizedBox(height: 20),
                  Text(
                    lang == 'en' ? 'Loading wisdom...' : 'ज्ञान लोड हो रहा है...',
                    style: TextStyle(fontSize: 16 * fontSize),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadData,
              color: Colors.deepOrange,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Welcome Banner
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.deepOrange, Colors.orange.shade600],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepOrange.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.wb_sunny, color: Colors.white, size: 40),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getGreeting(lang),
                                  style: TextStyle(
                                    fontSize: 20 * fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  lang == 'en'
                                      ? 'Discover ancient wisdom for modern life'
                                      : 'आधुनिक जीवन के लिए प्राचीन ज्ञान',
                                  style: TextStyle(
                                    fontSize: 13 * fontSize,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),

                    // Stats Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.people,
                              value: '${_dataService.characters.length}',
                              label: lang == 'en' ? 'Characters' : 'पात्र',
                              color: Colors.blue,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.auto_awesome,
                              value: '${_dataService.quotes.length}',
                              label: lang == 'en' ? 'Quotes' : 'सूक्तियां',
                              color: Colors.amber,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.today,
                              value: '${DateTime.now().day}',
                              label: lang == 'en' ? 'Today' : 'आज',
                              color: Colors.green,
                              isDark: isDark,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

                    const SizedBox(height: 8),

                    // Character Card
                    if (_characterOfDay != null)
                      CharacterCard(
                        character: _characterOfDay!,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterDetailScreen(
                              character: _characterOfDay!,
                              dataService: _dataService,
                            ),
                          ),
                        ),
                      ),

                    // Quote Card
                    if (_quoteOfDay != null) QuoteCard(quote: _quoteOfDay!),

                    // Browse All Button
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(dataService: _dataService),
                          ),
                        ),
                        icon: const Icon(Icons.explore, size: 24),
                        label: Text(
                          lang == 'en' ? 'Browse All Characters' : 'सभी पात्र देखें',
                          style: TextStyle(fontSize: 16 * fontSize, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 6,
                        ),
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 400.ms),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required MaterialColor color,
    required bool isDark,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: isDark
                ? [color.shade900, color.shade800]
                : [color.shade50, color.shade100],
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isDark ? color.shade200 : color.shade700, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : color.shade900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? color.shade200 : color.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getGreeting(String lang) {
    final hour = DateTime.now().hour;
    if (lang == 'en') {
      if (hour < 12) return 'Good Morning!';
      if (hour < 17) return 'Good Afternoon!';
      return 'Good Evening!';
    } else {
      if (hour < 12) return 'सुप्रभात!';
      if (hour < 17) return 'नमस्ते!';
      return 'शुभ संध्या!';
    }
  }
}
