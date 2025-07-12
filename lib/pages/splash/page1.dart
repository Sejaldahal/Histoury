import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'dart:math' as math;

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with TickerProviderStateMixin {
  late final AudioPlayer _audioPlayer;
  late final AnimationController _personController;
  late final AnimationController _greetingController;

  late final Animation<double> _personSlideAnimation;
  late final Animation<double> _personScaleAnimation;
  late final Animation<double> _personFadeAnimation;
  late final Animation<double> _greetingSlideAnimation;
  late final Animation<double> _greetingScaleAnimation;
  late final Animation<double> _greetingFadeAnimation;

  bool _showGreeting = false;
  Timer? _greetingTimer;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    // Person animation controller
    _personController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Greeting animation controller
    _greetingController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Person animations
    _personSlideAnimation = Tween<double>(
      begin: -300.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _personController,
      curve: Curves.elasticOut,
    ));

    _personScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _personController,
      curve: Curves.bounceOut,
    ));

    _personFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _personController,
      curve: Curves.easeInOut,
    ));

    // Greeting animations
    _greetingSlideAnimation = Tween<double>(
      begin: 100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _greetingController,
      curve: Curves.bounceOut,
    ));

    _greetingScaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _greetingController,
      curve: Curves.elasticOut,
    ));

    _greetingFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _greetingController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimationSequence() {
    // Start person animation
    _personController.forward();

    // Play audio and show greeting after 20ms
    _greetingTimer = Timer(const Duration(milliseconds: 20), () {
      setState(() {
        _showGreeting = true;
      });
      _greetingController.forward();
      _playAudio();
    });

    // Navigate to next page after 7 seconds
    _navigationTimer = Timer(const Duration(seconds: 10), () {
      _goToDialoguePage();
    });
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.play(AssetSource('greetings.wav'));
    } catch (e) {
      debugPrint("Audio play error: $e");
    }
  }

  @override
  void dispose() {
    _personController.dispose();
    _greetingController.dispose();
    _audioPlayer.dispose();
    _greetingTimer?.cancel();
    _navigationTimer?.cancel();
    super.dispose();
  }

  void _goToDialoguePage() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: _goToDialoguePage,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated Person Image
              AnimatedBuilder(
                animation: _personController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_personSlideAnimation.value, 0),
                    child: Transform.scale(
                      scale: _personScaleAnimation.value,
                      child: Opacity(
                        opacity: _personFadeAnimation.value,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/person.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.withOpacity(0.1),
                                  child: const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              // Animated Greeting Dialog
              if (_showGreeting)
                AnimatedBuilder(
                  animation: _greetingController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _greetingSlideAnimation.value),
                      child: Transform.scale(
                        scale: _greetingScaleAnimation.value,
                        child: Opacity(
                          opacity: _greetingFadeAnimation.value,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: Image.asset(
                              'assets/images/Greetings.png',
                              width: 250,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 250,
                                  height: 150,
                                  color: Colors.grey.withOpacity(0.1),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.waving_hand,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Welcome!',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

              const Spacer(),

              // Skip button - simple text button without decorations
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: TextButton(
                  onPressed: _goToDialoguePage,
                  child: const Text(
                    'Tap to continue',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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