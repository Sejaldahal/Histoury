import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import '../../models/match_pair.dart';
import 'dart:math';

class MatchGamePage extends StatefulWidget {
  @override
  _MatchGamePageState createState() => _MatchGamePageState();
}

class _MatchGamePageState extends State<MatchGamePage> {
  List<MatchPair> allPairs = [
    MatchPair(left: 'Prithvi Narayan Shah', right: 'Unification of Nepal'),
    MatchPair(left: '1846', right: 'Start of Rana Rule'),
    MatchPair(left: 'B.P. Koirala', right: '1st Democratic PM'),
    MatchPair(left: 'Swayambhunath', right: 'Kathmandu Valley'),
    MatchPair(left: 'Gorkha', right: 'Birthplace of Prithvi N. Shah'),
  ];

  List<String> leftItems = [];
  List<String> rightItems = [];

  String? selectedLeft;
  String? selectedRight;

  int score = 0;
  List<String> matched = [];
  List<String> wrongAttempt = [];

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    leftItems = allPairs.map((e) => e.left).toList()..shuffle();
    rightItems = allPairs.map((e) => e.right).toList()..shuffle();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void checkMatch() {
    if (selectedLeft == null || selectedRight == null) return;

    MatchPair? match = allPairs.firstWhere(
            (e) => e.left == selectedLeft && e.right == selectedRight,
        orElse: () => MatchPair(left: '', right: ''));

    if (match.left != '') {
      setState(() {
        score++;
        matched.add(selectedLeft!);
        matched.add(selectedRight!);
      });
    } else {
      setState(() {
        wrongAttempt.add(selectedLeft!);
        wrongAttempt.add(selectedRight!);
      });
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          wrongAttempt.clear();
        });
      });
    }

    setState(() {
      selectedLeft = null;
      selectedRight = null;
    });

    if (score == allPairs.length) {
      _confettiController.play();
    }
  }

  Widget buildTile(String text, bool isLeft) {
    final isSelected = isLeft ? selectedLeft == text : selectedRight == text;
    final isMatched = matched.contains(text);
    final isWrong = wrongAttempt.contains(text);

    Color bgColor = Colors.white;
    if (isMatched) bgColor = Colors.green;
    else if (isSelected) bgColor = Colors.deepPurple[100]!;
    else if (isWrong) bgColor = Colors.red[100]!;

    return GestureDetector(
      onTap: isMatched
          ? null
          : () {
        setState(() {
          if (isLeft) {
            selectedLeft = text;
            wrongAttempt.clear();
          } else {
            selectedRight = text;
          }
        });
        checkMatch();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Colors.deepPurple, width: 1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: isMatched ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildConfettiWidget() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
        maxBlastForce: 10,
        minBlastForce: 5,
        emissionFrequency: 0.05,
        numberOfParticles: 20,
        gravity: 0.2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F9),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Match & Learn',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Score: $score',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        children: leftItems.map((item) => buildTile(item, true)).toList(),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        children: rightItems.map((item) => buildTile(item, false)).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              if (score == allPairs.length)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "🎉 You did it!",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              SizedBox(height: 10),
            ],
          ),
          buildConfettiWidget(),
        ],
      ),
    );
  }
}