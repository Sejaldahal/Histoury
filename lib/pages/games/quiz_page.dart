import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<dynamic> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final String jsonString = await rootBundle.loadString('assets/questions.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    setState(() {
      questions = jsonData;
      isLoading = false;
    });
  }

  void answerQuestion(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex]['correct'] as int) {
      score++;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correct!'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wrong!'), backgroundColor: Colors.red),
      );
    }

    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Quiz Finished!'),
        content: Text('Your score: $score / ${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
              setState(() {
                currentQuestionIndex = 0;
                score = 0;
              });
            },
            child: const Text('Restart'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
              Navigator.of(context).pop(); // exit quiz page
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1} of ${questions.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              question['question'] as String,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...(question['answers'] as List<dynamic>).asMap().entries.map(
                  (entry) {
                int idx = entry.key;
                String answerText = entry.value.toString();

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(idx),
                    child: Text(answerText),
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
