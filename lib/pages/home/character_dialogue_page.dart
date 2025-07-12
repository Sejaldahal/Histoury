import 'package:flutter/material.dart';

class CharacterDialoguePage extends StatefulWidget {
  const CharacterDialoguePage({super.key});

  @override
  State<CharacterDialoguePage> createState() => _CharacterDialoguePageState();
}

class _CharacterDialoguePageState extends State<CharacterDialoguePage> {
  bool showGameOptions = false; // controls submenu toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          SizedBox.expand(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // DARK OVERLAY
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          // MAIN CONTENT
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                // LEFT: Dialogue + Buttons
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // DIALOGUE BOX
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.deepPurple, width: 2),
                        ),
                        child: const Text(
                          "Greetings, young explorer! I am Prithvi Narayan Shah.\nWhat would you like to do?",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),

                      OptionButton(
                        text: "🎮 Play Games",
                        onTap: () {
                          Navigator.pushNamed(context, '/games');
                        },
                      ),


                      const SizedBox(height: 20),

                      // 📖 Learn History
                      OptionButton(
                        text: "📖 Learn History",
                        onTap: () {
                          Navigator.pushNamed(context, '/history');
                        },
                      ),

                      const SizedBox(height: 10),

                      // 🕰 Explore Timeline
                      OptionButton(
                        text: "3D Fieldtrip",
                        onTap: () {
                          Navigator.pushNamed(context, '/ar');
                        },
                      ),
                    ],

                  ),
                ),

                // RIGHT: Character
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/images/prithivi_narayan.jpg',
                      height: 400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Main option button
class OptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const OptionButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade400,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// Sub option (for submenu)
class SubOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SubOptionButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade200,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white70),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
