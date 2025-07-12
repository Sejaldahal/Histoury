//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class HistoricalFiguresPage extends StatefulWidget {
//   const HistoricalFiguresPage({super.key});
//
//   @override
//   State<HistoricalFiguresPage> createState() => _HistoricalFiguresPageState();
// }
//
// class _HistoricalFiguresPageState extends State<HistoricalFiguresPage> {
//   List<dynamic> kingsData = [];
//   bool isLoading = true;
//   PageController _pageController = PageController();
//   int currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     loadKingsData();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   Future<void> loadKingsData() async {
//     try {
//       String data = await rootBundle.loadString('assets/kings_data.json');
//       setState(() {
//         kingsData = json.decode(data);
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print('Error loading kings data: $e');
//     }
//   }
//
//   void _showKingDetails(dynamic king) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => KingDetailsSheet(king: king),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('👑 Historical Figures'),
//         backgroundColor: Colors.deepPurple.shade400,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.deepPurple.shade100, Colors.amber.shade100],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : kingsData.isEmpty
//             ? const Center(
//           child: Text(
//             'No historical figures data available.',
//             style: TextStyle(fontSize: 18),
//           ),
//         )
//             : Column(
//           children: [
//             // Title Section
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Kings of Nepal',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.deepPurple,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Tap on a king to learn more about their legacy',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Carousel Section
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   setState(() {
//                     currentIndex = index;
//                   });
//                 },
//                 itemCount: kingsData.length,
//                 itemBuilder: (context, index) {
//                   final king = kingsData[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                     child: KingCarouselCard(
//                       king: king,
//                       onTap: () => _showKingDetails(king),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             // Page Indicators
//             Container(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   kingsData.length,
//                       (index) => AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     margin: const EdgeInsets.symmetric(horizontal: 4),
//                     height: 8,
//                     width: currentIndex == index ? 24 : 8,
//                     decoration: BoxDecoration(
//                       color: currentIndex == index
//                           ? Colors.deepPurple.shade400
//                           : Colors.grey.shade400,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             // Navigation Info
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20),
//               child: Text(
//                 '${currentIndex + 1} of ${kingsData.length}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[700],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class KingCarouselCard extends StatelessWidget {
//   final dynamic king;
//   final VoidCallback onTap;
//
//   const KingCarouselCard({
//     super.key,
//     required this.king,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Card(
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               gradient: LinearGradient(
//                 colors: [Colors.white, Colors.grey.shade50],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // King's Image
//                 Container(
//                   width: 280,
//                   height: 350,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 15,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Image.network(
//                       king['image_url'] ?? '',
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: const Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         );
//                       },
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: const Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.person,
//                                 size: 80,
//                                 color: Colors.grey,
//                               ),
//                               SizedBox(height: 16),
//                               Text(
//                                 'Image not available',
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // King's Name
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       Text(
//                         king['name'] ?? 'Unknown',
//                         style: const TextStyle(
//                           fontSize: 26,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurple,
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 8),
//                       // Tap hint
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.deepPurple.shade50,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: Colors.deepPurple.shade200),
//                         ),
//                         child: Text(
//                           'Tap to learn more',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.deepPurple.shade600,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class KingDetailsSheet extends StatelessWidget {
//   final dynamic king;
//
//   const KingDetailsSheet({super.key, required this.king});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.85,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(25),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Handle bar
//           Container(
//             margin: const EdgeInsets.only(top: 12),
//             width: 40,
//             height: 4,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//
//           // Header with King's Image and Name
//           Container(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               children: [
//                 // King's Image
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(60),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 15,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(60),
//                     child: Image.network(
//                       king['image_url'] ?? '',
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(60),
//                           ),
//                           child: const Icon(
//                             Icons.person,
//                             size: 50,
//                             color: Colors.grey,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // King's Name
//                 Text(
//                   king['name'] ?? 'Unknown',
//                   style: const TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 8),
//                 // King's Title
//                 Text(
//                   king['title'] ?? '',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                     fontStyle: FontStyle.italic,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//
//           // Content
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Quick Info Cards
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _buildQuickInfoCard(
//                           'Birth Year',
//                           _extractYear(king['date_of_birth']),
//                           Icons.cake,
//                           Colors.green,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: _buildQuickInfoCard(
//                           'Reign Started',
//                           _extractYear(king['reign_start']),
//                           Icons.star, // Changed from Icons.crown to Icons.star
//                           Colors.amber.shade700,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _buildQuickInfoCard(
//                           'Age at Death',
//                           '${king['age_at_death'] ?? 'Unknown'}',
//                           Icons.hourglass_empty,
//                           Colors.red,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: _buildQuickInfoCard(
//                           'Reign Years',
//                           _calculateReignYears(king['reign_start'], king['reign_end']),
//                           Icons.timer,
//                           Colors.blue,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   // Biography Section
//                   _buildDetailSection(
//                     'Biography',
//                     king['info'] ?? 'No information available.',
//                     Icons.history_edu,
//                     Colors.deepPurple,
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // Life Timeline
//                   _buildDetailSection(
//                     'Life Timeline',
//                     '• Born: ${_formatDate(king['date_of_birth'])} at ${king['birth_location'] ?? 'Unknown location'}\n\n'
//                         '• Became King: ${_formatDate(king['reign_start'])}\n\n'
//                         '• Died: ${_formatDate(king['date_of_demise'])} at ${king['death_location'] ?? 'Unknown location'}',
//                     Icons.timeline,
//                     Colors.indigo,
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // Family Information
//                   if (king['father'] != null || king['mother'] != null)
//                     _buildDetailSection(
//                       'Family',
//                       '• Father: ${king['father'] ?? 'Unknown'}\n\n'
//                           '• Mother: ${king['mother'] ?? 'Unknown'}',
//                       Icons.family_restroom,
//                       Colors.teal,
//                     ),
//
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuickInfoCard(String title, String value, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Column(
//         children: [
//           Icon(
//             icon,
//             size: 24,
//             color: color,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: color,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDetailSection(String title, String content, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(
//                   icon,
//                   size: 20,
//                   color: color,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             content,
//             style: const TextStyle(
//               fontSize: 15,
//               height: 1.6,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _extractYear(String? dateString) {
//     if (dateString == null || dateString.isEmpty) return 'Unknown';
//     try {
//       DateTime date = DateTime.parse(dateString);
//       return date.year.toString();
//     } catch (e) {
//       return 'Unknown';
//     }
//   }
//
//   String _calculateReignYears(String? startDate, String? endDate) {
//     if (startDate == null || endDate == null) return 'Unknown';
//     try {
//       DateTime start = DateTime.parse(startDate);
//       DateTime end = DateTime.parse(endDate);
//       int years = end.year - start.year;
//       return '$years years';
//     } catch (e) {
//       return 'Unknown';
//     }
//   }
//
//   String _formatDate(String? dateString) {
//     if (dateString == null || dateString.isEmpty) return 'Unknown';
//
//     try {
//       DateTime date = DateTime.parse(dateString);
//       List<String> months = [
//         'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//       ];
//       return '${date.day} ${months[date.month - 1]} ${date.year}';
//     } catch (e) {
//       return dateString;
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'dart:math' as math;

class HistoricalFiguresPage extends StatefulWidget {
  const HistoricalFiguresPage({super.key});

  @override
  State<HistoricalFiguresPage> createState() => _HistoricalFiguresPageState();
}

class _HistoricalFiguresPageState extends State<HistoricalFiguresPage>
    with TickerProviderStateMixin {
  List<dynamic> kingsData = [];
  bool isLoading = true;
  int currentIndex = 0;
  late CardSwiperController _cardSwiperController;

  @override
  void initState() {
    super.initState();
    _cardSwiperController = CardSwiperController();
    loadKingsData();
  }

  @override
  void dispose() {
    _cardSwiperController.dispose();
    super.dispose();
  }

  Future<void> loadKingsData() async {
    try {
      String data = await rootBundle.loadString('assets/kings_data.json');
      final decodedData = json.decode(data);
      setState(() {
        kingsData = decodedData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading kings data: $e');
    }
  }

  void _showKingDetails(dynamic king) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KingDetailsSheet(king: king),
    );
  }

  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    setState(() {
      this.currentIndex = currentIndex ?? 0;
    });

    // Add haptic feedback for better UX
    HapticFeedback.lightImpact();

    return true;
  }

  bool _onUndo(
      int? previousIndex,
      int currentIndex,
      CardSwiperDirection direction,
      ) {
    setState(() {
      this.currentIndex = currentIndex;
    });
    return true;
  }

  void _resetCards() {
    setState(() {
      currentIndex = 0;
    });
    // Reset the card swiper to the first card
    _cardSwiperController.moveTo(0);
  }

  void _undoSwipe() {
    _cardSwiperController.undo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👑 Historical Figures'),
        backgroundColor: Colors.deepPurple.shade400,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: currentIndex > 0 ? _undoSwipe : null,
            tooltip: 'Undo Swipe',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetCards,
            tooltip: 'Reset Cards',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.amber.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : kingsData.isEmpty
            ? const Center(
          child: Text(
            'No historical figures data available.',
            style: TextStyle(fontSize: 18),
          ),
        )
            : Column(
          children: [
            // Title Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Kings of Nepal',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Swipe cards to explore their legacy',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Card Swiper Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CardSwiper(
                  controller: _cardSwiperController,
                  cardsCount: kingsData.length,
                  onSwipe: _onSwipe,
                  onUndo: _onUndo,
                  numberOfCardsDisplayed: 3,
                  backCardOffset: const Offset(0, 40),
                  padding: const EdgeInsets.all(24.0),
                  allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
                    horizontal: true,
                    vertical: false,
                  ),
                  cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage) {
                    final king = kingsData[index];
                    return KingCard(
                      king: king,
                      onTap: () => _showKingDetails(king),
                      swipeProgress: horizontalThresholdPercentage.toDouble(),
                      isTopCard: index == currentIndex,
                    );
                  },
                ),
              ),
            ),

            // Progress Indicator
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      math.min(kingsData.length, 8),
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 8,
                        width: currentIndex == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.deepPurple.shade400
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${currentIndex + 1} of ${kingsData.length}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            // Swipe Instructions and Action Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  // Instructions
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.swipe, color: Colors.grey[600], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Swipe to explore • Tap for details',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Action Buttons - All Same Now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // First Button (Previous)
                      GestureDetector(
                        onTap: () {
                          _cardSwiperController.swipe(CardSwiperDirection.left);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade100,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.deepPurple.shade300),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.deepPurple.shade600,
                            size: 28,
                          ),
                        ),
                      ),

                      // Second Button (Info)
                      GestureDetector(
                        onTap: () {
                          if (currentIndex < kingsData.length) {
                            _showKingDetails(kingsData[currentIndex]);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade100,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.deepPurple.shade300),
                          ),
                          child: Icon(
                            Icons.info,
                            color: Colors.deepPurple.shade600,
                            size: 28,
                          ),
                        ),
                      ),

                      // Third Button (Next)
                      GestureDetector(
                        onTap: () {
                          _cardSwiperController.swipe(CardSwiperDirection.right);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade100,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.deepPurple.shade300),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.deepPurple.shade600,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KingCard extends StatelessWidget {
  final dynamic king;
  final VoidCallback onTap;
  final double swipeProgress;
  final bool isTopCard;

  const KingCard({
    super.key,
    required this.king,
    required this.onTap,
    required this.swipeProgress,
    required this.isTopCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // King's Image
                Hero(
                  tag: 'king_image_${king['name']}',
                  child: Container(
                    width: 280,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        king['image_url'] ?? '',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Image not available',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
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

                const SizedBox(height: 24),

                // King's Name and Info (only show for top card)
                if (isTopCard)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Text(
                          king['name'] ?? 'Unknown',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          king['title'] ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.deepPurple.shade200),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.touch_app,
                                color: Colors.deepPurple.shade600,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Tap to learn more',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: isTopCard ? 20 : 0),

                // Swipe indicator overlay (only show for top card)
                if (isTopCard && swipeProgress.abs() > 0.1)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: swipeProgress > 0
                            ? Colors.deepPurple.withOpacity(0.3)
                            : Colors.deepPurple.withOpacity(0.3),
                      ),
                      child: Center(
                        child: Icon(
                          swipeProgress > 0 ? Icons.arrow_forward : Icons.arrow_back,
                          size: 80,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Keep the existing KingDetailsSheet class unchanged
class KingDetailsSheet extends StatelessWidget {
  final dynamic king;

  const KingDetailsSheet({super.key, required this.king});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header with King's Image and Name
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // King's Image
                Hero(
                  tag: 'king_image_${king['name']}',
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        king['image_url'] ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // King's Name
                Text(
                  king['name'] ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // King's Title
                Text(
                  king['title'] ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickInfoCard(
                          'Birth Year',
                          _extractYear(king['date_of_birth']),
                          Icons.cake,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickInfoCard(
                          'Reign Started',
                          _extractYear(king['reign_start']),
                          Icons.star,
                          Colors.amber.shade700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickInfoCard(
                          'Age at Death',
                          '${king['age_at_death'] ?? 'Unknown'}',
                          Icons.hourglass_empty,
                          Colors.red,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickInfoCard(
                          'Reign Years',
                          _calculateReignYears(king['reign_start'], king['reign_end']),
                          Icons.timer,
                          Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Biography Section
                  _buildDetailSection(
                    'Biography',
                    king['info'] ?? 'No information available.',
                    Icons.history_edu,
                    Colors.deepPurple,
                  ),

                  const SizedBox(height: 20),

                  // Life Timeline
                  _buildDetailSection(
                    'Life Timeline',
                    '• Born: ${_formatDate(king['date_of_birth'])} at ${king['birth_location'] ?? 'Unknown location'}\n\n'
                        '• Became King: ${_formatDate(king['reign_start'])}\n\n'
                        '• Died: ${_formatDate(king['date_of_demise'])} at ${king['death_location'] ?? 'Unknown location'}',
                    Icons.timeline,
                    Colors.indigo,
                  ),

                  const SizedBox(height: 20),

                  // Family Information
                  if (king['father'] != null || king['mother'] != null)
                    _buildDetailSection(
                      'Family',
                      '• Father: ${king['father'] ?? 'Unknown'}\n\n'
                          '• Mother: ${king['mother'] ?? 'Unknown'}',
                      Icons.family_restroom,
                      Colors.teal,
                    ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, String content, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _extractYear(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Unknown';
    try {
      DateTime date = DateTime.parse(dateString);
      return date.year.toString();
    } catch (e) {
      return 'Unknown';
    }
  }

  String _calculateReignYears(String? startDate, String? endDate) {
    if (startDate == null || endDate == null) return 'Unknown';
    try {
      DateTime start = DateTime.parse(startDate);
      DateTime end = DateTime.parse(endDate);
      int years = end.year - start.year;
      return '$years years';
    } catch (e) {
      return 'Unknown';
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'Unknown';

    try {
      DateTime date = DateTime.parse(dateString);
      List<String> months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}