// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// class CharacterDialoguePage extends StatefulWidget {
//   const CharacterDialoguePage({super.key});
//
//   @override
//   State<CharacterDialoguePage> createState() => _CharacterDialoguePageState();
// }
//
// class _CharacterDialoguePageState extends State<CharacterDialoguePage> {
//   bool showGameOptions = false; // controls submenu toggle
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // BACKGROUND IMAGE
//           SizedBox.expand(
//             child: Image.asset(
//               'assets/images/background.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//
//           // DARK OVERLAY
//           Container(
//             color: Colors.black.withOpacity(0.4),
//           ),
//
//           // MAIN CONTENT
//           Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Row(
//               children: [
//                 // LEFT: Dialogue + Buttons
//                 Expanded(
//                   flex: 2,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // DIALOGUE BOX
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         margin: const EdgeInsets.only(bottom: 20),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.9),
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: Colors.deepPurple, width: 2),
//                         ),
//                         child: const Text(
//                           "Greetings, young explorer! I am Prithvi Narayan Shah.\nWhat would you like to do?",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//
//                       OptionButton(
//                         text: "🎮 Play Games",
//                         onTap: () {
//                           Navigator.pushNamed(context, '/games');
//                         },
//                       ),
//
//
//                       const SizedBox(height: 20),
//
//                       // 📖 Learn History
//                       OptionButton(
//                         text: "📖 Learn History",
//                         onTap: () {
//                           Navigator.pushNamed(context, '/history');
//                         },
//                       ),
//
//                       const SizedBox(height: 10),
//
//                       // 🕰 Explore Timeline
//                       OptionButton(
//                         text: "3D Fieldtrip",
//                         onTap: () {
//                           Navigator.pushNamed(context, '/ar');
//                         },
//                       ),
//                     ],
//
//                   ),
//                 ),
//
//                 // RIGHT: Character
//                 Expanded(
//                   flex: 1,
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Image.asset(
//                       'assets/images/prithivi_narayan.jpg',
//                       height: 400,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Main option button
// class OptionButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
//
//   const OptionButton({super.key, required this.text, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 250,
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
//         decoration: BoxDecoration(
//           color: Colors.deepPurple.shade400,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.white, width: 2),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }
// }
//
// // Sub option (for submenu)
// class SubOptionButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
//
//   const SubOptionButton({super.key, required this.text, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 220,
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.deepPurple.shade200,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.white70),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class CharacterDialoguePage extends StatefulWidget {
  const CharacterDialoguePage({super.key});

  @override
  State<CharacterDialoguePage> createState() => _CharacterDialoguePageState();
}

