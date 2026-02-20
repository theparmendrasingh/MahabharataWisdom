import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/app_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);
    final lang = settings.languageCode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.orange.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          lang == 'en' ? 'Settings' : 'सेटिंग्स',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSectionHeader(
            lang == 'en' ? 'Reading Preferences' : 'पठन प्राथमिकताएं',
            Icons.chrome_reader_mode,
            isDark,
          ),
          _buildFontSizeSelector(context, settings, lang, isDark),
          const Divider(height: 32),
          _buildSectionHeader(
            lang == 'en' ? 'Appearance' : 'रूप',
            Icons.palette,
            isDark,
          ),
          _buildThemeSelector(context, settings, lang, isDark),
          const Divider(height: 32),
          _buildSectionHeader(
            lang == 'en' ? 'Language' : 'भाषा',
            Icons.language,
            isDark,
          ),
          _buildLanguageSelector(context, settings, isDark),
          const Divider(height: 32),
          _buildSectionHeader(
            lang == 'en' ? 'More' : 'और',
            Icons.more_horiz,
            isDark,
          ),
          _buildActionTile(
            icon: Icons.share,
            title: lang == 'en' ? 'Share with Friends' : 'मित्रों के साथ साझा करें',
            subtitle: lang == 'en' ? 'Spread the wisdom' : 'ज्ञान फैलाएं',
            onTap: () => _shareApp(lang),
            isDark: isDark,
          ),
          _buildActionTile(
            icon: Icons.info_outline,
            title: lang == 'en' ? 'About App' : 'ऐप के बारे में',
            subtitle: 'Version 1.0.0',
            onTap: () => _showAboutDialog(context, lang),
            isDark: isDark,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: isDark ? Colors.orange.shade300 : Colors.deepOrange.shade700, size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.orange.shade200 : Colors.deepOrange.shade800,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildFontSizeSelector(BuildContext context, AppSettings settings, String lang, bool isDark) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.grey.shade800, Colors.grey.shade800]
                : [Colors.white, Colors.orange.shade50],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.text_fields,
                  color: isDark ? Colors.orange.shade300 : Colors.deepOrange.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  lang == 'en' ? 'Font Size' : 'फ़ॉन्ट आकार',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildFontSizeOption(
                    settings,
                    FontSize.small,
                    lang == 'en' ? 'Small' : 'छोटा',
                    'Aa',
                    16,
                    isDark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildFontSizeOption(
                    settings,
                    FontSize.medium,
                    lang == 'en' ? 'Medium' : 'मध्यम',
                    'Aa',
                    20,
                    isDark,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildFontSizeOption(
                    settings,
                    FontSize.large,
                    lang == 'en' ? 'Large' : 'बड़ा',
                    'Aa',
                    24,
                    isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang == 'en' ? 'Preview' : 'पूर्वावलोकन',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lang == 'en'
                        ? 'This is how the text will appear in stories and quotes.'
                        : 'कहानियों और उद्धरणों में पाठ इस तरह दिखाई देगा।',
                    style: TextStyle(
                      fontSize: 16 * settings.fontSizeMultiplier,
                      height: 1.5,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 100.ms);
  }

  Widget _buildFontSizeOption(AppSettings settings, FontSize size, String label, String sample, double sampleSize, bool isDark) {
    final isSelected = settings.fontSize == size;
    return InkWell(
      onTap: () => settings.setFontSize(size),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepOrange
              : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.deepOrange.shade700
                : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              sample,
              style: TextStyle(
                fontSize: sampleSize,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.grey.shade700),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context, AppSettings settings, String lang, bool isDark) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.grey.shade800, Colors.grey.shade800]
                : [Colors.white, Colors.orange.shade50],
          ),
        ),
        child: Column(
          children: [
            RadioListTile<AppTheme>(
              title: Row(
                children: [
                  Icon(Icons.light_mode, size: 20, color: isDark ? Colors.amber.shade300 : Colors.amber.shade700),
                  const SizedBox(width: 12),
                  Text(
                    lang == 'en' ? 'Light Theme' : 'लाइट थीम',
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  ),
                ],
              ),
              value: AppTheme.light,
              groupValue: settings.theme,
              onChanged: (value) => settings.setTheme(value!),
              activeColor: Colors.deepOrange,
            ),
            RadioListTile<AppTheme>(
              title: Row(
                children: [
                  Icon(Icons.dark_mode, size: 20, color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade700),
                  const SizedBox(width: 12),
                  Text(
                    lang == 'en' ? 'Dark Theme' : 'डार्क थीम',
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  ),
                ],
              ),
              value: AppTheme.dark,
              groupValue: settings.theme,
              onChanged: (value) => settings.setTheme(value!),
              activeColor: Colors.deepOrange,
            ),
            RadioListTile<AppTheme>(
              title: Row(
                children: [
                  Icon(Icons.brightness_auto, size: 20, color: isDark ? Colors.green.shade300 : Colors.green.shade700),
                  const SizedBox(width: 12),
                  Text(
                    lang == 'en' ? 'System Theme' : 'सिस्टम थीम',
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  ),
                ],
              ),
              value: AppTheme.system,
              groupValue: settings.theme,
              onChanged: (value) => settings.setTheme(value!),
              activeColor: Colors.deepOrange,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 200.ms);
  }

  Widget _buildLanguageSelector(BuildContext context, AppSettings settings, bool isDark) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.grey.shade800, Colors.grey.shade800]
                : [Colors.white, Colors.orange.shade50],
          ),
        ),
        child: Column(
          children: [
            RadioListTile<AppLanguage>(
              title: Row(
                children: [
                  const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Text(
                    'English',
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  ),
                ],
              ),
              value: AppLanguage.english,
              groupValue: settings.language,
              onChanged: (value) => settings.setLanguage(value!),
              activeColor: Colors.deepOrange,
            ),
            RadioListTile<AppLanguage>(
              title: Row(
                children: [
                  const Text('🇮🇳', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Text(
                    'हिंदी',
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  ),
                ],
              ),
              value: AppLanguage.hindi,
              groupValue: settings.language,
              onChanged: (value) => settings.setLanguage(value!),
              activeColor: Colors.deepOrange,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 300.ms);
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.deepOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.deepOrange, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
        ),
        onTap: onTap,
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 400.ms);
  }

  void _shareApp(String lang) {
    final message = lang == 'en'
        ? 'Discover daily wisdom from Mahabharata! Download the app and learn life lessons from ancient heroes.'
        : 'महाभारत से दैनिक ज्ञान खोजें! ऐप डाउनलोड करें और प्राचीन नायकों से जीवन के पाठ सीखें।';
    Share.share(message);
  }

  void _showAboutDialog(BuildContext context, String lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.deepOrange),
            const SizedBox(width: 12),
            Text(lang == 'en' ? 'About' : 'के बारे में'),
          ],
        ),
        content: Text(
          lang == 'en'
              ? 'Mahabharata Wisdom brings daily lessons from ancient characters to modern life.\n\nVersion 1.0.0\n\nBuilt with Flutter 💙'
              : 'महाभारत ज्ञान प्राचीन पात्रों से दैनिक पाठ आधुनिक जीवन में लाता है।\n\nसंस्करण 1.0.0\n\nFlutter के साथ बनाया गया 💙',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(lang == 'en' ? 'Close' : 'बंद करें'),
          ),
        ],
      ),
    );
  }
}
