import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';

class HistoricalFigure {
  final String name;
  final String hint;
  final String imagePath;

  HistoricalFigure({required this.name, required this.hint, required this.imagePath});
}

class GuessWhoGame extends StatefulWidget {
  const GuessWhoGame({Key? key}) : super(key: key);

  @override
  State<GuessWhoGame> createState() => _GuessWhoGameState();
}

class _GuessWhoGameState extends State<GuessWhoGame> {
  final List<HistoricalFigure> _figures = [
    HistoricalFigure(
      name: "Prithvi Narayan Shah",
      hint: "Led the unification of Nepal.",
      imagePath: "assets/images/prithivi_narayan.jpg",
    ),
    HistoricalFigure(
      name: "B.P. Koirala",
      hint: "Nepal's first democratic prime minister.",
      imagePath: "assets/images/bpkoirala.jpg",
    ),
    HistoricalFigure(
      name: "Araniko",
      hint: "Architect of the White Pagoda in China.",
      imagePath: "assets/images/araniko.jpg",
    ),
    HistoricalFigure(
      name: "Amar Singh Thapa",
      hint: "One of the greatest warriors of Nepal.",
      imagePath: "assets/images/amarsingh.jpg",
    ),
    // Add more as needed
  ];

  late HistoricalFigure currentFigure;
  late List<HistoricalFigure> options;
  bool answered = false;
  bool isCorrect = false;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 2));
    _loadNewQuestion();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _loadNewQuestion() {
    final rnd = Random();
    currentFigure = _figures[rnd.nextInt(_figures.length)];
    final shuffled = List<HistoricalFigure>.from(_figures)..shuffle();
    options = [currentFigure, ...shuffled.where((f) => f.name != currentFigure.name).take(3)];
    options.shuffle();
    answered = false;
    isCorrect = false;
  }

  void _checkAnswer(HistoricalFigure selected) {
    setState(() {
      answered = true;
      isCorrect = selected.name == currentFigure.name;
      if (isCorrect) _confettiController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text("Guess Who?"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hint:",
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.deepPurple, width: 2),
                  ),
                  child: Text(
                    currentFigure.hint,
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: options.map((figure) {
                      final selected = answered && figure.name == currentFigure.name;
                      return GestureDetector(
                        onTap: answered ? null : () => _checkAnswer(figure),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: answered
                                  ? (figure.name == currentFigure.name
                                  ? Colors.green
                                  : Colors.red.shade200)
                                  : Colors.deepPurple,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    figure.imagePath,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  figure.name,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.deepPurple.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                if (answered)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _loadNewQuestion();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: Text("Next", style: TextStyle(color: Colors.white)),
                    ),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
