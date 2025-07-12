import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  final int size = 3; // 3x3 puzzle
  late List<int> tiles;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _initPuzzle();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _initPuzzle() {
    tiles = List.generate(size * size, (i) => i);
    do {
      tiles.shuffle();
    } while (!_isSolvable(tiles) || _isSolved());
    setState(() {});
  }

  bool _isSolvable(List<int> list) {
    int inversions = 0;
    for (int i = 0; i < list.length; i++) {
      for (int j = i + 1; j < list.length; j++) {
        if (list[i] > list[j] && list[i] != 0 && list[j] != 0) {
          inversions++;
        }
      }
    }
    return inversions % 2 == 0;
  }

  bool _isSolved() {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) return false;
    }
    return tiles.last == 0;
  }

  void _onTileTap(int index) {
    int emptyIndex = tiles.indexOf(0);
    int row = index ~/ size;
    int col = index % size;
    int emptyRow = emptyIndex ~/ size;
    int emptyCol = emptyIndex % size;

    if ((row == emptyRow && (col - emptyCol).abs() == 1) ||
        (col == emptyCol && (row - emptyRow).abs() == 1)) {
      setState(() {
        tiles[emptyIndex] = tiles[index];
        tiles[index] = 0;
      });

      if (_isSolved()) {
        _confettiController.play();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("🎉 Congratulations! You solved the puzzle!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tileSize = screenWidth / size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sliding Puzzle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initPuzzle,
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: tileSize * size,
            height: tileSize * size,
            child: Stack(
              children: List.generate(size * size, (index) {
                int tileValue = tiles[index];
                if (tileValue == 0) return const SizedBox.shrink();

                int row = index ~/ size;
                int col = index % size;

                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  left: col * tileSize,
                  top: row * tileSize,
                  child: GestureDetector(
                    onTap: () => _onTileTap(index),
                    child: ClipRect(
                      child: SizedBox(
                        width: tileSize,
                        height: tileSize,
                        child: OverflowBox(
                          maxWidth: tileSize * size,
                          maxHeight: tileSize * size,
                          alignment: Alignment(
                            -1.0 + 2.0 * (tileValue % size) / (size - 1),
                            -1.0 + 2.0 * (tileValue ~/ size) / (size - 1),
                          ),
                          child: Image.asset(
                            'assets/images/prithvi-narayan-shah_painting.jpg',
                            width: tileSize * size,
                            height: tileSize * size,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 30,
              maxBlastForce: 20,
              minBlastForce: 5,
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
