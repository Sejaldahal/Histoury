// // import 'package:flutter/material.dart';
// // import 'pages/home/character_dialogue_page.dart';
// // import 'pages/games/quiz_page.dart';
// // import 'pages/games/puzzle_page.dart';
// // import 'pages/history_page.dart';
// //
// //
// // import 'pages/games/games_page.dart';
// // import 'pages/games/quiz_page.dart';
// // import 'pages/games/puzzle_page.dart';
// //
// // import 'pages/learn_history/learn_history_page.dart';
// // import 'pages/learn_history/temples_page.dart';
// // import 'pages/learn_history/historical_figures_page.dart';
// //
// // import 'pages/timeline/timeline_page.dart';
// // import 'pages/home/character_dialogue_page.dart';
// //
// //
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Histoury',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //       ),
// //       initialRoute: '/',
// //       routes: {
// //         '/': (context) => const CharacterDialoguePage(),
// //         '/games': (context) => const GamesPage(),
// //         '/quiz': (context) => const QuizPage(),
// //         '/puzzle': (context) => const PuzzlePage(),
// //         '/history': (context) => const LearnHistoryPage(),
// //         '/temples': (context) => const TemplesPage(),
// //         '/figures': (context) => const HistoricalFiguresPage(),
// //         '/timeline': (context) => const TimelinePage(),
// //       },
// //     );
// //   }
// // }
//
//
// // main.dart (Updated)
// import 'package:flutter/material.dart';
// import 'pages/home/character_dialogue_page.dart';
// import 'pages/games/quiz_page.dart';
// import 'pages/games/quiz_category_page.dart';
// import 'pages/games/puzzle_page.dart';
// import 'pages/history_page.dart';
// import 'pages/games/games_page.dart';
// import 'pages/learn_history/learn_history_page.dart';
// import 'pages/learn_history/temples_page.dart';
// import 'pages/learn_history/historical_figures_page.dart';
// import 'pages/timeline/timeline_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Histoury',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const CharacterDialoguePage(),
//         '/games': (context) => const GamesPage(),
//         '/quiz-categories': (context) => const QuizCategoryPage(),
//         '/puzzle': (context) => const PuzzlePage(),
//         '/history': (context) => const LearnHistoryPage(),
//         '/temples': (context) => const TemplesPage(),
//         '/figures': (context) => const HistoricalFiguresPage(),
//         '/timeline': (context) => const TimelinePage(),
//       },
//     );
//   }
// }

// main.dart (Updated)
import 'package:flutter/material.dart';
import 'pages/home/character_dialogue_page.dart';
import 'pages/games/quiz_page.dart';
import 'pages/games/quiz_category_page.dart';
import 'pages/games/puzzle_page.dart';
import 'pages/history_page.dart';
import 'pages/games/games_page.dart';
import 'pages/learn_history/learn_history_page.dart';
import 'pages/learn_history/temples_page.dart';
import 'pages/learn_history/historical_figures_page.dart';
import 'pages/timeline/timeline_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Histoury',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CharacterDialoguePage(),
        '/games': (context) => const GamesPage(),
        '/quiz-categories': (context) => const QuizCategoryPage(),
        '/puzzle': (context) => const PuzzlePage(),
        '/history': (context) => const LearnHistoryPage(),
        '/temples': (context) => const TemplesPage(),
        '/figures': (context) => const HistoricalFiguresPage(),
        '/timeline': (context) => const TimelinePage(),
      },
    );
  }
}