// lib/models/cart_item.dart
class CartItem {
  final String productId;
  final String title;
  final double price;
  final String imageUrl;
  final String? size;
  final String? color;
  int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.size,
    this.color,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  String get variantKey => '$productId-$size-$color';
}
