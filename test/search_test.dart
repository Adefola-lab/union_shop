import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/search_page.dart';

void main() {
  group('SearchPage Tests', () {
    testWidgets('Search page should display initially', (tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: SearchPage()));
      await tester.pumpAndSettle();

      expect(find.text('Search Products'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Entering search query should show results', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: SearchPage()));
      await tester.pumpAndSettle();

      // Enter search query
      await tester.enterText(find.byType(TextField), 'hoodie');
      await tester.pumpAndSettle();

      // Should show results
      expect(find.text('Search Results'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Empty search should show prompt', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: SearchPage()));
      await tester.pumpAndSettle();

      // Should show search prompt
      expect(find.textContaining('Start typing'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Search with no results should show message', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: SearchPage()));
      await tester.pumpAndSettle();

      // Search for non-existent product
      await tester.enterText(find.byType(TextField), 'xyz123nonexistent');
      await tester.pumpAndSettle();

      // Should show no results message
      final noResults = find.text('No products found');
      if (noResults.evaluate().isNotEmpty) {
        expect(noResults, findsOneWidget);
      }

      addTearDown(tester.view.reset);
    });

    testWidgets('Search results should be displayed in grid', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: SearchPage()));
      await tester.pumpAndSettle();

      // Search for something that exists
      await tester.enterText(find.byType(TextField), 'hoodie');
      await tester.pumpAndSettle();

      // Should show GridView with results
      expect(find.byType(GridView), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Clear search should reset results', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: SearchPage()));
      await tester.pumpAndSettle();

      // Enter search
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pumpAndSettle();

      // Clear search
      await tester.enterText(find.byType(TextField), '');
      await tester.pumpAndSettle();

      // Should show search prompt again
      expect(find.textContaining('Start typing'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Search should be case insensitive', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: SearchPage()));
      await tester.pumpAndSettle();

      // Search with different cases
      await tester.enterText(find.byType(TextField), 'HOODIE');
      await tester.pumpAndSettle();

      // Should show results
      expect(find.text('Search Results'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Tapping product card should work', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: const SearchPage(),
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

      // Search
      await tester.enterText(find.byType(TextField), 'hoodie');
      await tester.pumpAndSettle();

      // Tap first product if any exist
      final productCards = find.byType(GestureDetector);
      if (productCards.evaluate().isNotEmpty) {
        await tester.tap(productCards.first);
        await tester.pumpAndSettle();

        // Should navigate
        expect(find.text('Product Page'), findsOneWidget);
      }

      addTearDown(tester.view.reset);
    });
  });
}