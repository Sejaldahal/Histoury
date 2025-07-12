// // import 'dart:convert';
// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// //
// // class QuizPage extends StatefulWidget {
// //   final String selectedCategory;
// //
// //   const QuizPage({super.key, required this.selectedCategory});
// //
// //   @override
// //   State<QuizPage> createState() => _QuizPageState();
// // }
// //
// // class _QuizPageState extends State<QuizPage> {
// //   List _allQuestions = [];
// //   List _filteredQuestions = [];
// //   int _currentIndex = 0;
// //   int _score = 0;
// //   bool _answered = false;
// //   int? _selectedIndex;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     loadQuestions();
// //   }
// //
// //   Future<void> loadQuestions() async {
// //     String data = await rootBundle.loadString('assets/questions.json');
// //     _allQuestions = json.decode(data);
// //     final category = widget.selectedCategory;
// //
// //     List filtered = _allQuestions.where((q) => q['category'] == category).toList();
// //
// //     filtered.shuffle(); // shuffle each time
// //     setState(() {
// //       _filteredQuestions = filtered.take(5).toList(); // 5 random questions
// //     });
// //   }
// //
// //   void _checkAnswer(int selected) {
// //     if (_answered) return;
// //
// //     setState(() {
// //       _selectedIndex = selected;
// //       _answered = true;
// //       if (selected == _filteredQuestions[_currentIndex]['correct']) {
// //         _score++;
// //       }
// //     });
// //   }
// //
// //   void _nextQuestion() {
// //     setState(() {
// //       _currentIndex++;
// //       _answered = false;
// //       _selectedIndex = null;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     if (_filteredQuestions.isEmpty) {
// //       return Scaffold(
// //         appBar: AppBar(title: Text("Quiz")),
// //         body: Center(child: CircularProgressIndicator()),
// //       );
// //     }
// //
// //     if (_currentIndex >= _filteredQuestions.length) {
// //       return Scaffold(
// //         appBar: AppBar(title: Text("Quiz Completed")),
// //         body: Center(
// //           child: Text(
// //             "You scored $_score / ${_filteredQuestions.length}",
// //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //       );
// //     }
// //
// //     var q = _filteredQuestions[_currentIndex];
// //
// //     return Scaffold(
// //       appBar: AppBar(title: Text("${widget.selectedCategory} Quiz")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text("Score: $_score / ${_filteredQuestions.length}",
// //                 style: TextStyle(fontSize: 16)),
// //             const SizedBox(height: 10),
// //             Text(
// //               "Q${_currentIndex + 1}: ${q['question']}",
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
// //             ),
// //             const SizedBox(height: 20),
// //             ...List.generate(q['answers'].length, (index) {
// //               Color color = Colors.grey[200]!;
// //               if (_answered) {
// //                 if (index == q['correct']) {
// //                   color = Colors.green;
// //                 } else if (index == _selectedIndex) {
// //                   color = Colors.red;
// //                 }
// //               }
// //
// //               return GestureDetector(
// //                 onTap: () => _checkAnswer(index),
// //                 child: Container(
// //                   margin: EdgeInsets.symmetric(vertical: 8),
// //                   padding: EdgeInsets.all(12),
// //                   decoration: BoxDecoration(
// //                     color: color,
// //                     borderRadius: BorderRadius.circular(12),
// //                     border: Border.all(color: Colors.black12),
// //                   ),
// //                   child: Text(
// //                     q['answers'][index],
// //                     style: TextStyle(fontSize: 16),
// //                   ),
// //                 ),
// //               );
// //             }),
// //             const SizedBox(height: 20),
// //             if (_answered)
// //               Center(
// //                 child: ElevatedButton(
// //                   onPressed: _nextQuestion,
// //                   child: Text(_currentIndex < _filteredQuestions.length - 1
// //                       ? "Next"
// //                       : "Finish"),
// //                 ),
// //               )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// // quiz_category_page.dart
// import 'package:flutter/material.dart';
// import 'quiz_page.dart';
//
// class QuizCategoryPage extends StatelessWidget {
//   const QuizCategoryPage({super.key});
//
//   final List<String> categories = const [
//     "Historical Figures",
//     "Historical Sites",
//     "Nepalese History Timeline",
//     "World History",
//     "Festivals and Traditions",
//     "Random"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("🧠 Choose Quiz Category"),
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
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Select a Category:",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: categories.length,
//                   itemBuilder: (context, index) {
//                     return CategoryButton(
//                       text: categories[index],
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => QuizPage(
//                               selectedCategory: categories[index],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
//
//   const CategoryButton({super.key, required this.text, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
//           decoration: BoxDecoration(
//             color: Colors.deepPurple.shade400,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.white, width: 2),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Text(
//             text,
//             style: const TextStyle(
//               fontSize: 18,
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// quiz_category_page.dart
import 'package:flutter/material.dart';
import 'quiz_page.dart';

class QuizCategoryPage extends StatelessWidget {
  const QuizCategoryPage({super.key});

  final List<String> categories = const [
    "Historical Figures",
    "Historical Sites",
    "Nepalese History Timeline",
    "World History",
    "Festivals and Traditions",
    "Random"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🧠 Choose Quiz Category"),
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select a Category:",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryButton(
                      text: categories[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizPage(
                              selectedCategory: categories[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CategoryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade400,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
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
            ),
          ),
        ),
      ),
    );
  }
}

