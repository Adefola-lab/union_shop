class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> sizes;
  final List<String> colors;
  final bool inStock;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.inStock,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      sizes: List<String>.from(json['sizes']),
      colors: List<String>.from(json['colors']),
      inStock: json['inStock'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'sizes': sizes,
      'colors': colors,
      'inStock': inStock,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
