import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/services/auth_service.dart';

void main() {
  setUp(() async {
    await AuthService().init();
    await AuthService().signOut();
    CartService().clearCart();
  });

  tearDown(() async {
    await AuthService().signOut();
    CartService().clearCart();
  });

  group('User Flow Integration Tests', () {
    testWidgets('Complete shopping flow', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // 1. Start on home page
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);

      // 2. Navigate to collections
      await tester.tap(find.text('BROWSE COLLECTION'));
      await tester.pumpAndSettle();
      expect(find.text('Collections'), findsOneWidget);

      // 3. Go back
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // 4. Open search
      await tester.tap(find.byIcon(Icons.search).first);
      await tester.pumpAndSettle();

      // 5. Search for product
      await tester.enterText(find.byType(TextField), 'hoodie');
      await tester.pumpAndSettle();

      // 6. Navigate to cart
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.shopping_bag_outlined).first);
      await tester.pumpAndSettle();

      expect(find.text('Shopping Cart'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Authentication flow', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // 1. Click person icon
      await tester.tap(find.byIcon(Icons.person_outline).first);
      await tester.pumpAndSettle();

      // 2. Should show sign-in page
      expect(find.text('Sign in'), findsAtLeastNWidgets(1));

      // 3. Switch to sign-up
      await tester.tap(find.text('Don\'t have an account? Sign up'));
      await tester.pumpAndSettle();

      // 4. Fill in form
      await tester.enterText(find.byType(TextField).at(0), 'Test User');
      await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(2), 'password123');
      await tester.pumpAndSettle();

      // 5. Sign up
      await tester.tap(find.text('Create Account'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 6. Should navigate to account page
      expect(find.text('My Account'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Personalization flow', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();

      // 1. Click personalisation button
      await tester.dragUntilVisible(
        find.text('CLICK HERE TO ADD TEXT!'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('CLICK HERE TO ADD TEXT!'));
      await tester.pumpAndSettle();

      // 2. Should show personalisation page
      expect(find.text('Personalisation'), findsOneWidget);

      // 3. Enter text
      await tester.enterText(find.byType(TextField).first, 'MY NAME');
      await tester.pumpAndSettle();

      // 4. Add to cart
      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      // 5. Verify item added
      expect(CartService().itemCount, greaterThan(0));

      addTearDown(tester.view.reset);
    });
  });
}