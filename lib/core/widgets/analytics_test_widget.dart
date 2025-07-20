import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsTestButton extends StatelessWidget {
  const AnalyticsTestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseAnalytics.instance.logEvent(
          name: 'test_button_clicked',
          parameters: {'screen': 'home'},
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Event sent!')));
      },
      child: Text('Send Analytics Event'),
    );
  }
}
