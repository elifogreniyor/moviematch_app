import 'package:flutter/material.dart';

class FloatingLanguageButton extends StatelessWidget {
  final void Function(Locale) onLocaleChanged;
  final Locale currentLocale;

  const FloatingLanguageButton({
    super.key,
    required this.onLocaleChanged,
    required this.currentLocale,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 70),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Material(
            color: Colors.black.withOpacity(0.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Text(
                    'TR',
                    style: TextStyle(
                      color: currentLocale.languageCode == 'tr'
                          ? Colors.amber
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => onLocaleChanged(const Locale('tr')),
                ),
                IconButton(
                  icon: Text(
                    'EN',
                    style: TextStyle(
                      color: currentLocale.languageCode == 'en'
                          ? Colors.amber
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => onLocaleChanged(const Locale('en')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
