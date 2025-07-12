import 'package:flutter/material.dart';
import 'dart:math';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  final int size = 3; // 3x3 sliding puzzle
  late List<int> tiles;

  @override
  void initState() {
    super.initState();
    _initPuzzle();
  }

  void _initPuzzle() {
    tiles = List.generate(size * size, (i) => i);
    tiles.shuffle();
    setState(() {});
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
      body: Center(
        child: SizedBox(
          width: tileSize * size,
          height: tileSize * size,
          child: Stack(
            children: List.generate(size * size, (index) {
              int tileValue = tiles[index];
              if (tileValue == 0) return const SizedBox.shrink();

              int row = index ~/ size;
              int col = index % size;

              return Positioned(
                left: col * tileSize,
                top: row * tileSize,
                child: GestureDetector(
                  onTap: () => _onTileTap(index),
                  child: Container(
                    width: tileSize,
                    height: tileSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      image: DecorationImage(
                        image: const AssetImage('assets/images/prithvi-narayan-shah_painting.jpg'),
                        fit: BoxFit.cover,
                        alignment: Alignment(
                          (tileValue % size) / (size - 1) * 2 - 1,
                          (tileValue ~/ size) / (size - 1) * 2 - 1,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
