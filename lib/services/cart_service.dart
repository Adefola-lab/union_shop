// lib/services/cart_service.dart
import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  double get shipping => subtotal > 0 ? 4.99 : 0.0;

  double get total => subtotal + shipping;

  void addItem(CartItem item) {
    // Check if item with same variant already exists
    final existingIndex = _items.indexWhere(
      (i) => i.variantKey == item.variantKey,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(String variantKey) {
    _items.removeWhere((item) => item.variantKey == variantKey);
    notifyListeners();
  }

  void updateQuantity(String variantKey, int quantity) {
    final index = _items.indexWhere((item) => item.variantKey == variantKey);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}