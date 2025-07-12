import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  final int size = 3;
  List<int> tiles = [];
  bool started = false;
  bool completed = false;
  int seconds = 0;
  Timer? timer;
  late ConfettiController _confettiController;
  ui.Image? fullImage;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _loadImage();
  }

  void _loadImage() async {
    final data = await rootBundle.load('assets/images/prithvi-narayan-shah_painting.jpg');
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);
    setState(() {
      fullImage = image;
      _initPuzzle();
    });
  }

  void _initPuzzle() {
    tiles = List.generate(size * size, (i) => i);
    do {
      tiles.shuffle();
    } while (!_isSolvable(tiles) || _isSolved());

    seconds = 0;
    completed = false;
    started = false;
    timer?.cancel();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        seconds++;
      });
    });
  }

  void _onTileTap(int index) {
    if (!started || completed) return;

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
        setState(() {
          completed = true;
        });
        timer?.cancel();
        _confettiController.play();
      }
    }
  }

  bool _isSolved() {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) return false;
    }
    return tiles.last == 0;
  }

  bool _isSolvable(List<int> list) {
    int invCount = 0;
    for (int i = 0; i < list.length; i++) {
      for (int j = i + 1; j < list.length; j++) {
        if (list[i] != 0 && list[j] != 0 && list[i] > list[j]) {
          invCount++;
        }
      }
    }
    return invCount % 2 == 0;
  }

  Widget _buildTile(int tileValue, double tileSize) {
    if (tileValue == 0) return const SizedBox.shrink();

    return CustomPaint(
      size: Size(tileSize, tileSize),
      painter: PuzzleTilePainter(
        image: fullImage!,
        tileValue: tileValue,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (fullImage == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double tileSize = screenWidth / size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sliding Puzzle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _initPuzzle();
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          if (completed)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: false,
                    colors: const [Colors.green, Colors.blue, Colors.pink],
                  ),
                  const Text(
                    "🎉 Congratulations! 🎉",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!started) ...[
                  SizedBox(
                    width: tileSize * size,
                    height: tileSize * size,
                    child: RawImage(image: fullImage),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        started = true;
                        _startTimer();
                      });
                    },
                    child: const Text('Start Puzzle'),
                  ),
                ] else ...[
                  Text("⏱ Time: $seconds s"),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: tileSize * size,
                    height: tileSize * size,
                    child: Stack(
                      children: List.generate(size * size, (index) {
                        int tileValue = tiles[index];
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
                                border: Border.all(color: Colors.white, width: 1),
                              ),
                              child: _buildTile(tileValue, tileSize),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PuzzleTilePainter extends CustomPainter {
  final ui.Image image;
  final int tileValue;
  final int size;

  PuzzleTilePainter({
    required this.image,
    required this.tileValue,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size tileSize) {
    int row = tileValue ~/ size;
    int col = tileValue % size;

    double srcTileWidth = image.width / size;
    double srcTileHeight = image.height / size;

    Rect src = Rect.fromLTWH(
      col * srcTileWidth,
      row * srcTileHeight,
      srcTileWidth,
      srcTileHeight,
    );

    Rect dst = Rect.fromLTWH(0, 0, tileSize.width, tileSize.height);

    Paint paint = Paint();
    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
