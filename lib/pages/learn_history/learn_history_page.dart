import 'package:flutter/material.dart';

class LearnHistoryPage extends StatelessWidget {
  const LearnHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepPurple.shade400,
      appBar: AppBar(
        title: const Text("📖 Learn History"),
        backgroundColor: const Color(0xFF4A2C8F),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Explore Historical Knowledge:",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFD700),
              ),
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
              text: "👑 Historical Figures Info",
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
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A2C8F), Color(0xFF6A3FB8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFFFFD700), width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD700).withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
