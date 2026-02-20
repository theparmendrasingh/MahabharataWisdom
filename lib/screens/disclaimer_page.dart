import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_settings.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);

    // Normalize language value from AppSettings so English checks work
    final languageSetting = settings.language;
    final isEnglish = (() {
      if (languageSetting == null) return true;
      if (languageSetting is String) {
        final s = (languageSetting as String).toLowerCase();
        return s.startsWith('en') || s == 'english';
      }
      final s = languageSetting.toString().toLowerCase();
      return s.contains('en') || s.contains('english');
    })();

    final isDark = settings.themeMode == ThemeMode.dark ||
        (settings.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    final lang = isEnglish ? 'en' : 'hi';
    final fontSizeMultiplier =
        _getFontSizeMultiplier(settings.fontSize.toString().split('.').last);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang == 'en' ? 'Disclaimer' : 'अस्वीकरण',
          style: TextStyle(
            fontSize: 20 * fontSizeMultiplier,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: isDark ? Colors.grey.shade900 : Colors.orange.shade50,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Icon
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.orange.shade800
                        : Colors.orange.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    size: 60,
                    color: isDark ? Colors.orange.shade200 : Colors.deepOrange,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Title
              _buildSectionTitle(
                lang == 'en' ? 'Important Notice' : 'महत्वपूर्ण सूचना',
                fontSizeMultiplier,
                isDark,
              ),
              const SizedBox(height: 15),

              // General Disclaimer
              _buildCard(
                context,
                Icons.warning_amber_rounded,
                lang == 'en' ? 'General Disclaimer' : 'सामान्य अस्वीकरण',
                lang == 'en'
                    ? 'This application (Mahabharata Wisdom) is designed for educational and spiritual enrichment purposes only. The content presented is based on traditional interpretations of the Mahabharata epic and Bhagavad Gita teachings.'
                    : 'यह एप्लिकेशन (महाभारत विजडम) केवल शैक्षिक और आध्यात्मिक संवर्धन उद्देश्यों के लिए डिज़ाइन किया गया है। प्रस्तुत सामग्री महाभारत महाकाव्य और भगवद गीता शिक्षाओं की पारंपरिक व्याख्याओं पर आधारित है।',
                fontSizeMultiplier,
                isDark,
              ),
              const SizedBox(height: 15),

              // Religious Content
              _buildCard(
                context,
                Icons.temple_hindu,
                lang == 'en'
                    ? 'Religious & Cultural Content'
                    : 'धार्मिक और सांस्कृतिक सामग्री',
                lang == 'en'
                    ? 'The stories, shlokas, and life lessons are interpretations meant to inspire reflection and personal growth. They are not intended to represent any single religious or cultural viewpoint. Users are encouraged to consult authentic religious texts and scholars for detailed study.'
                    : 'कहानियां, श्लोक और जीवन के पाठ ऐसी व्याख्याएं हैं जो प्रेरित करने और व्यक्तिगत विकास के लिए हैं। वे किसी एक धार्मिक या सांस्कृतिक दृष्टिकोण का प्रतिनिधित्व करने के लिए नहीं हैं। उपयोगकर्ताओं को विस्तृत अध्ययन के लिए प्रामाणिक धार्मिक ग्रंथों और विद्वानों से परामर्श लेने के लिए प्रोत्साहित किया जाता है।',
                fontSizeMultiplier,
                isDark,
              ),
              const SizedBox(height: 15),

              // Accuracy
              _buildCard(
                context,
                Icons.fact_check_outlined,
                lang == 'en' ? 'Content Accuracy' : 'सामग्री की सटीकता',
                lang == 'en'
                    ? 'While we strive for accuracy in presenting the Mahabharata characters and teachings, interpretations may vary. The content should not be considered as the sole or definitive source of information about Hindu philosophy or the Mahabharata epic.'
                    : 'हालांकि हम महाभारत पात्रों और शिक्षाओं को प्रस्तुत करने में सटीकता के लिए प्रयास करते हैं, व्याख्याएं भिन्न हो सकती हैं। सामग्री को हिंदू दर्शन या महाभारत महाकाव्य के बारे में एकमात्र या निश्चित स्रोत नहीं माना जाना चाहिए।',
                fontSizeMultiplier,
                isDark,
              ),
              const SizedBox(height: 15),

              // Personal Advice
              _buildCard(
                context,
                Icons.person_off_outlined,
                lang == 'en' ? 'Not Personal Advice' : 'व्यक्तिगत सलाह नहीं',
                lang == 'en'
                    ? 'The life lessons and wisdom shared in this app are general in nature and should not be construed as personal, professional, legal, medical, or financial advice. Users should make their own informed decisions and consult appropriate professionals when needed.'
                    : 'इस ऐप में साझा किए गए जीवन के पाठ और ज्ञान सामान्य प्रकृति के हैं और इन्हें व्यक्तिगत, पेशेवर, कानूनी, चिकित्सा या वित्तीय सलाह के रूप में नहीं लिया जाना चाहिए। उपयोगकर्ताओं को अपने स्वयं के सूचित निर्णय लेने चाहिए और आवश्यकता पड़ने पर उपयुक्त पेशेवरों से परामर्श लेना चाहिए।',
                fontSizeMultiplier,
                isDark,
              ),
              const SizedBox(height: 15),

              // Copyright
              _buildCard(
                context,
                Icons.copyright_outlined,
                lang == 'en' ? 'Copyright & Sources' : 'कॉपीराइट और स्रोत',
                lang == 'en'
                    ? 'The Mahabharata and Bhagavad Gita are ancient texts in the public domain. The specific interpretations, translations, and presentations in this app are original works or based on traditional scholarly interpretations. Character illustrations and UI elements are original designs created for this application.'
                    : 'महाभारत और भगवद गीता सार्वजनिक डोमेन में प्राचीन ग्रंथ हैं। इस ऐप में विशिष्ट व्याख्याएं, अनुवाद और प्रस्तुतियां मूल कार्य हैं या पारंपरिक विद्वानों की व्याख्याओं पर आधारित हैं। चरित्र चित्र और UI तत्व इस एप्लिकेशन के लिए बनाए गए मूल डिजाइन हैं।',
                fontSizeMultiplier,
                isDark,
              ),
              const SizedBox(height: 15),

              // No Warranty
              _buildCard(
                context,
                Icons.shield_outlined,
                lang == 'en' ? 'No Warranty' : 'कोई वारंटी नहीं',
                lang == 'en'
                    ? 'This app is provided as is without any warranties, express or implied. We do not guarantee uninterrupted, error-free operation or that the content will meet your specific requirements. Use of this app is at your own risk.'
                    : 'यह ऐप जैसा है किसी भी वारंटी के बिना प्रदान किया गया है, व्यक्त या निहित। हम निर्बाध, त्रुटि-मुक्त संचालन की गारंटी नहीं देते हैं या यह कि सामग्री आपकी विशिष्ट आवश्यकताओं को पूरा करेगी। इस ऐप का उपयोग आपके अपने जोखिम पर है।',
                fontSizeMultiplier,
                isDark,
              ),
              const SizedBox(height: 15),

              // Privacy
              _buildCard(
                context,
                Icons.privacy_tip_outlined,
                lang == 'en' ? 'Privacy & Data' : 'गोपनीयता और डेटा',
                lang == 'en'
                    ? 'This app stores your preferences (language, font size, theme) locally on your device. We do not collect, transmit, or store any personal information on external servers. Your reading progress and settings remain private on your device.'
                    : 'यह ऐप आपकी प्राथमिकताओं (भाषा, फ़ॉन्ट आकार, थीम) को आपके डिवाइस पर स्थानीय रूप से संग्रहीत करता है। हम बाहरी सर्वर पर किसी भी व्यक्तिगत जानकारी को एकत्र, प्रसारित या संग्रहीत नहीं करते हैं। आपकी पढ़ने की प्रगति और सेटिंग्स आपके डिवाइस पर निजी रहती हैं।',
                fontSizeMultiplier,
                isDark,
              ),
              const SizedBox(height: 15),

              // Updates
              _buildCard(
                context,
                Icons.update,
                lang == 'en' ? 'Updates & Changes' : 'अपडेट और परिवर्तन',
                lang == 'en'
                    ? 'We reserve the right to modify, update, or discontinue any part of the app content or features at any time without prior notice. Continued use of the app after changes constitutes acceptance of those changes.'
                    : 'हम बिना किसी पूर्व सूचना के किसी भी समय ऐप सामग्री या सुविधाओं के किसी भी हिस्से को संशोधित, अपडेट या बंद करने का अधिकार सुरक्षित रखते हैं। परिवर्तनों के बाद ऐप का निरंतर उपयोग उन परिवर्तनों की स्वीकृति का गठन करता है।',
                fontSizeMultiplier,
                isDark,
              ),
              const SizedBox(height: 15),

              // Limitation of Liability
              _buildCard(
                context,
                Icons.gavel_outlined,
                lang == 'en' ? 'Limitation of Liability' : 'दायित्व की सीमा',
                lang == 'en'
                    ? 'To the fullest extent permitted by law, the developers and contributors of this app shall not be liable for any direct, indirect, incidental, consequential, or special damages arising from the use or inability to use this application.'
                    : 'कानून द्वारा अनुमत पूर्ण सीमा तक, इस ऐप के डेवलपर्स और योगदानकर्ता इस एप्लिकेशन के उपयोग या उपयोग करने में असमर्थता से उत्पन्न किसी भी प्रत्यक्ष, अप्रत्यक्ष, आकस्मिक, परिणामी या विशेष क्षति के लिए उत्तरदायी नहीं होंगे।',
                fontSizeMultiplier,
                isDark,
              ),
              const SizedBox(height: 30),

              // Acceptance
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      isDark ? Colors.orange.shade800 : Colors.orange.shade300,
                      isDark
                          ? Colors.deepOrange.shade900
                          : Colors.deepOrange.shade400,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      lang == 'en'
                          ? 'By using this app, you acknowledge that you have read, understood, and agree to this disclaimer.'
                          : 'इस ऐप का उपयोग करके, आप स्वीकार करते हैं कि आपने इस अस्वीकरण को पढ़ा, समझा और सहमत हैं।',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15 * fontSizeMultiplier,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Contact
              Center(
                child: Text(
                  lang == 'en'
                      ? 'For questions or concerns, please contact the app developer.'
                      : 'प्रश्नों या चिंताओं के लिए, कृपया ऐप डेवलपर से संपर्क करें।',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13 * fontSizeMultiplier,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Last Updated
              Center(
                child: Text(
                  lang == 'en'
                      ? 'Last Updated: February 2026'
                      : 'अंतिम अपडेट: फरवरी 2026',
                  style: TextStyle(
                    fontSize: 12 * fontSizeMultiplier,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  double _getFontSizeMultiplier(String fontSize) {
    switch (fontSize) {
      case 'small':
        return 0.8;
      case 'medium':
        return 1.0;
      case 'large':
        return 1.2;
      case 'extraLarge':
        return 1.4;
      default:
        return 1.0;
    }
  }

  Widget _buildSectionTitle(String title, double fontSize, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22 * fontSize,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.orange.shade300 : Colors.deepOrange.shade700,
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title,
      String content, double fontSize, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDark ? Colors.orange.shade800 : Colors.orange.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isDark ? Colors.orange.shade300 : Colors.deepOrange,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17 * fontSize,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? Colors.orange.shade200
                        : Colors.deepOrange.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14 * fontSize,
              height: 1.6,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
