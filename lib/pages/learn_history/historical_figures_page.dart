import 'package:flutter/material.dart';

class HistoricalFiguresPage extends StatelessWidget {
  const HistoricalFiguresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("👑 Historical Figures & Wars")),
      body: const Center(
        child: Text(
          "Learn about Prithvi Narayan Shah, wars, and more here.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
