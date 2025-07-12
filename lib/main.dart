import 'package:flutter/material.dart';
import 'pages/home/character_dialogue_page.dart';
import 'pages/games/quiz_page.dart';
import 'pages/games/puzzle_page.dart';
import 'pages/learn_history/historical_figures_page.dart';
import 'pages/learn_history/temples_page.dart';
import 'pages/learn_history/learn_history_page.dart';

import 'pages/ar/screen_ar.dart';
import 'pages/games/quiz_category_page.dart';
import 'pages/splash/splash_screen.dart';
import 'pages/splash/page1.dart';

import 'pages/games/match_game_page.dart';
import 'pages/ar/screen_ar.dart';
import 'pages/games/quiz_category_page.dart';
import 'pages/games/guesswho.dart';




import 'pages/games/games_page.dart';
import 'pages/learn_history/temples_page.dart';
import 'pages/learn_history/historical_figures_page.dart';
import 'pages/timeline/timeline_page.dart';
import 'pages/home/character_dialogue_page.dart';
import 'pages/splash/page1.dart';

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
      initialRoute: '/splash', // Changed to start with splash screen
      routes: {
        '/splash': (context) => SplashScreen(),
        '/page1': (context) => const Page1(),
        '/': (context) => const CharacterDialoguePage(),
        '/games': (context) => const GamesPage(),
        '/quiz-categories': (context) => const QuizCategoryPage(),
        '/puzzle': (context) => const PuzzlePage(),
        '/learn_history': (context) => const TemplesPage(),
        '/history': (context) => const LearnHistoryPage(),
        '/temples': (context) => const TemplesPage(),
        '/figures': (context) => const HistoricalFiguresPage(),
        '/ar': (context) => const ARModelsListScreen(),

        '/match': (context) => MatchGamePage(),
        '/guesswho': (context) => GuessWhoGame(),







      },
    );
  }
}