import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/cart_item.dart';

void main() {
  setUp(() {
    CartService().clearCart();
  });

  tearDown(() {
    CartService().clearCart();
  });

  group('CartService Tests', () {
    test('Cart should start empty', () {
      expect(CartService().itemCount, 0);
      expect(CartService().subtotal, 0.0);
      expect(CartService().total, 0.0);
    });

    test('Adding item should increase item count', () {
      final item = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 1,
      );

      CartService().addItem(item);

      expect(CartService().itemCount, 1);
      expect(CartService().subtotal, 10.0);
    });

    test('Adding same item should merge quantities', () {
      final item1 = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 2,
        size: 'M',
        color: 'Blue',
      );

      final item2 = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 3,
        size: 'M',
        color: 'Blue',
      );

      CartService().addItem(item1);
      CartService().addItem(item2);

      expect(CartService().itemCount, 5);
      expect(CartService().subtotal, 50.0);
    });

    test('Adding different variants should create separate items', () {
      final item1 = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 1,
        size: 'M',
        color: 'Blue',
      );

      final item2 = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 1,
        size: 'L',
        color: 'Blue',
      );

      CartService().addItem(item1);
      CartService().addItem(item2);

      expect(CartService().items.length, 2);
      expect(CartService().itemCount, 2);
    });

    test('Removing item should decrease count', () {
      final item = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 1,
      );

      CartService().addItem(item);
      CartService().removeItem(item.variantKey);

      expect(CartService().itemCount, 0);
      expect(CartService().items.isEmpty, true);
    });

    test('Updating quantity should work correctly', () {
      final item = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 1,
      );

      CartService().addItem(item);
      CartService().updateQuantity(item.variantKey, 5);

      expect(CartService().itemCount, 5);
      expect(CartService().subtotal, 50.0);
    });

    test('Shipping should be £4.99 when cart has items', () {
      final item = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 1,
      );

      CartService().addItem(item);

      expect(CartService().shipping, 4.99);
      expect(CartService().total, 14.99);
    });

    test('Shipping should be £0 when cart is empty', () {
      expect(CartService().shipping, 0.0);
      expect(CartService().total, 0.0);
    });

    test('Clear cart should remove all items', () {
      CartService().addItem(CartItem(
        productId: 'test-1',
        title: 'Test 1',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 2,
      ));

      CartService().addItem(CartItem(
        productId: 'test-2',
        title: 'Test 2',
        price: 15.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 1,
      ));

      CartService().clearCart();

      expect(CartService().items.isEmpty, true);
      expect(CartService().itemCount, 0);
    });
  });

  group('CartPage Widget Tests', () {
    testWidgets('Empty cart should show empty message', (tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;

      CartService().clearCart();

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('START SHOPPING'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Cart with items should display them', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      final item = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 2,
        size: 'M',
        color: 'Blue',
      );

      CartService().addItem(item);

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Size: M'), findsOneWidget);
      expect(find.text('Color: Blue'), findsOneWidget);

      addTearDown(tester.view.reset);
    });

    testWidgets('Quantity controls should work', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      final item = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 2,
      );

      CartService().addItem(item);

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      // Find and tap the increment button
      final incrementButton = find.byIcon(Icons.add).first;
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();

      expect(CartService().itemCount, 3);

      addTearDown(tester.view.reset);
    });

    testWidgets('Remove button should remove item', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      final item = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 1,
      );

      CartService().addItem(item);

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      // Find and tap remove button
      final removeButton = find.byIcon(Icons.delete_outline);
      await tester.tap(removeButton);
      await tester.pumpAndSettle();

      expect(CartService().itemCount, 0);

      addTearDown(tester.view.reset);
    });

    testWidgets('Checkout button should show dialog', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      final item = CartItem(
        productId: 'test-1',
        title: 'Test Product',
        price: 10.0,
        imageUrl: 'https://example.com/test.jpg',
        quantity: 1,
      );

      CartService().addItem(item);

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      // Tap checkout button
      await tester.tap(find.text('CHECKOUT'));
      await tester.pumpAndSettle();

      expect(find.text('Order Placed!'), findsOneWidget);

      addTearDown(tester.view.reset);
    });
  });
}