class _CharacterDialoguePageState extends State<CharacterDialoguePage>
    with TickerProviderStateMixin {
  bool showGameOptions = false;
  late AudioPlayer _audioPlayer;
  bool _isMuted = false;
  bool _isPlaying = true;
  bool _showAudioControls = false;

  // Animation controllers
  late AnimationController _buttonAnimationController;
  late AnimationController _crownAnimationController;
  late AnimationController _backgroundAnimationController;
  late List<AnimationController> _individualButtonControllers;
  late List<Animation<double>> _buttonScaleAnimations;
  late List<Animation<double>> _buttonOpacityAnimations;
  late List<Animation<Offset>> _buttonSlideAnimations;
  late Animation<double> _crownRotationAnimation;
  late Animation<double> _crownScaleAnimation;
  late Animation<double> _backgroundShimmerAnimation;

  // Button data with royal icons
  final List<Map<String, dynamic>> buttonData = [
    {
      'text': '👑 Royal Games',
      'route': '/games',
      'icon': Icons.games,
    },
    {
      'text': '📜 Royal Chronicles',
      'route': '/history',
      'icon': Icons.history_edu,
    },
    {
      'text': '3D FieldTrip',
      'route': '/ar',
      'icon': Icons.timeline,
    },
  ];

  // Royal features data
  final List<Map<String, dynamic>> royalFeatures = [
    {
      'text': '🏰 Royal Palace',
      'subtitle': 'Explore the magnificent palace',
      'route': '/palace',
      'icon': Icons.castle,
    },
    {
      'text': '👑 Crown Jewels',
      'subtitle': 'Discover precious artifacts',
      'route': '/jewels',
      'icon': Icons.diamond,
    },
    {
      'text': '🎭 Royal Court',
      'subtitle': 'Meet the royal advisors',
      'route': '/court',
      'icon': Icons.people,
    },
    {
      'text': '📚 Royal Library',
      'subtitle': 'Ancient wisdom awaits',
      'route': '/library',
      'icon': Icons.menu_book,
    },
    {
      'text': '🎪 Royal Entertainment',
      'subtitle': 'Jesters and performances',
      'route': '/entertainment',
      'icon': Icons.theater_comedy,
    },
    {
      'text': '🗡️ Royal Armory',
      'subtitle': 'Legendary weapons & armor',
      'route': '/armory',
      'icon': Icons.security,
    },
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializeAudio();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    // Main animation controller
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Crown animation controller
    _crownAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Background shimmer animation
    _backgroundAnimationController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    // Individual controllers for each button
    _individualButtonControllers = List.generate(
      buttonData.length,
          (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      ),
    );

    // Scale animations
    _buttonScaleAnimations = _individualButtonControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ));
    }).toList();

    // Opacity animations
    _buttonOpacityAnimations = _individualButtonControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();

    // Slide animations
    _buttonSlideAnimations = _individualButtonControllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ));
    }).toList();

    // Crown animations
    _crownRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _crownAnimationController,
      curve: Curves.easeInOut,
    ));

    _crownScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _crownAnimationController,
      curve: Curves.easeInOut,
    ));

    // Background shimmer
    _backgroundShimmerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    // Start animations with staggered delays
    for (int i = 0; i < _individualButtonControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 500 + (i * 200)), () {
        if (mounted) {
          _individualButtonControllers[i].forward();
        }
      });
    }

    // Start crown animation
    _crownAnimationController.repeat(reverse: true);
    _backgroundAnimationController.repeat(reverse: true);
  }

  Future<void> _initializeAudio() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.stop);
      await _audioPlayer.setVolume(0.5);
      await _audioPlayer.play(AssetSource('greetings.wav'));

      setState(() {
        _isPlaying = true;
      });

      _audioPlayer.onPlayerComplete.listen((event) {
        if (mounted) {
          setState(() {
            _isPlaying = false;
          });
        }
      });
    } catch (e) {
      debugPrint('Error initializing audio: $e');
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
    }
  }

  Future<void> _toggleMute() async {
    try {
      setState(() {
        _isMuted = !_isMuted;
      });

      if (_isMuted) {
        await _audioPlayer.setVolume(0.0);
      } else {
        await _audioPlayer.setVolume(0.5);
      }
    } catch (e) {
      debugPrint('Error toggling mute: $e');
    }
  }

  Future<void> _togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        setState(() {
          _isPlaying = false;
        });
      } else {
        await _audioPlayer.play(AssetSource('PNS.wav'));
        setState(() {
          _isPlaying = true;
        });
      }
    } catch (e) {
      debugPrint('Error toggling play/pause: $e');
    }
  }

  void _toggleAudioControls() {
    setState(() {
      _showAudioControls = !_showAudioControls;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _buttonAnimationController.dispose();
    _crownAnimationController.dispose();
    _backgroundAnimationController.dispose();
    for (var controller in _individualButtonControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ROYAL GRADIENT BACKGROUND
          AnimatedBuilder(
            animation: _backgroundShimmerAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.lerp(const Color(0xFF1A0E42), const Color(0xFF2D1B69), _backgroundShimmerAnimation.value) ?? const Color(0xFF1A0E42),
                      Color.lerp(const Color(0xFF2D1B69), const Color(0xFF4A2C8F), _backgroundShimmerAnimation.value) ?? const Color(0xFF2D1B69),
                      Color.lerp(const Color(0xFF4A2C8F), const Color(0xFF6A3FB8), _backgroundShimmerAnimation.value) ?? const Color(0xFF4A2C8F),
                    ],
                  ),
                ),
              );
            },
          ),

          // ROYAL PATTERN OVERLAY
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZGVmcz48cGF0dGVybiBpZD0iZ3JpZCIgd2lkdGg9IjYwIiBoZWlnaHQ9IjYwIiBwYXR0ZXJuVW5pdHM9InVzZXJTcGFjZU9uVXNlIj48cGF0aCBkPSJNIDYwIDAgTCAwIDYwIE0gMzAgMCBMIDAgMzAgTSAzMCAzMCBMIDYwIDYwIiBzdHJva2U9IiNmZmZmZmYiIHN0cm9rZS13aWR0aD0iMC41IiBvcGFjaXR5PSIwLjEiLz48L3BhdHRlcm4+PC9kZWZzPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9InVybCgjZ3JpZCkiLz48L3N2Zz4='),
                repeat: ImageRepeat.repeat,
                opacity: 0.1,
              ),
            ),
          ),

          // ROYAL CROWN DECORATION (Top Center)
          // Positioned(
          //   top: 80,
          //   left: 0,
          //   right: 0,
          //   child: AnimatedBuilder(
          //     animation: Listenable.merge([_crownRotationAnimation, _crownScaleAnimation]),
          //     builder: (context, child) {
          //       return Transform.rotate(
          //         angle: _crownRotationAnimation.value,
          //         child: Transform.scale(
          //           scale: _crownScaleAnimation.value,
          //           child: const Icon(
          //             Icons.workspace_premium,
          //             color: Color(0xFFFFD700),
          //             size: 40,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),

          // SETTINGS GEAR WITH ROYAL AUDIO CONTROLS (Top Right)
          Positioned(
            top: 40,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFD700), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Audio Controls (shown when expanded)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _showAudioControls ? 100 : 0,
                    height: 30,
                    child: _showAudioControls
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Play/Pause Button
                        GestureDetector(
                          onTap: _togglePlayPause,
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: const Color(0xFFFFD700),
                            size: 18,
                          ),
                        ),

                        // Music Note Indicator
                        Icon(
                          Icons.music_note,
                          color: _isPlaying ? const Color(0xFFFFD700) : Colors.grey,
                          size: 18,
                        ),

                        // Mute/Unmute Button
                        GestureDetector(
                          onTap: _toggleMute,
                          child: Icon(
                            _isMuted ? Icons.volume_off : Icons.volume_up,
                            color: const Color(0xFFFFD700),
                            size: 18,
                          ),
                        ),
                      ],
                    )
                        : null,
                  ),

                  const SizedBox(width: 8),

                  // Settings Gear Button
                  GestureDetector(
                    onTap: _toggleAudioControls,
                    child: const Icon(
                      Icons.settings,
                      color: Color(0xFFFFD700),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // MAIN CONTENT
          Column(
            children: [
              // TOP SECTION: Image with royal border

// TOP SECTION: Image with simple border
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFFFD700), width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/images/Greetings.png',
                      fit: BoxFit.contain,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),

              // MIDDLE SECTION: Main Royal Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Main buttons
                    ...List.generate(buttonData.length, (index) {
                      return Column(
                        children: [
                          AnimatedBuilder(
                            animation: Listenable.merge([
                              _buttonScaleAnimations[index],
                              _buttonOpacityAnimations[index],
                              _buttonSlideAnimations[index],
                            ]),
                            builder: (context, child) {
                              return SlideTransition(
                                position: _buttonSlideAnimations[index],
                                child: Transform.scale(
                                  scale: _buttonScaleAnimations[index].value,
                                  child: Opacity(
                                    opacity: _buttonOpacityAnimations[index].value,
                                    child: RoyalOptionButton(
                                      text: buttonData[index]['text'],
                                      icon: buttonData[index]['icon'],
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          buttonData[index]['route'],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          if (index < buttonData.length - 1)
                            const SizedBox(height: 16),
                        ],
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // BOTTOM SECTION: Royal Features Grid
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // Royal Features Title
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: const Color(0xFFFFD700), width: 2),
                        ),
                        child: const Text(
                          '👑 Royal Features',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFD700),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Royal Features Grid
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: royalFeatures.length,
                          itemBuilder: (context, index) {
                            return TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0.0, end: 1.0),
                              duration: Duration(milliseconds: 800 + (index * 100)),
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Opacity(
                                    opacity: value,
                                    child: RoyalFeatureCard(
                                      title: royalFeatures[index]['text'],
                                      subtitle: royalFeatures[index]['subtitle'],
                                      icon: royalFeatures[index]['icon'],
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          royalFeatures[index]['route'],
                                        );
                                      },
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
            ],
          ),
        ],
      ),
    );
  }
}

// Royal main option button
class RoyalOptionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const RoyalOptionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A2C8F), Color(0xFF6A3FB8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFFD700), width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD700).withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFFFFD700),
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Royal feature card
class RoyalFeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const RoyalFeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF2D1B69).withOpacity(0.8),
              const Color(0xFF4A2C8F).withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD700).withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFFFFD700),
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Royal sub option button (for submenu)
class RoyalSubOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const RoyalSubOptionButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6A3FB8), Color(0xFF8A5FD8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFFFD700), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD700).withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}