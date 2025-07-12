import 'package:ar_flutter_plugin_updated/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_updated/models/ar_hittest_result.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin_updated/widgets/ar_view.dart';
import 'package:ar_flutter_plugin_updated/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_updated/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

// Model data class
class ARModelData {
  final String id;
  final String name;
  final String description;
  final String modelUrl;
  final String thumbnailUrl;
  final String category;
  final List<String> tags;

  ARModelData({
    required this.id,
    required this.name,
    required this.description,
    required this.modelUrl,
    required this.thumbnailUrl,
    required this.category,
    required this.tags,
  });
}

// Main AR Models List Screen
class ARModelsListScreen extends StatefulWidget {
  const ARModelsListScreen({super.key});

  @override
  State<ARModelsListScreen> createState() => _ARModelsListScreenState();
}

class _ARModelsListScreenState extends State<ARModelsListScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';

  // Sample AR models data
  final List<ARModelData> arModels = [
    ARModelData(
      id: '1',
      name: 'Stone Inscription',
      description: 'Ancient stone inscription from Bhaktapur Durbar Square with historical significance.',
      modelUrl: 'https://jauhhihsmjrnbcmyezkr.supabase.co/storage/v1/object/public/chronova//stone_inscription_at_bhaktapur_durbar_square.glb',
      thumbnailUrl: 'https://via.placeholder.com/150x150?text=Stone',
      category: 'Historical',
      tags: ['ancient', 'stone', 'inscription', 'nepal'],
    ),
    ARModelData(
      id: '2',
      name: 'Traditional Lion',
      description: 'Traditional lion with intricate patterns.',
      modelUrl: 'https://jauhhihsmjrnbcmyezkr.supabase.co/storage/v1/object/public/gbl//lion_stone.glb',
      thumbnailUrl: 'https://via.placeholder.com/150x150?text=Vase',
      category: 'Artifacts',
      tags: ['ceramic', 'traditional', 'decorative'],
    ),
    ARModelData(
      id: '3',
      name: 'Kala Bhairava God',
      description: 'Detailed sculpture representing kala vairava craftsmanship.',
      modelUrl: 'https://jauhhihsmjrnbcmyezkr.supabase.co/storage/v1/object/public/gbl//kala_bhairava_w_2_lod_-_nepal_heritage.glb',
      thumbnailUrl: 'https://via.placeholder.com/150x150?text=Sculpture',
      category: 'Sculptures',
      tags: ['sculpture', 'art', 'ancient'],
    ),ARModelData(
      id: '4',
      name: 'Chaitya Shrine',
      description: 'Chaitya inside Golden temple located at Patan .',
      modelUrl: 'https://jauhhihsmjrnbcmyezkr.supabase.co/storage/v1/object/public/gbl//shrine_temple_low_poly_photogrammetry.glb',
      thumbnailUrl: 'https://via.placeholder.com/150x150?text=Sculpture',
      category: 'Sculptures',
      tags: ['sculpture', 'art', 'ancient'],
    ),ARModelData(
      id: '5',
      name: 'Simhamukha Kama Bhairawa',
      description: 'Simhamukha  Kama Bhairawa at National museum kathmandu.',
      modelUrl: 'https://jauhhihsmjrnbcmyezkr.supabase.co/storage/v1/object/public/gbl//bhairava_bronze_national_museum_nepal_kathmandu.glb',
      thumbnailUrl: 'https://via.placeholder.com/150x150?text=Sculpture',
      category: 'Sculptures',
      tags: ['sculpture', 'art', 'ancient'],
    ),ARModelData(
      id: '6',
      name: 'Mahabodhi Temple',
      description: 'Mahabodhi temple at Chobhar, Kirtipur.',
      modelUrl: 'https://jauhhihsmjrnbcmyezkr.supabase.co/storage/v1/object/public/gbl//mahabodhi_temple_in_chobhar_kirtipur.glb',
      thumbnailUrl: 'https://via.placeholder.com/150x150?text=Sculpture',
      category: 'Sculptures',
      tags: ['sculpture', 'art', 'ancient'],
    ),ARModelData(
      id: '7',
      name: 'Buddhist stupa shrine',
      description: 'Buddhist stupa shrine at Nagbahal',
      modelUrl: 'https://jauhhihsmjrnbcmyezkr.supabase.co/storage/v1/object/public/gbl//buddhist_stupa_shrine_realistic_low_poly.glb',
      thumbnailUrl: 'https://via.placeholder.com/150x150?text=Sculpture',
      category: 'Sculptures',
      tags: ['sculpture', 'art', 'ancient'],
    ),ARModelData(
      id: '8',
      name: 'Buddha chaitya shrine ',
      description: 'Buddha Chaitya at Nyakha, Patan',
      modelUrl: 'https://jauhhihsmjrnbcmyezkr.supabase.co/storage/v1/object/public/gbl//buddha_chaitya_shrine_photogrammetry.glb',
      thumbnailUrl: 'https://via.placeholder.com/150x150?text=Sculpture',
      category: 'Sculptures',
      tags: ['sculpture', 'art', 'ancient'],
    ),
  ];

  List<String> get categories {
    final cats = arModels.map((model) => model.category).toSet().toList();
    cats.insert(0, 'All');
    return cats;
  }

  List<ARModelData> get filteredModels {
    return arModels.where((model) {
      final matchesCategory = selectedCategory == 'All' || model.category == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          model.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          model.description.toLowerCase().contains(searchQuery.toLowerCase()) ||
          model.tags.any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Models' , style: TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF8B4513),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width, // or use double.infinity
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Search Bar
                      TextField(
                        onChanged: (value) => setState(() => searchQuery = value),
                        decoration: InputDecoration(
                          hintText: 'Search AR models...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Category Filter
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final isSelected = category == selectedCategory;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(category),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() => selectedCategory = category);
                                },
                                backgroundColor: Colors.white,
                                selectedColor: Colors.deepPurple.shade100,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Models Grid
          Expanded(
            child: filteredModels.isEmpty
                ? const Center(
              child: Text(
                'No models found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredModels.length,
              itemBuilder: (context, index) {
                final model = filteredModels[index];
                return ARModelCard(
                  model: model,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ARModelDetailScreen(model: model),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// AR Model Card Widget
class ARModelCard extends StatelessWidget {
  final ARModelData model;
  final VoidCallback onTap;

  const ARModelCard({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    model.thumbnailUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade200,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.deepPurple.shade300,
                            ),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.view_in_ar,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      model.category,
                      style: TextStyle(
                        color: Colors.deepPurple.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        model.description,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// AR Model Detail Screen with Enhanced AR View
class ARModelDetailScreen extends StatelessWidget {
  final ARModelData model;

  const ARModelDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => ModelInfoSheet(model: model),
              );
            },
          ),
        ],
      ),
      body: EnhancedARScreen(model: model),
    );
  }
}

// Model Info Bottom Sheet
class ModelInfoSheet extends StatelessWidget {
  final ARModelData model;

  const ModelInfoSheet({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            model.category,
            style: TextStyle(
              color: Colors.deepPurple.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            model.description,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tags:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: model.tags.map((tag) => Chip(
              label: Text(tag),
              backgroundColor: Colors.deepPurple.shade100,
            )).toList(),
          ),
        ],
      ),
    );
  }
}

// Enhanced AR Screen with Text Overlays
class EnhancedARScreen extends StatefulWidget {
  final ARModelData model;

  const EnhancedARScreen({super.key, required this.model});

  @override
  State<EnhancedARScreen> createState() => _EnhancedARScreenState();
}

class _EnhancedARScreenState extends State<EnhancedARScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  ARNode? placedNode;
  bool showInstructions = true;
  bool showModelInfo = false;
  bool isLoadingModel = false;
  String loadingStatus = 'Loading model...';

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }

  void onARViewCreated(
      ARSessionManager sessionManager,
      ARObjectManager objectManager,
      ARAnchorManager anchorManager,
      ARLocationManager locationManager,
      ) {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;

    arSessionManager.onInitialize(
      showFeaturePoints: true,
      showAnimatedGuide: false,
      showPlanes: true,
      handleTaps: true,
      handlePans: true,
      handleRotation: true,
    );

    arSessionManager.onPlaneOrPointTap = _onPlaneTapped;
  }

  Future<void> _onPlaneTapped(List<ARHitTestResult> hitTestResults) async {
    if (hitTestResults.isEmpty) return;

    // Show loading indicator
    setState(() {
      isLoadingModel = true;
      loadingStatus = 'Preparing 3D model...';
    });

    try {
      // Remove previous node
      if (placedNode != null) {
        setState(() => loadingStatus = 'Removing previous model...');
        await arObjectManager.removeNode(placedNode!);
      }

      setState(() => loadingStatus = 'Loading ${widget.model.name}...');

      final newNode = ARNode(
        type: NodeType.webGLB,
        uri: widget.model.modelUrl,
        scale: vector.Vector3.all(0.5),
        position: hitTestResults.first.worldTransform.getTranslation(),
      );

      setState(() => loadingStatus = 'Rendering model...');

      final success = await arObjectManager.addNode(newNode);

      if (success == true) {
        setState(() {
          placedNode = newNode;
          showInstructions = false;
          showModelInfo = true;
          isLoadingModel = false;
        });
      } else {
        throw Exception('Failed to load model');
      }
    } catch (e) {
      setState(() {
        isLoadingModel = false;
        loadingStatus = 'Loading model...';
      });

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load model: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // AR View
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),

          // Loading Overlay
          if (isLoadingModel)
            Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                        strokeWidth: 3,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        loadingStatus,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Please wait while we prepare your AR experience',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),


          // Model Info Overlay
          if (showModelInfo && placedNode != null)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.model.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => setState(() => showModelInfo = false),
                        ),
                      ],
                    ),
                    Text(
                      widget.model.description,
                      style: const TextStyle(fontSize: 14, height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: widget.model.tags.map((tag) => Chip(
                        label: Text(tag, style: const TextStyle(fontSize: 12)),
                        backgroundColor: Colors.deepPurple.shade100,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),

          // Bottom Control Panel
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: Icons.refresh,
                    label: 'Reset',
                    isEnabled: !isLoadingModel,
                    onTap: () async {
                      if (placedNode != null && !isLoadingModel) {
                        setState(() {
                          isLoadingModel = true;
                          loadingStatus = 'Resetting scene...';
                        });

                        await arObjectManager.removeNode(placedNode!);

                        setState(() {
                          placedNode = null;
                          showInstructions = true;
                          showModelInfo = false;
                          isLoadingModel = false;
                        });
                      }
                    },
                  ),
                  _buildControlButton(
                    icon: Icons.camera_alt,
                    label: 'Capture',
                    isEnabled: !isLoadingModel && placedNode != null,
                    onTap: () {
                      if (!isLoadingModel && placedNode != null) {
                        // Add screenshot functionality here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Screenshot captured!')),
                        );
                      }
                    },
                  ),
                  _buildControlButton(
                    icon: Icons.share,
                    label: 'Share',
                    isEnabled: !isLoadingModel && placedNode != null,
                    onTap: () {
                      if (!isLoadingModel && placedNode != null) {
                        // Add share functionality here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sharing model...')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isEnabled = true,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}