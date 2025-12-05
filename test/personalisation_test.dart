import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/personalisation_page.dart';
import 'package:union_shop/services/cart_service.dart';

void main() {
  setUp(() {
    CartService().clearCart();
  });

  tearDown(() {
    CartService().clearCart();
  });

  group('PersonalisationPage Tests', () {
    testWidgets('Personalisation page should display', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: PersonalisationPage()));
      await tester.pumpAndSettle();

      expect(find.text('Personalisation'), findsOneWidget);
      expect(find.text('Personalisation Line 1:'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Dropdown should change number of lines', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: PersonalisationPage()));
      await tester.pumpAndSettle();

      // Initially only Line 1 should be visible
      expect(find.text('Personalisation Line 1:'), findsOneWidget);
      expect(find.text('Personalisation Line 2:'), findsNothing);

      // Tap dropdown
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Select two lines
      await tester.tap(find.text('Two Lines of Text').last);
      await tester.pumpAndSettle();

      // Now Line 2 should be visible
      expect(find.text('Personalisation Line 2:'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Character counter should update', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: PersonalisationPage()));
      await tester.pumpAndSettle();

      // Enter text
      await tester.enterText(find.byType(TextField).first, 'TEST');
      await tester.pumpAndSettle();

      // Counter should show 4/10
      expect(find.text('4/10'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Text should be limited to 10 characters', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: PersonalisationPage()));
      await tester.pumpAndSettle();

      // Try to enter more than 10 characters
      await tester.enterText(find.byType(TextField).first, '12345678901234567890');
      await tester.pumpAndSettle();

      // Should be limited to 10
      final textField = tester.widget<TextField>(find.byType(TextField).first);
      expect(textField.controller?.text.length, lessThanOrEqualTo(10));

      addTearDown(tester.view.reset);
    });

    testWidgets('Quantity controls should work', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: PersonalisationPage()));
      await tester.pumpAndSettle();

      // Initial quantity should be 1
      expect(find.text('1'), findsWidgets);

      // Tap increment
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Should be 2
      expect(find.text('2'), findsWidgets);

      addTearDown(tester.view.reset);
    });

    testWidgets('Add to cart should validate input', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: PersonalisationPage()));
      await tester.pumpAndSettle();

      // Try to add without text
      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      // Should show error snackbar
      expect(find.text('Please enter text for Line 1'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Add to cart with valid input should work', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: PersonalisationPage()));
      await tester.pumpAndSettle();

      // Enter text
      await tester.enterText(find.byType(TextField).first, 'TEST NAME');
      await tester.pumpAndSettle();

      // Add to cart
      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      // Should add to cart
      expect(CartService().itemCount, greaterThan(0));

      addTearDown(tester.view.reset);
    });

    testWidgets('Price should update based on lines', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: PersonalisationPage()));
      await tester.pumpAndSettle();

      // Initial price should be £3.00 (1 line)
      expect(find.text('£3.00'), findsWidgets);

      // Change to 2 lines
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Two Lines of Text').last);
      await tester.pumpAndSettle();

      // Price should be £6.00 (2 lines)
      expect(find.text('£6.00'), findsWidgets);

      addTearDown(tester.view.reset);
    });
  });
}