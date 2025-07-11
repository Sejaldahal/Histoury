import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🎮 Games Menu")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose a Game to Play:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // 🧠 Quiz
            GameOptionButton(
              text: "🧠 Take Quiz",
              onTap: () => Navigator.pushNamed(context, '/quiz'),
            ),

            const SizedBox(height: 16),

            // 🧩 Puzzle
            GameOptionButton(
              text: "🧩 Solve Puzzle",
              onTap: () => Navigator.pushNamed(context, '/puzzle'),
            ),

            const SizedBox(height: 16),

            // 🔤 Word Match (optional future idea)
            GameOptionButton(
              text: "🔤 Word Match",
              onTap: () {
                // Add navigation when ready
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Coming soon!")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GameOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GameOptionButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade400,
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
