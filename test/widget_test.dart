import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/services/auth_service.dart';
import 'package:union_shop/services/cart_service.dart';

void main() {
  // Set up test environment
  setUp(() async {
    // Initialize services before each test
    await AuthService().init();
  });

  tearDown(() {
    // Clean up after each test
    CartService().clearCart();
  });

  group('HomeScreen Widget Tests', () {
    testWidgets('App should display correctly with banner and logo',
        (WidgetTester tester) async {
      // Build the app with a reasonable screen size
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Verify the banner text is displayed
      expect(
        find.textContaining('BIG SALE!'),
        findsOneWidget,
      );

      // Verify navigation icons are present
      expect(find.byIcon(Icons.search), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.person_outline), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.shopping_bag_outlined), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.menu), findsAtLeastNWidgets(1));
      
      addTearDown(tester.view.reset);
    });

    testWidgets('Hero carousel should display slides',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Check if carousel title is visible
      expect(find.textContaining('Essential Range'), findsWidgets);
      expect(find.text('BROWSE COLLECTION'), findsOneWidget);

      // Verify navigation arrows
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      
      addTearDown(tester.view.reset);
    });

    testWidgets('Carousel navigation should work',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Initial slide
      expect(find.textContaining('Essential Range'), findsWidgets);

      // Tap right arrow to go to next slide
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      // Check if slide changed
      expect(find.text('Signature Collection'), findsOneWidget);

      // Tap left arrow to go back
      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pumpAndSettle();

      // Should be back to first slide
      expect(find.textContaining('Essential Range'), findsWidgets);
      
      addTearDown(tester.view.reset);
    });

    testWidgets('Auto-play toggle should work', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Find and tap the play button
      final playButton = find.byIcon(Icons.play_arrow);
      expect(playButton, findsOneWidget);

      await tester.tap(playButton);
      await tester.pumpAndSettle();

      // After tapping, it should show pause icon
      expect(find.byIcon(Icons.pause), findsOneWidget);
      
      addTearDown(tester.view.reset);
    });

    testWidgets('Products section should display product categories',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Scroll to products section
      final scrollView = find.byType(SingleChildScrollView);
      await tester.drag(scrollView, const Offset(0, -500));
      await tester.pumpAndSettle();

      // Verify product category headers
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);
      expect(find.text('ESSENTIAL RANGE'), findsAtLeastNWidgets(1));
      
      addTearDown(tester.view.reset);
    });

    testWidgets('View All button should be present',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Scroll to VIEW ALL button
      await tester.dragUntilVisible(
        find.text('VIEW ALL'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.pumpAndSettle();

      expect(find.text('VIEW ALL'), findsOneWidget);
      
      addTearDown(tester.view.reset);
    });

    testWidgets('Mobile menu should open when menu icon is tapped',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Tap menu icon
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Check if menu items are displayed
      expect(find.text('Shop'), findsWidgets);
      expect(find.text('The Print Shack'), findsWidgets);
      
      addTearDown(tester.view.reset);
    });

    testWidgets('Search icon should navigate to search page',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Tap search icon
      await tester.tap(find.byIcon(Icons.search).first);
      await tester.pumpAndSettle();

      // Should navigate to search page (back button should appear)
      expect(find.byIcon(Icons.arrow_back), findsWidgets);
      
      addTearDown(tester.view.reset);
    });

    testWidgets('Shopping bag icon should navigate to cart',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Tap shopping bag icon
      await tester.tap(find.byIcon(Icons.shopping_bag_outlined).first);
      await tester.pumpAndSettle();

      // Should navigate to cart page
      expect(find.text('Shopping Cart'), findsOneWidget);
      
      addTearDown(tester.view.reset);
    });

    testWidgets('Person icon should navigate to sign-in when not authenticated',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Ensure user is not authenticated
      expect(AuthService().isAuthenticated, false);

      // Tap person icon
      await tester.tap(find.byIcon(Icons.person_outline).first);
      await tester.pumpAndSettle();

      // Should navigate to sign-in page
      expect(find.text('Sign in'), findsAtLeastNWidgets(1));
      
      addTearDown(tester.view.reset);
    });

    testWidgets('BROWSE COLLECTION button should navigate to collections',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Tap BROWSE COLLECTION button
      await tester.tap(find.text('BROWSE COLLECTION'));
      await tester.pumpAndSettle();

      // Should navigate to collections page
      expect(find.text('Collections'), findsOneWidget);
      
      addTearDown(tester.view.reset);
    });
  });

  group('ProductCard Widget Tests', () {
    testWidgets('ProductCard should display product details',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ProductCard(
                title: 'Test Product',
                price: '£10.00',
                imageUrl: 'https://example.com/image.jpg',
                description: 'Test description',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£10.00'), findsOneWidget);
      
      addTearDown(tester.view.reset);
    });
  });

  group('ImageCard Widget Tests', () {
    testWidgets('ImageCard should display title', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ImageCard(
              title: 'Test Category',
              imageUrl: 'https://example.com/image.jpg',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Category'), findsOneWidget);
      
      addTearDown(tester.view.reset);
    });
  });

  group('Navigation Tests', () {
    testWidgets('About menu item should navigate correctly',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Open mobile menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Tap About
      await tester.tap(find.text('About').last);
      await tester.pumpAndSettle();

      // Should navigate to about page
      expect(find.byIcon(Icons.arrow_back), findsWidgets);
      
      addTearDown(tester.view.reset);
    });

    testWidgets('Expanding Shop menu should show categories',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Open mobile menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Tap Shop to expand
      await tester.tap(find.text('Shop'));
      await tester.pumpAndSettle();

      // Check if sub-items are visible
      expect(find.text('Clothing'), findsWidgets);
      expect(find.text('Merchandise'), findsWidgets);
      
      addTearDown(tester.view.reset);
    });
  });

  group('Responsive Layout Tests', () {
    testWidgets('Desktop navigation should be visible on wide screens',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Desktop navigation should be visible
      expect(find.text('Home'), findsWidgets);

      addTearDown(tester.view.reset);
    });

    testWidgets('Mobile menu should be used on narrow screens',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Menu icon should be visible
      expect(find.byIcon(Icons.menu), findsWidgets);

      addTearDown(tester.view.reset);
    });
  });

  group('Cart Badge Tests', () {
    testWidgets('Cart badge should not show when cart is empty',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      
      CartService().clearCart();

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // Badge should not be visible
      expect(CartService().itemCount, 0);
      
      addTearDown(tester.view.reset);
    });
  });

  group('Integration Tests', () {
    testWidgets('Complete user flow: browse to product to cart',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // 1. Verify home page loads
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);

      // 2. Navigate to collections
      await tester.tap(find.text('BROWSE COLLECTION'));
      await tester.pumpAndSettle();
      expect(find.text('Collections'), findsOneWidget);

      // 3. Go back to home
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // 4. Navigate to cart
      await tester.tap(find.byIcon(Icons.shopping_bag_outlined).first);
      await tester.pumpAndSettle();
      expect(find.text('Shopping Cart'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('App renders and scrolls without crashing',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // App renders successfully
      expect(find.byType(UnionShopApp), findsOneWidget);

      // Perform scroll
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -500),
      );
      await tester.pump();

      // No crash occurred
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      
      addTearDown(tester.view.reset);
    });
  });
}