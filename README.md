# 🕉️ Mahabharata Wisdom - Flutter App

## ✨ Completely Rebuilt - Clean & Simple

This is a **fresh, clean Flutter project** built from scratch with minimal configuration to avoid Gradle issues.

## 🎯 What's Included

- ✅ 8 Mahabharata characters with full stories
- ✅ 5 Daily quotes (Sanskrit shlokas)
- ✅ Bilingual support (English & Hindi)
- ✅ Text-to-Speech narration
- ✅ Settings (Font size, Theme, Language)
- ✅ Clean, minimal configuration
- ✅ No complex Gradle setup

## 🚀 Quick Setup (3 Steps)

### Step 1: Prerequisites

Make sure you have:
- Flutter 3.0+ installed
- Android Studio or VS Code
- Java 11 or higher

Check your setup:
```bash
flutter doctor
```

### Step 2: Get the App

```bash
# Extract the project
cd mahabharata_wisdom

# Install dependencies
flutter pub get
```

### Step 3: Run

```bash
# Run on connected device/emulator
flutter run
```

That's it! 🎉

## 📱 Build for Release

### Android APK
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

## 🗂️ Project Structure

```
mahabharata_wisdom/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/                   # Data models
│   │   ├── character.dart        # Character & Quote models
│   │   └── app_settings.dart     # Settings provider
│   ├── services/                 # Business logic
│   │   ├── data_service.dart     # Data loading
│   │   └── tts_service.dart      # Text-to-speech
│   ├── screens/                  # UI screens
│   │   ├── home_screen.dart
│   │   ├── character_detail_screen.dart
│   │   └── settings_screen.dart
│   └── widgets/                  # Reusable components
│       ├── character_card.dart
│       └── quote_card.dart
└── assets/
    └── data/
        └── mahabharata_characters.json  # All content
```

## 🎨 Features

### Home Screen
- Daily character card
- Daily quote card
- Language switcher
- Settings access

### Character Detail
- Full story
- Life lesson
- Sacred verse (shloka)
- Text-to-speech
- Next character navigation

### Settings
- Font size (Small/Medium/Large)
- Theme (Light/Dark)
- Language (English/Hindi)
- Share functionality

## 🔧 Troubleshooting

### "Flutter not found"
```bash
# Add Flutter to PATH
export PATH="$PATH:/path/to/flutter/bin"
```

### "No devices found"
```bash
# Start Android emulator
flutter emulators
flutter emulators --launch <emulator-id>

# Or connect physical device with USB debugging enabled
```

### "Gradle build failed"
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### "Java version error"
Make sure you have Java 11 or higher:
```bash
java -version
```

## 📊 Testing

Run the app and verify:
- [ ] Home screen displays
- [ ] Character card shows today's character
- [ ] Quote card shows today's quote
- [ ] Tap character opens detail screen
- [ ] TTS button plays audio
- [ ] Settings screen opens
- [ ] Language switch works
- [ ] Theme switch works
- [ ] Font size changes work

## 🎯 Why This Version is Better

### Previous Issues (Fixed):
- ❌ Complex Gradle configuration → ✅ Let Flutter handle it
- ❌ Manual Android setup → ✅ Use Flutter defaults
- ❌ Version conflicts → ✅ Latest stable versions
- ❌ Too many files → ✅ Minimal, clean structure

### This Version:
- ✅ Uses Flutter's default Android configuration
- ✅ Minimal custom setup
- ✅ Latest stable package versions
- ✅ Clean, organized code
- ✅ No Gradle headaches

## 🔄 How Daily Rotation Works

**Characters**: Rotate based on day of year (1-365)
- Day 1 = Krishna
- Day 2 = Arjuna
- Day 3 = Karna
- etc.

**Quotes**: Random, but no repeats within same month
- Resets each month
- Shows all 5 before repeating

## 🌐 Adding More Content

Edit `assets/data/mahabharata_characters.json`:

```json
{
  "characters": [
    {
      "id": 9,
      "name": {"en": "New Character", "hi": "नया पात्र"},
      "key_traits": {"en": "Trait", "hi": "गुण"},
      "life_lesson": {"en": "Lesson", "hi": "पाठ"},
      "story": {"en": "Story...", "hi": "कहानी..."},
      "shloka": {
        "sanskrit": "Sanskrit verse",
        "transliteration": "Roman text",
        "meaning": {"en": "English", "hi": "हिंदी"},
        "reference": "Source"
      }
    }
  ]
}
```

## 💡 Tips

1. **Hot Reload**: Press `r` while app is running to see changes instantly
2. **Full Restart**: Press `R` for full app restart
3. **Quit**: Press `q` to quit

## 📦 Dependencies

- `provider` - State management
- `shared_preferences` - Local storage
- `flutter_tts` - Text-to-speech
- `share_plus` - Share functionality

All dependencies are tested and compatible.

## ✅ Success Indicators

You'll know it works when:
```
✓ Built build/app/outputs/flutter-apk/app-debug.apk
Installing...
```

And you see the orange-themed home screen with character and quote cards!

## 🎉 That's It!

This is a **clean, working Flutter app** with no complex configuration. Just run `flutter pub get` and `flutter run`!

---

**Built with Flutter 💙 | Ancient Wisdom Meets Modern Technology 🕉️**
