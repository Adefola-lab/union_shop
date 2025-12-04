import 'package:flutter/material.dart';
import 'models/product.dart';
import 'services/product_service.dart';

class CollectionPage extends StatefulWidget {
  final String? collectionName;

  const CollectionPage({super.key, this.collectionName});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String _selectedCategory = 'All products';
  String _selectedSort = 'featured';
  bool _showInStockOnly = false;
  int _currentPage = 1;
  final int _itemsPerPage = 6;

  List<Product> _filteredProducts = [];
  final List<String> _categories = ['All products'];

  @override
  void initState() {
    super.initState();
    _categories.addAll(ProductService.getAllCategories());

    // Set initial category based on collection name if provided
    if (widget.collectionName != null) {
      // Map collection names to categories if they exist
      if (_categories.contains(widget.collectionName)) {
        _selectedCategory = widget.collectionName!;
      }
    }

    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _filteredProducts = ProductService.getProducts(
        category: _selectedCategory,
        inStock: _showInStockOnly ? true : null,
        sortBy: _selectedSort,
      );
    });
  }

  int get _totalPages => (_filteredProducts.length / _itemsPerPage).ceil();

  List<Product> get _paginatedProducts {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    return _filteredProducts.sublist(
      startIndex,
      endIndex > _filteredProducts.length ? _filteredProducts.length : endIndex,
    );
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header (same as main)
            _buildHeader(context),

            // Collection Content
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: Column(
                    children: [
                      // Title - Use collection name or default
                      Text(
                        widget.collectionName ?? 'All Products',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.collectionName != null
                            ? 'Shop all products in ${widget.collectionName}'
                            : 'Shop all of this seasons must haves in one place!',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),

                      // Filter and Sort Row
                      Row(
                        children: [
                          // Filter by category
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'FILTER BY',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedCategory,
                                      isExpanded: true,
                                      items: _categories.map((category) {
                                        return DropdownMenuItem(
                                          value: category,
                                          child: Text(category),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedCategory = value!;
                                          _currentPage = 1;
                                          _loadProducts();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Sort by
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'SORT BY',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedSort,
                                      isExpanded: true,
                                      items: const [
                                        DropdownMenuItem(
                                            value: 'featured',
                                            child: Text('Featured')),
                                        DropdownMenuItem(
                                            value: 'price_low',
                                            child: Text('Price: Low to High')),
                                        DropdownMenuItem(
                                            value: 'price_high',
                                            child: Text('Price: High to Low')),
                                        DropdownMenuItem(
                                            value: 'name_asc',
                                            child: Text('Name: A-Z')),
                                        DropdownMenuItem(
                                            value: 'name_desc',
                                            child: Text('Name: Z-A')),
                                        DropdownMenuItem(
                                            value: 'newest',
                                            child: Text('Newest')),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedSort = value!;
                                          _currentPage = 1;
                                          _loadProducts();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),

                          // In Stock filter
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'IN STOCK',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _showInStockOnly,
                                    onChanged: (value) {
                                      setState(() {
                                        _showInStockOnly = value!;
                                        _currentPage = 1;
                                        _loadProducts();
                                      });
                                    },
                                  ),
                                  const Text('Only show in stock'),
                                ],
                              ),
                            ],
                          ),

                          const Spacer(),

                          // Product count
                          Text(
                            '${_filteredProducts.length} products',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 32),

                      // Product Grid
                      _filteredProducts.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(40),
                                child: Text(
                                  'No products found matching your criteria.',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: MediaQuery.of(context)
                                            .size
                                            .width >
                                        900
                                    ? 3
                                    : MediaQuery.of(context).size.width > 600
                                        ? 2
                                        : 1,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 32,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: _paginatedProducts.length,
                              itemBuilder: (context, index) {
                                final product = _paginatedProducts[index];
                                return _buildProductCard(product);
                              },
                            ),

                      // Pagination
                      if (_totalPages > 1) ...[
                        const SizedBox(height: 48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: _currentPage > 1
                                  ? () {
                                      setState(() {
                                        _currentPage--;
                                      });
                                    }
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            ...List.generate(_totalPages, (index) {
                              final pageNum = index + 1;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _currentPage = pageNum;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _currentPage == pageNum
                                        ? const Color(0xFF4d2963)
                                        : Colors.white,
                                    foregroundColor: _currentPage == pageNum
                                        ? Colors.white
                                        : Colors.black,
                                    side: BorderSide(
                                      color: _currentPage == pageNum
                                          ? const Color(0xFF4d2963)
                                          : Colors.grey.shade300,
                                    ),
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  child: Text('$pageNum'),
                                ),
                              );
                            }),
                            const SizedBox(width: 16),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: _currentPage < _totalPages
                                  ? () {
                                      setState(() {
                                        _currentPage++;
                                      });
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            // Footer (same as main)
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: {
            'title': product.title,
            'price': '£${product.price.toStringAsFixed(2)}',
            'imageUrl': product.imageUrl,
            'description': product.description,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.image_not_supported,
                              size: 64, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  if (!product.inStock)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'OUT OF STOCK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '£${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4d2963),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Same header as main page - copy from main.dart
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => navigateToHome(context),
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: 18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: 18,
                          height: 18,
                          child: const Center(
                              child: Icon(Icons.image_not_supported,
                                  color: Colors.grey)),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () => navigateToHome(context),
                        child: const Text('Home',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 14)),
                      ),
                      const SizedBox(width: 8),
                      PopupMenuButton<String>(
                        offset: const Offset(0, 40),
                        child: const TextButton(
                          onPressed: null,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Shop',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline)),
                              SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down,
                                  size: 16, color: Colors.black87),
                            ],
                          ),
                        ),
                        itemBuilder: (BuildContext context) => const [
                          PopupMenuItem<String>(
                              value: 'clothing', child: Text('Clothing')),
                          PopupMenuItem<String>(
                              value: 'merchandise', child: Text('Merchandise')),
                          PopupMenuItem<String>(
                              value: 'halloween',
                              child: Row(
                                  children: [Text('Halloween '), Text('🎃')])),
                          PopupMenuItem<String>(
                              value: 'signature',
                              child: Text('Signature & Essential Range')),
                          PopupMenuItem<String>(
                              value: 'portsmouth',
                              child: Text('Portsmouth City Collection')),
                          PopupMenuItem<String>(
                              value: 'pride',
                              child: Row(children: [
                                Text('Pride Collection '),
                                Text('🏳️‍🌈')
                              ])),
                          PopupMenuItem<String>(
                              value: 'graduation',
                              child: Row(
                                  children: [Text('Graduation '), Text('🎓')])),
                        ],
                        onSelected: (String value) =>
                            placeholderCallbackForButtons(),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: placeholderCallbackForButtons,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('The Print Shack',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14)),
                            SizedBox(width: 4),
                            Icon(Icons.keyboard_arrow_down,
                                size: 16, color: Colors.black87),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                          onPressed: placeholderCallbackForButtons,
                          child: const Text('SALE!',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14))),
                      const SizedBox(width: 8),
                      TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/about'),
                          child: const Text('About',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14))),
                      const SizedBox(width: 8),
                      TextButton(
                          onPressed: placeholderCallbackForButtons,
                          child: const Text('UPSU.net',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14))),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.search,
                              size: 18, color: Colors.grey),
                          onPressed: () => Navigator.pushNamed(context, '/search'),),
                      IconButton(
                          icon: const Icon(Icons.person_outline,
                              size: 18, color: Colors.grey),
                          onPressed: placeholderCallbackForButtons),
                      IconButton(
                          icon: const Icon(Icons.shopping_bag_outlined,
                              size: 18, color: Colors.grey),
                          onPressed: placeholderCallbackForButtons),
                      IconButton(
                          icon: const Icon(Icons.menu,
                              size: 18, color: Colors.grey),
                          onPressed: placeholderCallbackForButtons),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    // Same footer as main page - copy from main.dart
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      child: const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Text('Footer - Copy from main.dart',
              style: TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}
