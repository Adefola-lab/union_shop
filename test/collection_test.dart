import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collection.dart';

void main() {
  group('CollectionPage Tests', () {
    testWidgets('Collection page should display', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(home: CollectionPage(collectionName: 'Test Collection')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Collection'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Filter controls should be visible', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(home: CollectionPage(collectionName: null)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Category'), findsWidgets);
      expect(find.text('Price Range'), findsWidgets);

      addTearDown(tester.view.reset);
    });

    testWidgets('Products should be displayed in grid', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(home: CollectionPage(collectionName: null)),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Tapping product should navigate', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: const CollectionPage(collectionName: null),
          onGenerateRoute: (settings) {
            if (settings.name == '/product') {
              return MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(child: Text('Product Page')),
                ),
              );
            }
            return null;
          },
        ),
      );
      await tester.pumpAndSettle();

      // Tap first product card
      final productCard = find.byType(GestureDetector).first;
      await tester.tap(productCard);
      await tester.pumpAndSettle();

      expect(find.text('Product Page'), findsOneWidget);

      addTearDown(tester.view.reset);
    });
  });
}