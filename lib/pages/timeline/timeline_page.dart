import 'package:flutter/material.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timeline"),
      ),
      body: const Center(
        child: Text(
          "🕰 Timeline Page - Coming Soon!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
