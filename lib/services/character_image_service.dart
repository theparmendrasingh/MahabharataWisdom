import 'package:flutter/material.dart';

class CharacterImageService {
  /// Returns a CircleAvatar with character-specific gradient and icon
  static Widget getCharacterImage(String characterName, {double size = 80}) {
    final imageData = _characterImages[characterName.toLowerCase()] ??
        _characterImages['default']!;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: imageData['gradient'] as List<Color>,
        ),
        boxShadow: [
          BoxShadow(
            color: (imageData['gradient'] as List<Color>)[0].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        imageData['icon'] as IconData,
        size: size * 0.6,
        color: Colors.white,
      ),
    );
  }

  /// Returns character emoji for list views
  static String getCharacterEmoji(String characterName) {
    final emoji = _characterEmojis[characterName.toLowerCase()];
    return emoji ?? '👤';
  }

  /// Character-specific gradients and icons (100 characters)
  static final Map<String, Map<String, dynamic>> _characterImages = {
    // MAIN PANDAVAS & KAURAVAS (1-10)
    'krishna': {
      'gradient': [Color(0xFF1A237E), Color(0xFF3949AB)],
      'icon': Icons.auto_awesome
    },
    'arjuna': {
      'gradient': [Color(0xFF4A148C), Color(0xFF7B1FA2)],
      'icon': Icons.gps_fixed
    },
    'karna': {
      'gradient': [Color(0xFFBF360C), Color(0xFFE64A19)],
      'icon': Icons.shield
    },
    'bhishma': {
      'gradient': [Color(0xFF01579B), Color(0xFF0277BD)],
      'icon': Icons.security
    },
    'draupadi': {
      'gradient': [Color(0xFF880E4F), Color(0xFFC2185B)],
      'icon': Icons.local_fire_department
    },
    'yudhishthira': {
      'gradient': [Color(0xFF1B5E20), Color(0xFF388E3C)],
      'icon': Icons.balance
    },
    'duryodhana': {
      'gradient': [Color(0xFF212121), Color(0xFF424242)],
      'icon': Icons.flash_on
    },
    'abhimanyu': {
      'gradient': [Color(0xFFE65100), Color(0xFFFF6F00)],
      'icon': Icons.star
    },
    'bhima': {
      'gradient': [Color(0xFFD84315), Color(0xFFFF5722)],
      'icon': Icons.fitness_center
    },
    'dushasana': {
      'gradient': [Color(0xFFB71C1C), Color(0xFFE53935)],
      'icon': Icons.warning
    },

    // ELDERS & TEACHERS (11-20)
    'kunti': {
      'gradient': [Color(0xFF6A1B9A), Color(0xFF9C27B0)],
      'icon': Icons.favorite
    },
    'gandhari': {
      'gradient': [Color(0xFF4A148C), Color(0xFF6A1B9A)],
      'icon': Icons.visibility_off
    },
    'shakuni': {
      'gradient': [Color(0xFFB71C1C), Color(0xFFD32F2F)],
      'icon': Icons.casino
    },
    'vidura': {
      'gradient': [Color(0xFF004D40), Color(0xFF00796B)],
      'icon': Icons.school
    },
    'dronacharya': {
      'gradient': [Color(0xFF33691E), Color(0xFF558B2F)],
      'icon': Icons.sports_martial_arts
    },
    'kripacharya': {
      'gradient': [Color(0xFF00695C), Color(0xFF00897B)],
      'icon': Icons.history_edu
    },
    'dhritarashtra': {
      'gradient': [Color(0xFF424242), Color(0xFF616161)],
      'icon': Icons.visibility_off
    },
    'pandu': {
      'gradient': [Color(0xFF5D4037), Color(0xFF795548)],
      'icon': Icons.account_balance
    },
    'vyasa': {
      'gradient': [Color(0xFF311B92), Color(0xFF512DA8)],
      'icon': Icons.menu_book
    },
    'parashurama': {
      'gradient': [Color(0xFFBF360C), Color(0xFFD84315)],
      'icon': Icons.agriculture
    },

    // OTHER PANDAVAS & FAMILY (21-30)
    'nakula': {
      'gradient': [Color(0xFF0277BD), Color(0xFF0288D1)],
      'icon': Icons.pets
    },
    'sahadeva': {
      'gradient': [Color(0xFF5D4037), Color(0xFF6D4C41)],
      'icon': Icons.psychology
    },
    'subhadra': {
      'gradient': [Color(0xFFAD1457), Color(0xFFD81B60)],
      'icon': Icons.favorite_rounded
    },
    'uttara': {
      'gradient': [Color(0xFFFF6F00), Color(0xFFFF8A65)],
      'icon': Icons.child_care
    },
    'hidimba': {
      'gradient': [Color(0xFF1B5E20), Color(0xFF2E7D32)],
      'icon': Icons.nature
    },
    'ghatotkacha': {
      'gradient': [Color(0xFF2E7D32), Color(0xFF388E3C)],
      'icon': Icons.air
    },
    'madri': {
      'gradient': [Color(0xFFC2185B), Color(0xFFD81B60)],
      'icon': Icons.self_improvement
    },
    'draupadi_sons': {
      'gradient': [Color(0xFFE65100), Color(0xFFF57C00)],
      'icon': Icons.group
    },
    'parikshit': {
      'gradient': [Color(0xFF1565C0), Color(0xFF1976D2)],
      'icon': Icons.child_friendly
    },
    'chitrangada': {
      'gradient': [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
      'icon': Icons.person
    },

    // KAURAVAS & ALLIES (31-40)
    'ashwatthama': {
      'gradient': [Color(0xFFB71C1C), Color(0xFFD32F2F)],
      'icon': Icons.warning_amber
    },
    'jayadratha': {
      'gradient': [Color(0xFF880E4F), Color(0xFFA1287F)],
      'icon': Icons.block
    },
    'dushasana': {
      'gradient': [Color(0xFFB71C1C), Color(0xFFD32F2F)],
      'icon': Icons.dangerous
    },
    'vikarna': {
      'gradient': [Color(0xFF424242), Color(0xFF616161)],
      'icon': Icons.sentiment_satisfied
    },
    'yuyutsu': {
      'gradient': [Color(0xFF5D4037), Color(0xFF795548)],
      'icon': Icons.swap_horiz
    },
    'shalya': {
      'gradient': [Color(0xFF827717), Color(0xFF9E9D24)],
      'icon': Icons.supervisor_account
    },
    'kichaka': {
      'gradient': [Color(0xFFB71C1C), Color(0xFFE53935)],
      'icon': Icons.person_off
    },
    'keechaka_brothers': {
      'gradient': [Color(0xFFB71C1C), Color(0xFFD32F2F)],
      'icon': Icons.groups
    },
    'susharma': {
      'gradient': [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
      'icon': Icons.military_tech
    },
    'saindhava': {
      'gradient': [Color(0xFF4A148C), Color(0xFF6A1B9A)],
      'icon': Icons.castle
    },

    // WARRIORS & HEROES (41-50)
    'eklavya': {
      'gradient': [Color(0xFFE65100), Color(0xFFF57C00)],
      'icon': Icons.album
    },
    'balarama': {
      'gradient': [Color(0xFF283593), Color(0xFF3949AB)],
      'icon': Icons.agriculture
    },
    'barbarik': {
      'gradient': [Color(0xFF00838F), Color(0xFF00ACC1)],
      'icon': Icons.volunteer_activism
    },
    'iravan': {
      'gradient': [Color(0xFF004D40), Color(0xFF00695C)],
      'icon': Icons.waves
    },
    'satyaki': {
      'gradient': [Color(0xFF1565C0), Color(0xFF1976D2)],
      'icon': Icons.shield_moon
    },
    'dhrishtadyumna': {
      'gradient': [Color(0xFFE65100), Color(0xFFFF6F00)],
      'icon': Icons.whatshot
    },
    'shikhandi': {
      'gradient': [Color(0xFF4527A0), Color(0xFF5E35B1)],
      'icon': Icons.transgender
    },
    'yudhamanyu': {
      'gradient': [Color(0xFF2E7D32), Color(0xFF43A047)],
      'icon': Icons.security
    },
    'uttamaujas': {
      'gradient': [Color(0xFF1565C0), Color(0xFF1E88E5)],
      'icon': Icons.bolt
    },
    'kritavarma': {
      'gradient': [Color(0xFF6A1B9A), Color(0xFF7B1FA2)],
      'icon': Icons.dangerous
    },

    // WOMEN & QUEENS (51-60)
    'amba': {
      'gradient': [Color(0xFFAD1457), Color(0xFFC2185B)],
      'icon': Icons.local_fire_department
    },
    'ambika': {
      'gradient': [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
      'icon': Icons.face
    },
    'ambalika': {
      'gradient': [Color(0xFF7B1FA2), Color(0xFF9C27B0)],
      'icon': Icons.face_retouching_natural
    },
    'ulupi': {
      'gradient': [Color(0xFF00695C), Color(0xFF00897B)],
      'icon': Icons.waves
    },
    'chitrangada_manipur': {
      'gradient': [Color(0xFFAD1457), Color(0xFFC2185B)],
      'icon': Icons.woman
    },
    'balandhara': {
      'gradient': [Color(0xFFD84315), Color(0xFFE64A19)],
      'icon': Icons.favorite_border
    },
    'devika': {
      'gradient': [Color(0xFF2E7D32), Color(0xFF43A047)],
      'icon': Icons.auto_awesome
    },
    'karenumati': {
      'gradient': [Color(0xFF0277BD), Color(0xFF0288D1)],
      'icon': Icons.diamond
    },
    'vijaya': {
      'gradient': [Color(0xFF5D4037), Color(0xFF6D4C41)],
      'icon': Icons.workspace_premium
    },
    'bhanumati': {
      'gradient': [Color(0xFF424242), Color(0xFF616161)],
      'icon': Icons.visibility_off
    },

    // KINGS & RULERS (61-70)
    'sanjaya': {
      'gradient': [Color(0xFF37474F), Color(0xFF546E7A)],
      'icon': Icons.visibility
    },
    'kuntibhoja': {
      'gradient': [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
      'icon': Icons.family_restroom
    },
    'drupada': {
      'gradient': [Color(0xFFE65100), Color(0xFFFF6F00)],
      'icon': Icons.castle
    },
    'virata': {
      'gradient': [Color(0xFFEF6C00), Color(0xFFF57C00)],
      'icon': Icons.home_work
    },
    'shishupala': {
      'gradient': [Color(0xFFB71C1C), Color(0xFFD32F2F)],
      'icon': Icons.person_off
    },
    'jarasandha': {
      'gradient': [Color(0xFF6A1B9A), Color(0xFF7B1FA2)],
      'icon': Icons.fitness_center
    },
    'salwa': {
      'gradient': [Color(0xFF5D4037), Color(0xFF6D4C41)],
      'icon': Icons.flight
    },
    'bhagadatta': {
      'gradient': [Color(0xFF827717), Color(0xFF9E9D24)],
      'icon': Icons.pets
    },
    'bhishmaka': {
      'gradient': [Color(0xFF1565C0), Color(0xFF1976D2)],
      'icon': Icons.account_balance
    },
    'nala': {
      'gradient': [Color(0xFFEF6C00), Color(0xFFF57C00)],
      'icon': Icons.favorite
    },

    // DIVINE & CELESTIAL (71-80)
    'surya': {
      'gradient': [Color(0xFFFF6F00), Color(0xFFFFB300)],
      'icon': Icons.wb_sunny
    },
    'indra': {
      'gradient': [Color(0xFF1565C0), Color(0xFF1E88E5)],
      'icon': Icons.bolt
    },
    'yama': {
      'gradient': [Color(0xFF212121), Color(0xFF424242)],
      'icon': Icons.hourglass_empty
    },
    'vayu': {
      'gradient': [Color(0xFF0277BD), Color(0xFF0288D1)],
      'icon': Icons.air
    },
    'ashwins': {
      'gradient': [Color(0xFFEF6C00), Color(0xFFF57C00)],
      'icon': Icons.wc
    },
    'agni': {
      'gradient': [Color(0xFFD84315), Color(0xFFE64A19)],
      'icon': Icons.local_fire_department
    },
    'hanuman': {
      'gradient': [Color(0xFFEF6C00), Color(0xFFFF8F00)],
      'icon': Icons.pets
    },
    'urvashi': {
      'gradient': [Color(0xFFAD1457), Color(0xFFC2185B)],
      'icon': Icons.auto_awesome
    },
    'ganga': {
      'gradient': [Color(0xFF0277BD), Color(0xFF039BE5)],
      'icon': Icons.water
    },
    'satyavati': {
      'gradient': [Color(0xFF00695C), Color(0xFF00897B)],
      'icon': Icons.water_drop
    },

    // SAGES & BRAHMINS (81-90)
    'durvasa': {
      'gradient': [Color(0xFFEF6C00), Color(0xFFFF8F00)],
      'icon': Icons.emergency
    },
    'kindama': {
      'gradient': [Color(0xFF5D4037), Color(0xFF6D4C41)],
      'icon': Icons.pets
    },
    'lomasa': {
      'gradient': [Color(0xFF827717), Color(0xFF9E9D24)],
      'icon': Icons.hiking
    },
    'markandeya': {
      'gradient': [Color(0xFF311B92), Color(0xFF4527A0)],
      'icon': Icons.self_improvement
    },
    'narada': {
      'gradient': [Color(0xFF1565C0), Color(0xFF1976D2)],
      'icon': Icons.music_note
    },
    'suta': {
      'gradient': [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
      'icon': Icons.directions_car
    },
    'astika': {
      'gradient': [Color(0xFF00695C), Color(0xFF00897B)],
      'icon': Icons.campaign
    },
    'kanika': {
      'gradient': [Color(0xFFB71C1C), Color(0xFFD32F2F)],
      'icon': Icons.policy
    },
    'dhaumya': {
      'gradient': [Color(0xFF2E7D32), Color(0xFF388E3C)],
      'icon': Icons.temple_hindu
    },
    'purochana': {
      'gradient': [Color(0xFF424242), Color(0xFF616161)],
      'icon': Icons.construction
    },

    // UNIQUE CHARACTERS (91-100)
    'shalva': {
      'gradient': [Color(0xFF6A1B9A), Color(0xFF7B1FA2)],
      'icon': Icons.person_outline
    },
    'uttanka': {
      'gradient': [Color(0xFFEF6C00), Color(0xFFF57C00)],
      'icon': Icons.school
    },
    'shrutakarma': {
      'gradient': [Color(0xFFE65100), Color(0xFFFF6F00)],
      'icon': Icons.child_care
    },
    'prativindhya': {
      'gradient': [Color(0xFF1B5E20), Color(0xFF2E7D32)],
      'icon': Icons.child_care
    },
    'sutasoma': {
      'gradient': [Color(0xFF1565C0), Color(0xFF1976D2)],
      'icon': Icons.child_care
    },
    'shatanika': {
      'gradient': [Color(0xFF0277BD), Color(0xFF0288D1)],
      'icon': Icons.child_care
    },
    'shrutasena': {
      'gradient': [Color(0xFF5D4037), Color(0xFF6D4C41)],
      'icon': Icons.child_care
    },
    'ashwathama_horse': {
      'gradient': [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
      'icon': Icons.pets
    },
    'takshaka': {
      'gradient': [Color(0xFF004D40), Color(0xFF00695C)],
      'icon': Icons.pets
    },
    'eklavya_dog': {
      'gradient': [Color(0xFF827717), Color(0xFF9E9D24)],
      'icon': Icons.pets
    },

    'default': {
      'gradient': [Color(0xFFFF6F00), Color(0xFFFF8F00)],
      'icon': Icons.person
    },
  };

  /// Character emojis for compact views (100 characters)
  static final Map<String, String> _characterEmojis = {
    // MAIN PANDAVAS & KAURAVAS (1-10)
    'krishna': '🦚', 'arjuna': '🏹', 'karna': '⚡', 'bhishma': '🛡️',
    'draupadi': '🔥',
    'yudhishthira': '⚖️', 'duryodhana': '👑', 'abhimanyu': '⭐', 'bhima': '💪',
    'dushasana': '⚠️',

    // ELDERS & TEACHERS (11-20)
    'kunti': '💜', 'gandhari': '👁️', 'shakuni': '🎲', 'vidura': '📚',
    'dronacharya': '🥋',
    'kripacharya': '📖', 'dhritarashtra': '🙈', 'pandu': '⚖️', 'vyasa': '✍️',
    'parashurama': '🪓',

    // OTHER PANDAVAS & FAMILY (21-30)
    'nakula': '🐴', 'sahadeva': '🔮', 'subhadra': '💗', 'uttara': '👶',
    'hidimba': '🌲',
    'ghatotkacha': '🌪️', 'madri': '🌹', 'draupadi_sons': '👥',
    'parikshit': '👑', 'chitrangada': '👸',

    // KAURAVAS & ALLIES (31-40)
    'ashwatthama': '⚠️', 'jayadratha': '🚫', 'dushasana': '⛔', 'vikarna': '😊',
    'yuyutsu': '🔄',
    'shalya': '👮', 'kichaka': '😈', 'keechaka_brothers': '👥',
    'susharma': '⚔️', 'saindhava': '🏰',

    // WARRIORS & HEROES (41-50)
    'eklavya': '🎯', 'balarama': '🛡️', 'barbarik': '🙏', 'iravan': '🐍',
    'satyaki': '⚔️',
    'dhrishtadyumna': '🔥', 'shikhandi': '🏳️‍⚧️', 'yudhamanyu': '🛡️',
    'uttamaujas': '⚡', 'kritavarma': '⚔️',

    // WOMEN & QUEENS (51-60)
    'amba': '🔥', 'ambika': '👸', 'ambalika': '👸', 'ulupi': '🐍',
    'chitrangada_manipur': '👸',
    'balandhara': '💕', 'devika': '💎', 'karenumati': '💎', 'vijaya': '🏆',
    'bhanumati': '👑',

    // KINGS & RULERS (61-70)
    'sanjaya': '👁️', 'kuntibhoja': '👨‍👧', 'drupada': '🏰', 'virata': '🏠',
    'shishupala': '😠',
    'jarasandha': '💪', 'salwa': '✈️', 'bhagadatta': '🐘', 'bhishmaka': '🏛️',
    'nala': '❤️',

    // DIVINE & CELESTIAL (71-80)
    'surya': '☀️', 'indra': '⚡', 'yama': '⏳', 'vayu': '💨', 'ashwins': '👬',
    'agni': '🔥', 'hanuman': '🐒', 'urvashi': '✨', 'ganga': '🌊',
    'satyavati': '💧',

    // SAGES & BRAHMINS (81-90)
    'durvasa': '😡', 'kindama': '🦌', 'lomasa': '🚶', 'markandeya': '🧘',
    'narada': '🎵',
    'suta': '🚗', 'astika': '📣', 'kanika': '📜', 'dhaumya': '🛕',
    'purochana': '🏗️',

    // UNIQUE CHARACTERS (91-100)
    'shalva': '👤', 'uttanka': '📖', 'shrutakarma': '👶', 'prativindhya': '👶',
    'sutasoma': '👶',
    'shatanika': '👶', 'shrutasena': '👶', 'ashwathama_horse': '🐎',
    'takshaka': '🐍', 'eklavya_dog': '🐕',
  };

  /// Get character color for theming
  static Color getCharacterColor(String characterName) {
    final imageData = _characterImages[characterName.toLowerCase()] ??
        _characterImages['default']!;
    return (imageData['gradient'] as List<Color>)[0];
  }
}
