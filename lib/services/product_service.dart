import '../models/product.dart';

class ProductService {
  static final List<Product> _allProducts = [
    // Essential Range - Only clothing from essential line
    Product(
      id: '14',
      title: 'Essential Range T-Shirt',
      description:
          'Basic essential t-shirt from our core range. Perfect for everyday wear.',
      price: 9.99,
      imageUrl:
          'https://images.unsplash.com/photo-1581655353564-df123a1eb820?auto=format&fit=crop&w=800&q=60',
      category: 'Essential Range',
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: ['White', 'Black', 'Grey'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 22)),
    ),
    Product(
      id: '16',
      title: 'Essential Range Hoodie',
      description:
          'Comfortable essential hoodie from our affordable core collection.',
      price: 20.00,
      imageUrl:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=800&q=60',
      category: 'Essential Range',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'Navy', 'Grey'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Product(
      id: '17',
      title: 'Essential Range Sweatshirt',
      description:
          'Classic essential sweatshirt. Soft and comfortable for daily wear.',
      price: 18.00,
      imageUrl:
          'https://images.unsplash.com/photo-1578587018452-892bacefd3f2?auto=format&fit=crop&w=800&q=60',
      category: 'Essential Range',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Grey', 'Black', 'White'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),

    // Signature Range - Premium clothing line
    Product(
      id: '6',
      title: 'Signature Range Hoodie',
      description:
          'Premium signature hoodie from our exclusive collection. Superior quality materials.',
      price: 32.99,
      imageUrl:
          'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&w=800&q=60',
      category: 'Signature Range',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Cream', 'Black', 'Purple'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Product(
      id: '18',
      title: 'Signature Range T-Shirt',
      description:
          'Premium quality signature t-shirt with exclusive university branding.',
      price: 14.99,
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=60',
      category: 'Signature Range',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['White', 'Black', 'Navy'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Product(
      id: '19',
      title: 'Signature Range Polo Shirt',
      description:
          'Elegant polo shirt from our signature collection. Perfect for formal occasions.',
      price: 24.99,
      imageUrl:
          'https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?auto=format&fit=crop&w=800&q=60',
      category: 'Signature Range',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Navy', 'White', 'Purple'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),

    // Clothing - General clothing items
    Product(
      id: '1',
      title: 'Classic Sweatshirt',
      description:
          'Our best selling Classic Sweatshirt. Available in 4 different colours. Soft, comfortable, 50% cotton and 50% polyester.',
      price: 23.00,
      imageUrl:
          'https://media.istockphoto.com/id/1090883146/photo/young-man-in-oversized-sweatshirt-isolated-on-textured-gray-wall-background.webp?a=1&b=1&s=612x612&w=0&k=20&c=fHiefEze07BKwfVKt1qru58XJmmOf7ZtMkdeqhMq9ac=',
      category: 'Clothing',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'Navy', 'Grey', 'White'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Product(
      id: '2',
      title: 'Classic T-Shirt',
      description:
          'Essential university t-shirt made from premium cotton. Perfect for everyday wear.',
      price: 11.00,
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=60',
      category: 'Clothing',
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: ['Black', 'White', 'Navy'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Product(
      id: '3',
      title: 'Classic Hoodie',
      description:
          'Premium quality hoodie with university branding. Perfect for autumn weather.',
      price: 25.00,
      imageUrl:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=800&q=60',
      category: 'Clothing',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'Grey', 'Purple'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Product(
      id: '20',
      title: 'University Jacket',
      description:
          'Stylish university jacket. Perfect for layering in cooler weather.',
      price: 45.00,
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=800&q=60',
      category: 'Clothing',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Navy', 'Black'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),

    // Winter Collection - Cold weather clothing
    Product(
      id: '21',
      title: 'Winter Puffer Jacket',
      description:
          'Warm insulated puffer jacket perfect for freezing temperatures. Water-resistant outer shell.',
      price: 65.00,
      imageUrl:
          'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?auto=format&fit=crop&w=800&q=60',
      category: 'Winter Collection',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'Navy', 'Grey'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Product(
      id: '22',
      title: 'Winter Scarf',
      description:
          'Cozy knitted scarf to keep you warm during cold winter days.',
      price: 15.99,
      imageUrl:
          'https://images.unsplash.com/photo-1520903920243-00d872a2d1c9?auto=format&fit=crop&w=800&q=60',
      category: 'Winter Collection',
      sizes: ['One Size'],
      colors: ['Navy', 'Grey', 'Purple'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Product(
      id: '23',
      title: 'Winter Beanie',
      description:
          'Warm knitted beanie hat with university logo. Essential winter accessory.',
      price: 12.99,
      imageUrl:
          'https://images.unsplash.com/photo-1576871337632-b9aef4c17ab9?auto=format&fit=crop&w=800&q=60',
      category: 'Winter Collection',
      sizes: ['One Size'],
      colors: ['Black', 'Navy', 'Grey'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Product(
      id: '24',
      title: 'Thermal Hoodie',
      description:
          'Extra thick thermal hoodie for maximum warmth in freezing conditions.',
      price: 38.00,
      imageUrl:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=800&q=60',
      category: 'Winter Collection',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'Grey'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),

    // Autumn Favourites - Mid-weight layering
    Product(
      id: '25',
      title: 'Autumn Cardigan',
      description:
          'Comfortable cardigan perfect for layering during cool autumn days.',
      price: 32.00,
      imageUrl:
          'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?auto=format&fit=crop&w=800&q=60',
      category: 'Autumn Favourites',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Brown', 'Grey', 'Navy'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    Product(
      id: '26',
      title: 'Autumn Flannel Shirt',
      description: 'Classic flannel shirt ideal for crisp autumn weather.',
      price: 28.00,
      imageUrl:
          'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?auto=format&fit=crop&w=800&q=60',
      category: 'Autumn Favourites',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Red', 'Blue', 'Green'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Product(
      id: '27',
      title: 'Autumn Hoodie',
      description:
          'Medium-weight hoodie perfect for transitioning into cooler weather.',
      price: 29.99,
      imageUrl:
          'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?auto=format&fit=crop&w=800&q=60',
      category: 'Autumn Favourites',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Orange', 'Brown', 'Navy'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Product(
      id: '28',
      title: 'Lightweight Jacket',
      description: 'Versatile lightweight jacket for autumn layering.',
      price: 42.00,
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=800&q=60',
      category: 'Autumn Favourites',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Navy', 'Olive', 'Black'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),

    // Spring Collection - Light layers
    Product(
      id: '29',
      title: 'Spring Rain Jacket',
      description: 'Lightweight waterproof jacket perfect for spring showers.',
      price: 48.00,
      imageUrl:
          'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?auto=format&fit=crop&w=800&q=60',
      category: 'Spring Collection',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Yellow', 'Navy', 'Green'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 9)),
    ),
    Product(
      id: '30',
      title: 'Spring Polo Shirt',
      description: 'Breathable polo shirt perfect for mild spring weather.',
      price: 22.00,
      imageUrl:
          'https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?auto=format&fit=crop&w=800&q=60',
      category: 'Spring Collection',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['White', 'Light Blue', 'Pink'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 11)),
    ),
    Product(
      id: '31',
      title: 'Spring Windbreaker',
      description: 'Light windbreaker to protect against spring breezes.',
      price: 35.00,
      imageUrl:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=800&q=60',
      category: 'Spring Collection',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Light Blue', 'White', 'Mint Green'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Product(
      id: '32',
      title: 'Spring Long Sleeve Tee',
      description: 'Comfortable long sleeve t-shirt for spring layering.',
      price: 18.00,
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=60',
      category: 'Spring Collection',
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: ['White', 'Navy', 'Pastel Pink'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),

    // Summer Essentials - Lightweight, breathable
    Product(
      id: '33',
      title: 'Summer Tank Top',
      description: 'Breathable tank top perfect for hot summer days.',
      price: 14.99,
      imageUrl:
          'https://images.unsplash.com/photo-1622445275463-afa2ab738c34?auto=format&fit=crop&w=800&q=60',
      category: 'Summer Essentials',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['White', 'Navy', 'Grey'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
    Product(
      id: '34',
      title: 'Summer Shorts',
      description: 'Comfortable athletic shorts for warm weather activities.',
      price: 24.99,
      imageUrl:
          'https://images.unsplash.com/photo-1591195853828-11db59a44f6b?auto=format&fit=crop&w=800&q=60',
      category: 'Summer Essentials',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Navy', 'Black', 'Grey'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Product(
      id: '35',
      title: 'Summer Cap',
      description: 'Lightweight cap to shield from the summer sun.',
      price: 16.00,
      imageUrl:
          'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?auto=format&fit=crop&w=800&q=60',
      category: 'Summer Essentials',
      sizes: ['One Size'],
      colors: ['White', 'Navy', 'Khaki'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
    ),
    Product(
      id: '36',
      title: 'Breathable T-Shirt',
      description: 'Ultra-light, moisture-wicking t-shirt for hot summer days.',
      price: 16.99,
      imageUrl:
          'https://images.unsplash.com/photo-1581655353564-df123a1eb820?auto=format&fit=crop&w=800&q=60',
      category: 'Summer Essentials',
      sizes: ['S', 'M', 'L', 'XL', 'XXL'],
      colors: ['White', 'Light Blue', 'Yellow'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 9)),
    ),

    // Merchandise - Non-clothing items
    Product(
      id: '4',
      title: 'University Mug',
      description: 'Keep your drinks hot with our branded ceramic mug.',
      price: 8.99,
      imageUrl:
          'https://images.unsplash.com/photo-1656360088907-5109c245851d?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWVyY2hhbmRpc2V8ZW58MHx8MHx8fDA%3D',
      category: 'Merchandise',
      sizes: ['One Size'],
      colors: ['White'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Product(
      id: '5',
      title: 'University Backpack',
      description:
          'Spacious backpack perfect for carrying all your essentials.',
      price: 35.00,
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=800&q=60',
      category: 'Merchandise',
      sizes: ['One Size'],
      colors: ['Black', 'Navy'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    Product(
      id: '11',
      title: 'University Notebook',
      description: 'Premium lined notebook for all your study needs.',
      price: 6.99,
      imageUrl:
          'https://images.unsplash.com/photo-1531346878377-a5be20888e57?auto=format&fit=crop&w=800&q=60',
      category: 'Merchandise',
      sizes: ['One Size'],
      colors: ['Various'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 18)),
    ),
    Product(
      id: '12',
      title: 'Water Bottle',
      description: 'Eco-friendly reusable water bottle with university logo.',
      price: 14.99,
      imageUrl:
          'https://images.unsplash.com/photo-1602143407151-7111542de6e8?auto=format&fit=crop&w=800&q=60',
      category: 'Merchandise',
      sizes: ['500ml'],
      colors: ['Navy', 'White', 'Black'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),

    // Portsmouth City Collection
    Product(
      id: '7',
      title: 'Portsmouth City Cap',
      description: 'Show your Portsmouth pride with this stylish cap.',
      price: 12.50,
      imageUrl:
          'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?auto=format&fit=crop&w=800&q=60',
      category: 'Portsmouth City Collection',
      sizes: ['One Size'],
      colors: ['Navy', 'Black'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Product(
      id: '15',
      title: 'Portsmouth City Lanyard',
      description: 'Branded lanyard featuring Portsmouth city design.',
      price: 4.99,
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1678837556054-cb0b59e83a7f?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bGFueWFyZHxlbnwwfHwwfHx8MA%3D%3D',
      category: 'Portsmouth City Collection',
      sizes: ['One Size'],
      colors: ['Navy'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
    ),

    // Pride Collection
    Product(
      id: '8',
      title: 'Pride Collection T-Shirt',
      description: 'Celebrate diversity with our Pride collection t-shirt.',
      price: 15.00,
      imageUrl:
          'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?auto=format&fit=crop&w=800&q=60',
      category: 'Pride Collection',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['White', 'Black'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),

    // Graduation
    Product(
      id: '9',
      title: 'Graduation Bear',
      description: 'Commemorative graduation teddy bear.',
      price: 18.99,
      imageUrl:
          'https://images.unsplash.com/photo-1530325553241-4f6e7690cf36?auto=format&fit=crop&w=800&q=60',
      category: 'Graduation',
      sizes: ['One Size'],
      colors: ['Brown'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Product(
      id: '13',
      title: 'Graduation Gown',
      description: 'Traditional graduation gown for your special day.',
      price: 45.00,
      imageUrl:
          'https://images.unsplash.com/photo-1559443065-db5f9290a1a7?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Z3JhZHVhdGlvbiUyMGdvd258ZW58MHx8MHx8fDA%3D',
      category: 'Graduation',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black'],
      inStock: true,
      createdAt: DateTime.now().subtract(const Duration(days: 35)),
    ),

    // Halloween
    Product(
      id: '10',
      title: 'Halloween Hoodie',
      description: 'Limited edition Halloween themed hoodie.',
      price: 28.00,
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1705883268316-e7270ceaffcf?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8aGFsb3dlZW4lMjBob29kaWV8ZW58MHx8MHx8fDA%3D',
      category: 'Halloween',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Orange', 'Black'],
      inStock: false,
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
    ),
  ];

  static List<String> getAllCategories() {
    return _allProducts.map((p) => p.category).toSet().toList()..sort();
  }

  static List<Product> getProducts({
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? inStock,
    String sortBy = 'featured',
  }) {
    var products = List<Product>.from(_allProducts);

    // Filter by category
    if (category != null && category != 'All products') {
      products = products.where((p) => p.category == category).toList();
    }

    // Filter by price range
    if (minPrice != null) {
      products = products.where((p) => p.price >= minPrice).toList();
    }
    if (maxPrice != null) {
      products = products.where((p) => p.price <= maxPrice).toList();
    }

    // Filter by stock
    if (inStock != null && inStock) {
      products = products.where((p) => p.inStock).toList();
    }

    // Sort products
    switch (sortBy) {
      case 'price_low':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'name_asc':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'name_desc':
        products.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'newest':
        products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'featured':
      default:
        // Keep original order for featured
        break;
    }

    return products;
  }

  static Product? getProductById(String id) {
    try {
      return _allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
