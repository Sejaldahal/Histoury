import 'package:flutter/material.dart';

class LearnHistoryPage extends StatelessWidget {
  const LearnHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📖 Learn History")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Explore Historical Knowledge:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // 🛕 Temples
            HistoryOptionButton(
              text: "🛕 Temples",
              onTap: () => Navigator.pushNamed(context, '/temples'),
            ),

            const SizedBox(height: 20),

            // 👑 Historical Figures
            HistoryOptionButton(
              text: "👑 Historical Figures & Wars",
              onTap: () => Navigator.pushNamed(context, '/figures'),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const HistoryOptionButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.teal.shade600,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}