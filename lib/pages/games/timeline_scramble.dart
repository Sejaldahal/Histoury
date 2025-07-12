import 'package:flutter/material.dart';

class TimelineScramblePage extends StatefulWidget {
  const TimelineScramblePage({super.key});

  @override
  State<TimelineScramblePage> createState() => _TimelineScramblePageState();
}

class _TimelineScramblePageState extends State<TimelineScramblePage> {
  bool _showHint = false;

  final List<Map<String, String>> _correctOrder = [
    {'event': 'Prithvi Narayan Shah unifies Nepal', 'date': '1768'},
    {'event': 'Anglo-Nepalese War begins', 'date': '1814'},
    {'event': 'Sugauli Treaty signed', 'date': '1815'},
    {'event': 'Rana regime established', 'date': '1846'},
    {'event': 'Democracy established in Nepal', 'date': '1951'},
    {'event': 'Republic declared', 'date': '2008'},
    {'event': 'Maoist insurgency begins', 'date': '1996'},
    {'event': 'Comprehensive Peace Agreement signed', 'date': '2006'},
    {'event': 'Republic declared', 'date': '2008'},
  ];

  late List<Map<String, String>> _scrambledEvents;

  @override
  void initState() {
    super.initState();
    _scrambledEvents = List.from(_correctOrder)..shuffle();
  }

  void _checkOrder() {
    bool isCorrect = true;
    for (int i = 0; i < _scrambledEvents.length; i++) {
      if (_scrambledEvents[i]['event'] != _correctOrder[i]['event']) {
        isCorrect = false;
        break;
      }
    }

    if (isCorrect) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎉 Victory!'),
          content: const Text('You arranged the timeline correctly!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Oops! Not in the right order yet.')),
      );
    }
  }

  void _showHintWithDates() {
    setState(() {
      _showHint = true;
    });
  }

  void _resetGame() {
    setState(() {
      _scrambledEvents = List.from(_correctOrder)..shuffle();
      _showHint = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0E42),
      appBar: AppBar(
        title: const Text('Timeline Scramble'),
        backgroundColor: const Color(0xFF4A2C8F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _resetGame,
            icon: const Icon(Icons.refresh),
            tooltip: 'Shuffle',
          ),
          IconButton(
            onPressed: _showHintWithDates,
            icon: const Icon(Icons.lightbulb),
            tooltip: 'Show Hint',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReorderableListView.builder(
          itemCount: _scrambledEvents.length,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex -= 1;
              final item = _scrambledEvents.removeAt(oldIndex);
              _scrambledEvents.insert(newIndex, item);
            });
          },
          itemBuilder: (context, index) {
            final item = _scrambledEvents[index];
            return Card(
              key: ValueKey(item['event']),
              color: const Color(0xFF6A3FB8).withOpacity(0.9),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item['event']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showHint)
                      Text(
                        item['date']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.yellow[100],
                        ),
                      ),
                  ],
                ),
                // Removed the trailing drag handle icon
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _checkOrder,
        label: const Text("Check Order"),
        icon: const Icon(Icons.check),
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: Colors.black,
      ),
    );
  }
}