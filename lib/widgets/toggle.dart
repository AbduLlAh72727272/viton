import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization_service.dart';

class LanguageToggle extends StatefulWidget {
  @override
  _LanguageToggleState createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  String selectedLanguage = 'en'; // Default selection (English)
  final LocalizationService localizationService = LocalizationService();

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference(); // Load last selected language
  }

  // Load language preference from storage
  Future<void> _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('selectedLanguage') ?? 'en';
    setState(() {
      selectedLanguage = lang;
    });
  }

  // Switch languages and save preference
  void _switchLanguage(String langCode) async {
    await localizationService.saveLanguage(langCode);
    localizationService.changeLocale(langCode);

    setState(() {
      selectedLanguage = langCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Smaller border radius
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLanguage,
          icon: Icon(Icons.language, color: Colors.black, size: 20), // Smaller icon
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          onChanged: (String? newLang) {
            if (newLang != null) {
              _switchLanguage(newLang);
            }
          },
          items: [
            DropdownMenuItem(
              value: 'en',
              child: Row(
                children: [
                  Text("🇺🇸", style: TextStyle(fontSize: 14)), // Smaller flag
                  SizedBox(width: 5),
                  Text("EN", style: TextStyle(fontSize: 14)), // Shorter text
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'el',
              child: Row(
                children: [
                  Text("🇬🇷", style: TextStyle(fontSize: 14)), // Smaller flag
                  SizedBox(width: 5),
                  Text("GR", style: TextStyle(fontSize: 14)), // Shorter text
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
