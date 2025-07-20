import 'package:flutter/material.dart';

class CrashTestButton extends StatelessWidget {
  const CrashTestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        throw Exception('Test Crash for Firebase Crashlytics');
      },
      child: Text('Crash Test!'),
    );
  }
}