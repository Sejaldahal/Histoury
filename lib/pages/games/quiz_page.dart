// // quiz_page.dart (Updated)
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class QuizPage extends StatefulWidget {
//   final String selectedCategory;
//
//   const QuizPage({super.key, required this.selectedCategory});
//
//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }
//
// class _QuizPageState extends State<QuizPage> {
//   List _allQuestions = [];
//   List _filteredQuestions = [];
//   int _currentIndex = 0;
//   int _score = 0;
//   bool _answered = false;
//   int? _selectedIndex;
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadQuestions();
//   }
//
//   Future<void> loadQuestions() async {
//     try {
//       String data = await rootBundle.loadString('assets/questions.json');
//       _allQuestions = json.decode(data);
//       final category = widget.selectedCategory;
//
//       List filtered = _allQuestions.where((q) => q['category'] == category).toList();
//
//       if (filtered.isEmpty) {
//         // If no questions found for the category, show error
//         setState(() {
//           _isLoading = false;
//         });
//         return;
//       }
//
//       filtered.shuffle(); // shuffle each time
//       setState(() {
//         _filteredQuestions = filtered.take(5).toList(); // 5 random questions
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _checkAnswer(int selected) {
//     if (_answered) return;
//
//     setState(() {
//       _selectedIndex = selected;
//       _answered = true;
//       if (selected == _filteredQuestions[_currentIndex]['correct']) {
//         _score++;
//       }
//     });
//   }
//
//   void _nextQuestion() {
//     if (_currentIndex < _filteredQuestions.length - 1) {
//       setState(() {
//         _currentIndex++;
//         _answered = false;
//         _selectedIndex = null;
//       });
//     } else {
//       // Quiz completed, show results
//       _showResults();
//     }
//   }
//
//   void _showResults() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: const Text("Quiz Completed!"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               _score >= 3 ? Icons.celebration : Icons.thumb_up,
//               size: 60,
//               color: _score >= 3 ? Colors.green : Colors.orange,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "Your Score: $_score / ${_filteredQuestions.length}",
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               _score >= 4 ? "Excellent!" :
//               _score >= 3 ? "Good job!" :
//               _score >= 2 ? "Not bad!" : "Keep practicing!",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: _score >= 3 ? Colors.green : Colors.orange,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close dialog
//               Navigator.of(context).pop(); // Go back to category page
//             },
//             child: const Text("Back to Categories"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close dialog
//               // Restart quiz
//               setState(() {
//                 _currentIndex = 0;
//                 _score = 0;
//                 _answered = false;
//                 _selectedIndex = null;
//               });
//               loadQuestions();
//             },
//             child: const Text("Play Again"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Scaffold(
//         appBar: AppBar(title: Text("${widget.selectedCategory} Quiz")),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     if (_filteredQuestions.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(title: Text("${widget.selectedCategory} Quiz")),
//         body: const Center(
//           child: Text(
//             "No questions available for this category.",
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       );
//     }
//
//     var q = _filteredQuestions[_currentIndex];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${widget.selectedCategory} Quiz"),
//         backgroundColor: Colors.deepPurple.shade400,
//         foregroundColor: Colors.white,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.deepPurple.shade100, Colors.blue.shade100],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Progress bar
//               LinearProgressIndicator(
//                 value: (_currentIndex + 1) / _filteredQuestions.length,
//                 backgroundColor: Colors.white54,
//                 color: Colors.deepPurple.shade400,
//                 minHeight: 8,
//               ),
//               const SizedBox(height: 20),
//
//               // Score display
//               Text(
//                 "Score: $_score / ${_filteredQuestions.length}",
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepPurple,
//                 ),
//               ),
//               const SizedBox(height: 10),
//
//               // Question number
//               Text(
//                 "Question ${_currentIndex + 1} of ${_filteredQuestions.length}",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Question card
//               Card(
//                 elevation: 8,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Text(
//                     q['question'],
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Answer options
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: q['answers'].length,
//                   itemBuilder: (context, index) {
//                     Color buttonColor = Colors.white;
//                     Color textColor = Colors.black87;
//
//                     if (_answered) {
//                       if (index == q['correct']) {
//                         buttonColor = Colors.green;
//                         textColor = Colors.white;
//                       } else if (index == _selectedIndex) {
//                         buttonColor = Colors.red;
//                         textColor = Colors.white;
//                       }
//                     }
//
//                     return Container(
//                       margin: const EdgeInsets.symmetric(vertical: 6),
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: buttonColor,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 4,
//                         ),
//                         onPressed: _answered ? null : () => _checkAnswer(index),
//                         child: Text(
//                           q['answers'][index],
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: textColor,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Next button
//               if (_answered)
//                 Center(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.deepPurple.shade400,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 32,
//                         vertical: 12,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                     onPressed: _nextQuestion,
//                     child: Text(
//                       _currentIndex < _filteredQuestions.length - 1 ? "Next Question" : "Finish Quiz",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// quiz_page.dart (Updated)
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizPage extends StatefulWidget {
  final String selectedCategory;

  const QuizPage({super.key, required this.selectedCategory});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List _allQuestions = [];
  List _filteredQuestions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedIndex;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      String data = await rootBundle.loadString('assets/questions.json');
      _allQuestions = json.decode(data);
      final category = widget.selectedCategory;

      List filtered = _allQuestions.where((q) => q['category'] == category).toList();

      if (filtered.isEmpty) {
        // If no questions found for the category, show error
        setState(() {
          _isLoading = false;
        });
        return;
      }

      filtered.shuffle(); // shuffle each time
      setState(() {
        _filteredQuestions = filtered.take(5).toList(); // 5 random questions
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _checkAnswer(int selected) {
    if (_answered) return;

    setState(() {
      _selectedIndex = selected;
      _answered = true;
      if (selected == _filteredQuestions[_currentIndex]['correct']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _filteredQuestions.length - 1) {
      setState(() {
        _currentIndex++;
        _answered = false;
        _selectedIndex = null;
      });
    } else {
      // Quiz completed, show results
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Quiz Completed!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _score >= 3 ? Icons.celebration : Icons.thumb_up,
              size: 60,
              color: _score >= 3 ? Colors.green : Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              "Your Score: $_score / ${_filteredQuestions.length}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _score >= 4 ? "Excellent!" :
              _score >= 3 ? "Good job!" :
              _score >= 2 ? "Not bad!" : "Keep practicing!",
              style: TextStyle(
                fontSize: 16,
                color: _score >= 3 ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to category page
            },
            child: const Text("Back to Categories"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              // Restart quiz
              setState(() {
                _currentIndex = 0;
                _score = 0;
                _answered = false;
                _selectedIndex = null;
              });
              loadQuestions();
            },
            child: const Text("Play Again"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("${widget.selectedCategory} Quiz")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_filteredQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("${widget.selectedCategory} Quiz")),
        body: const Center(
          child: Text(
            "No questions available for this category.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    var q = _filteredQuestions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.selectedCategory} Quiz"),
        backgroundColor: Colors.deepPurple.shade400,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              LinearProgressIndicator(
                value: (_currentIndex + 1) / _filteredQuestions.length,
                backgroundColor: Colors.white54,
                color: Colors.deepPurple.shade400,
                minHeight: 8,
              ),
              const SizedBox(height: 20),

              // Score display
              Text(
                "Score: $_score / ${_filteredQuestions.length}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),

              // Question number
              Text(
                "Question ${_currentIndex + 1} of ${_filteredQuestions.length}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),

              // Question card
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    q['question'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Answer options
              Expanded(
                child: ListView.builder(
                  itemCount: q['answers'].length,
                  itemBuilder: (context, index) {
                    Color buttonColor = Colors.white;
                    Color textColor = Colors.black87;
                    Color borderColor = Colors.grey.shade300;
                    double borderWidth = 2.0;

                    if (_answered) {
                      if (index == q['correct']) {
                        buttonColor = Colors.green.shade50;
                        textColor = Colors.green.shade800;
                        borderColor = Colors.green;
                        borderWidth = 3.0;
                      } else if (index == _selectedIndex) {
                        buttonColor = Colors.red.shade50;
                        textColor = Colors.red.shade800;
                        borderColor = Colors.red;
                        borderWidth = 3.0;
                      }
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: borderColor,
                            width: borderWidth,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: _answered ? null : () => _checkAnswer(index),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                              child: Text(
                                q['answers'][index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Next button
              if (_answered)
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade400,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: _nextQuestion,
                    child: Text(
                      _currentIndex < _filteredQuestions.length - 1 ? "Next Question" : "Finish Quiz",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
