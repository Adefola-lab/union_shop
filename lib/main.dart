import 'package:flutter/material.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/account_page.dart';
import 'dart:async'; 
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_us.dart';
import 'package:union_shop/collection.dart';
import 'package:union_shop/search_page.dart';
import 'package:union_shop/sign_in.dart';
import 'package:union_shop/collections_landing.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/cart_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService().init();
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      initialRoute: '/',
      routes: {
        '/about': (context) => const AboutUsPage(),
        '/collections': (context) => const CollectionsLandingPage(),
        '/sign-in': (context) => const SignInPage(),
        '/cart': (context) => const CartPage(),
        '/search': (context) => const SearchPage(),
        '/account': (context) => const AccountPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/product') {
          final args = settings.arguments as Map<String, String>?;
          return MaterialPageRoute(
            builder: (context) => ProductPage(
              productId: args?['productId'],
              title: args?['title'],
              price: args?['price'],
              imageUrl: args?['imageUrl'],
            ),
          );
        }
        if (settings.name == '/collection') {
          // CHANGE: This shows products within a specific collection
          final collectionName = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) =>
                CollectionPage(collectionName: collectionName),
          );
        }
        return null;
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0;
  bool _isAutoPlaying = false; // ADD THIS
  Timer? _autoPlayTimer; // ADD THIS

  final List<Map<String, String>> _slides = [
    {
      'image':
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=800&q=60',
      'title': 'Essential Range - Over 20% Off!',
      'description':
          'Over 20% off our Essential Range. Come and grab yours while stock lasts!',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1581655353564-df123a1eb820?auto=format&fit=crop&w=800&q=60',
      'title': 'Signature Collection',
      'description':
          'Premium quality hoodies and apparel. Show your Portsmouth pride!',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?auto=format&fit=crop&w=800&q=60',
      'title': 'Limited Edition Merchandise',
      'description':
          'Exclusive designs available for a limited time only. Get yours now!',
    },
  ];

  @override
  void dispose() {
    _autoPlayTimer?.cancel(); // ADD THIS
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        _nextSlide();
      }
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  void _toggleAutoPlay() {
    setState(() {
      _isAutoPlaying = !_isAutoPlaying;
      if (_isAutoPlaying) {
        _startAutoPlay();
      } else {
        _stopAutoPlay();
      }
    });
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: ListView(
            children: [
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  navigateToHome(context);
                },
              ),
              ExpansionTile(
                title: const Text('Shop'),
                children: [
                  ListTile(
                    title: const Text('Clothing'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    title: const Text('Merchandise'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    title: const Text('Halloween 🎃'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    title: const Text('Signature & Essential Range'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    title: const Text('Portsmouth City Collection'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    title: const Text('Pride Collection 🏳️‍🌈'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    title: const Text('Graduation 🎓'),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              ExpansionTile(
                title: const Text('The Print Shack'),
                children: [
                  ListTile(
                    title: const Text('Custom Printing'),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              ListTile(
                title: const Text('SALE!'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/about');
                },
              ),
              ListTile(
                title: const Text('UPSU.net'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _nextSlide() {
    setState(() {
      _currentSlide = (_currentSlide + 1) % _slides.length;
    });
  }

  void _previousSlide() {
    setState(() {
      _currentSlide = (_currentSlide - 1 + _slides.length) % _slides.length;
    });
  }

  void _goToSlide(int index) {
    setState(() {
      _currentSlide = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 100,
              color: Colors.white,
              child: Column(
                children: [
                  // Top banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: const Color(0xFF4d2963),
                    child: const Text(
                      'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Main header
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              navigateToHome(context);
                            },
                            child: Image.network(
                              'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                              height: 18,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  width: 18,
                                  height: 18,
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.grey),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Spacer(),

                          // Navigation Menu - Show only on desktop
                          if (MediaQuery.of(context).size.width > 768)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () => navigateToHome(context),
                                  child: const Text(
                                    'Home',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                PopupMenuButton<String>(
                                  offset: const Offset(0, 40),
                                  child: const TextButton(
                                    onPressed: null,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Shop',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(Icons.keyboard_arrow_down,
                                            size: 16, color: Colors.black87),
                                      ],
                                    ),
                                  ),
                                  itemBuilder: (BuildContext context) => [
                                    const PopupMenuItem<String>(
                                      value: 'clothing',
                                      child: Text('Clothing'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'merchandise',
                                      child: Text('Merchandise'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'halloween',
                                      child: Row(
                                        children: [
                                          Text('Halloween '),
                                          Text('🎃'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'signature',
                                      child:
                                          Text('Signature & Essential Range'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'portsmouth',
                                      child: Text('Portsmouth City Collection'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'pride',
                                      child: Row(
                                        children: [
                                          Text('Pride Collection '),
                                          Text('🏳️‍🌈'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'graduation',
                                      child: Row(
                                        children: [
                                          Text('Graduation '),
                                          Text('🎓'),
                                        ],
                                      ),
                                    ),
                                  ],
                                  onSelected: (String value) {
                                    placeholderCallbackForButtons();
                                  },
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: placeholderCallbackForButtons,
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'The Print Shack',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(Icons.keyboard_arrow_down,
                                          size: 16, color: Colors.black87),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: placeholderCallbackForButtons,
                                  child: const Text(
                                    'SALE!',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/about'),
                                  child: const Text(
                                    'About',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: placeholderCallbackForButtons,
                                  child: const Text(
                                    'UPSU.net',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          const Spacer(),

                          // Right side icons
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/search'),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.person_outline,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: () {
                                  if(AuthService().isAuthenticated) {
                                    Navigator.pushNamed(context, '/account');
                                  } else {
                                    Navigator.pushNamed(context, '/sign-in');
                                  }
                                }
                              ),
                              IconButton(
                                icon: Stack(
                                  children: [
                                    const Icon(
                                      Icons.shopping_bag_outlined,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    if (CartService().itemCount > 0)
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF4d2963),
                                            shape: BoxShape.circle,
                                          ),
                                          constraints: const BoxConstraints(
                                            minWidth: 12,
                                            minHeight: 12,
                                          ),
                                          child: Text(
                                            '${CartService().itemCount}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/cart'),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.menu,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                onPressed: () => _showMobileMenu(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Hero Section with Carousel
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        key: ValueKey<int>(_currentSlide),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                NetworkImage(_slides[_currentSlide]['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Content overlay
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Column(
                        key: ValueKey<int>(_currentSlide),
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _slides[_currentSlide]['title']!,
                            style: const TextStyle(
                              fontSize: 65,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                              letterSpacing: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _slides[_currentSlide]['description']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () => Navigator.pushNamed(context,
                                '/collections'), // CHANGE: Go to collections landing
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4d2963),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: const Text(
                              'BROWSE COLLECTION',
                              style: TextStyle(fontSize: 14, letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Left arrow
                  Positioned(
                    left: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left,
                              color: Colors.white, size: 32),
                          onPressed: _previousSlide,
                        ),
                      ),
                    ),
                  ),
                  // Right arrow
                  Positioned(
                    right: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.chevron_right,
                              color: Colors.white, size: 32),
                          onPressed: _nextSlide,
                        ),
                      ),
                    ),
                  ),
                  // Dots indicator
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_slides.length, (index) {
                        return GestureDetector(
                          onTap: () => _goToSlide(index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentSlide == index
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  // Play/Pause button - UPDATED
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: IconButton(
                        icon: Icon(
                          _isAutoPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: _toggleAutoPlay,
                        tooltip: _isAutoPlaying
                            ? 'Pause auto-play'
                            : 'Start auto-play',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: MediaQuery.of(context).size.width > 1200 ? 200 : MediaQuery.of(context).size.width > 768 ? 60: 20,
                      ),
                child: Column(
                  children: [
                    const Text(
                      'PRODUCTS SECTION',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // First Grid with Header - ESSENTIAL RANGE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'ESSENTIAL RANGE',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 2 : 1,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 48,
                          childAspectRatio:
                              0.75, // ADD THIS for better proportions
                          children: const [
                            ProductCard(
                              title: 'Essential Range Hoodie',
                              price: '£20.00',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1513789181297-6f2ec112c0bc?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGhvb2RpZXxlbnwwfHwwfHx8MA%3D%3D',
                              description:
                                  'Premium quality essential hoodie from our limited edition collection. Made with soft, comfortable fabric perfect for everyday wear. Available in multiple colors and sizes.',
                            ),
                            ProductCard(
                              title: 'Essential Range T-Shirt',
                              price: '£9.99',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1581655353564-df123a1eb820?auto=format&fit=crop&w=800&q=60',
                              description:
                                  'Classic essential t-shirt designed for comfort and style. Made from high-quality cotton blend material. Perfect for casual wear or layering.',
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 64),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'SIGNATURE RANGE',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 2 : 1,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 48,
                          childAspectRatio:
                              0.75, // MAKE SURE THIS IS CONSISTENT
                          children: const [
                            ProductCard(
                              title: 'Signature Hoodie',
                              price: '£32.99',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=800&q=60',
                              description:
                                  'Our premium signature hoodie featuring the iconic Portsmouth University design. Crafted with superior materials for maximum comfort and durability. A must-have for any student wardrobe.',
                            ),
                            ProductCard(
                              title: 'Signature T-Shirt',
                              price: '£14.99',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=60',
                              description:
                                  'Show your Portsmouth pride with our signature t-shirt. Features distinctive university branding and motivational design. Made from breathable, comfortable fabric suitable for all-day wear.',
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 64),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'PORSTMOUTH CITY COLLECTION',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 2 : 1,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 48,
                          children: const [
                            ProductCard(
                              title: 'Portsmouth City Postcard',
                              price: '£10.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                              description:
                                  'Beautiful postcard featuring iconic Portsmouth city landmarks. Perfect for sending to friends and family or keeping as a souvenir of your time in Portsmouth.',
                            ),
                            ProductCard(
                              title: 'Portsmouth City Magnet',
                              price: '£15.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                              description:
                                  'Decorative fridge magnet showcasing Portsmouth\'s most beloved landmarks. A perfect keepsake or gift to remember your university experience.',
                            ),
                            ProductCard(
                              title: 'Portsmouth City Bookmark',
                              price: '£20.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityBookmark1_1024x1024@2x.jpg?v=1752230004',
                              description:
                                  'Premium quality bookmark featuring Portsmouth city illustrations. Ideal for students and book lovers. Durable design perfect for daily use.',
                            ),
                            ProductCard(
                              title: 'Portsmouth City Notebook',
                              price: '£25.00',
                              imageUrl:
                                  'https://shop.upsu.net/cdn/shop/files/PortsmouthCityNotebook_1024x1024@2x.jpg?v=1757419215',
                              description:
                                  'High-quality notebook with Portsmouth city themed cover design. Features lined pages perfect for note-taking, journaling, or sketching. Essential for every student.',
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Centered Button
                    const SizedBox(height: 48),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context,
                            '/collections'), // CHANGE: Go to collections landing
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d2963),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'VIEW ALL',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'OUR RANGE',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 4 : 1,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 48,
                          children: const [
                            ImageCard(
                              title: 'Clothing',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&w=800&q=60',
                            ),
                            ImageCard(
                              title: 'Merchandise',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1656360088907-5109c245851d?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWVyY2hhbmRpc2V8ZW58MHx8MHx8fDA%3D',
                            ),
                            ImageCard(
                              title: 'Graduation',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1559443065-db5f9290a1a7?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Z3JhZHVhdGlvbiUyMGdvd258ZW58MHx8MHx8fDA%3D',
                            ),
                            ImageCard(
                              title: 'SALE',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1607083206968-13611e3d76db?auto=format&fit=crop&w=800&q=60',
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Personal Touch Section
                    const SizedBox(height: 64),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 768;
                        return isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Add a Personal Touch',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'First add your item of clothing to your cart then click below to add your text! One line of text contains 10 characters!',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  ElevatedButton(
                                    onPressed: placeholderCallbackForButtons,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4d2963),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    child: const Text(
                                      'CLICK HERE TO ADD TEXT!',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Image.network(
                                    'https://shop.upsu.net/cdn/shop/files/The_Union_Print_Shack_Logo_-_smaller_1024x1024@2x.png?v=1760532830',
                                    fit: BoxFit.contain,
                                    height: 200,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        height: 200,
                                        child: const Center(
                                          child: Icon(Icons.image_not_supported,
                                              color: Colors.grey),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Add a Personal Touch',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        const Text(
                                          'First add your item of clothing to your cart then click below to add your text! One line of text contains 10 characters!',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            height: 1.5,
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        ElevatedButton(
                                          onPressed: placeholderCallbackForButtons,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF4d2963),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 32,
                                              vertical: 16,
                                            ),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                            ),
                                          ),
                                          child: const Text(
                                            'CLICK HERE TO ADD TEXT!',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 48),
                                  Expanded(
                                    child: Image.network(
                                      'https://shop.upsu.net/cdn/shop/files/The_Union_Print_Shack_Logo_-_smaller_1024x1024@2x.png?v=1760532830',
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          height: 300,
                                          child: const Center(
                                            child: Icon(Icons.image_not_supported,
                                                color: Colors.grey),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    // Top section with 3 columns
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 40),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth >= 900;

                          const openingHours = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Opening Hours',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                '❄️ Winter Break Closure Dates ❄️',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              Text(
                                'Closing 4pm 19/12/2025',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              Text(
                                'Reopening 10am 05/01/2026',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Last post date: 12pm on 18/12/2025',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '-------------------------',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '(Term Time)',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              Text(
                                'Monday - Friday 10am - 4pm',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '(Outside of Term Time / Consolidation Weeks)',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              Text(
                                'Monday - Friday 10am - 3pm',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Purchase online 24/7',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          );

                          final helpInfo = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Help and Information',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 16),
                              InkWell(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/search'),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Search',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: placeholderCallbackForButtons,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Terms & Conditions of Sale',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: placeholderCallbackForButtons,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Policy',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );

                          final latestOffers = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Latest Offers',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Email address',
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 14,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 0),
                                  ElevatedButton(
                                    onPressed: placeholderCallbackForButtons,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4d2963),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 20,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    child: const Text(
                                      'SUBSCRIBE',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );

                          return isWide
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(child: openingHours),
                                    const SizedBox(width: 60),
                                    Expanded(child: helpInfo),
                                    const SizedBox(width: 60),
                                    Expanded(child: latestOffers),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    openingHours,
                                    const SizedBox(height: 32),
                                    helpInfo,
                                    const SizedBox(height: 32),
                                    latestOffers,
                                  ],
                                );
                        },
                      ),
                    ),

                    // Divider
                    Divider(
                        height: 1, thickness: 1, color: Colors.grey.shade300),

                    // Bottom section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Social icons
                          const Row(
                            children: [
                              Icon(Icons.facebook,
                                  size: 24, color: Colors.black87),
                              SizedBox(width: 16),
                              Icon(Icons.flutter_dash,
                                  size: 24, color: Colors.black87),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Payment icons
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(Icons.apple,
                                    size: 20, color: Colors.black87),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(Icons.credit_card,
                                    size: 20, color: Colors.black87),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Copyright
                          const Text(
                            '© 2025, upsu-store    Powered by Shopify',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
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

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final String description;
  final String? productId;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (productId != null) {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: {'productId': productId},
          );
        } else {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: {
              'title': title,
              'price': price,
              'imageUrl': imageUrl,
              'description': description,
            },
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image_not_supported,
                            color: Colors.grey, size: 48),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Text section
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4d2963),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ); // ADD THIS - missing closing parenthesis
  }
}

class ImageCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ImageCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // No action for now
      },
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          // Dark overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.4),
            ),
          ),
          // Centered text
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}


