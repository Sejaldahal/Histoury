import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: const Center(
        child: Text(
          "📖 History Page - Coming Soon!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
