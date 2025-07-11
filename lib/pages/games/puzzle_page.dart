import 'package:flutter/material.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Puzzle"),
      ),
      body: const Center(
        child: Text(
          "🧩 Puzzle Page - Coming Soon!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
