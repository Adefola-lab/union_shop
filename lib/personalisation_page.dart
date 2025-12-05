// lib/personalisation_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/cart_item.dart';

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  String _selectedLines = 'One Line of Text';
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  int _quantity = 1;

  final double _pricePerLine = 3.00;
  final int _maxCharsPerLine = 10;

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    super.dispose();
  }

  double get _totalPrice {
    int lineCount = _selectedLines == 'One Line of Text' ? 1 : 2;
    return lineCount * _pricePerLine * _quantity;
  }

  double get _unitPrice {
    int lineCount = _selectedLines == 'One Line of Text' ? 1 : 2;
    return lineCount * _pricePerLine;
  }

  void _addToCart() {
    if (_line1Controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter text for Line 1'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedLines == 'Two Lines of Text' &&
        _line2Controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter text for Line 2'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String personalisationText = _line1Controller.text;
    if (_selectedLines == 'Two Lines of Text') {
      personalisationText += ' | ${_line2Controller.text}';
    }

    final cartItem = CartItem(
      productId: 'personalisation-${DateTime.now().millisecondsSinceEpoch}',
      title: 'Personalisation - $_selectedLines',
      price: _unitPrice,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/The_Union_Print_Shack_Logo_-_smaller_1024x1024@2x.png?v=1760532830',
      quantity: _quantity,
      size: personalisationText,
      color: '',
    );

    CartService().addItem(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $_quantity personalisation(s) to cart'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ),
    );

    // Clear form
    setState(() {
      _line1Controller.clear();
      _line2Controller.clear();
      _quantity = 1;
      _selectedLines = 'One Line of Text';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'The UNION Shop',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black87),
            onPressed: () => Navigator.pushNamed(context, '/sign-in'),
          ),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_bag_outlined, color: Colors.black87),
                if (CartService().itemCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${CartService().itemCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 100 : 20,
                vertical: 40,
              ),
              child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Image
        Expanded(
          flex: 1,
          child: _buildProductImage(),
        ),
        const SizedBox(width: 80),
        // Right side - Form
        Expanded(
          flex: 1,
          child: _buildForm(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(),
        const SizedBox(height: 32),
        _buildForm(),
      ],
    );
  }

  Widget _buildProductImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          'https://images.unsplash.com/photo-1581655353564-df123a1eb820?auto=format&fit=crop&w=800&q=60',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 400,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.image_not_supported,
                    size: 48, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        const Text(
          'Personalisation',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),

        // Price
        Row(
          children: [
            Text(
              '£${_unitPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Tax included
        const Text(
          'Tax included.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 32),

        // Per Line Dropdown
        const Text(
          'Per Line: One Line of Text',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedLines,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'One Line of Text',
                  child: Text('One Line of Text'),
                ),
                DropdownMenuItem(
                  value: 'Two Lines of Text',
                  child: Text('Two Lines of Text'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedLines = value!;
                  if (value == 'One Line of Text') {
                    _line2Controller.clear();
                  }
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Personalisation Line 1
        const Text(
          'Personalisation Line 1:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _line1Controller,
          maxLength: _maxCharsPerLine,
          inputFormatters: [
            LengthLimitingTextInputFormatter(_maxCharsPerLine),
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF4d2963), width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            counterText: '${_line1Controller.text.length}/$_maxCharsPerLine',
          ),
          onChanged: (value) {
            setState(() {}); // Update counter
          },
        ),

        // Personalisation Line 2 (conditional)
        if (_selectedLines == 'Two Lines of Text') ...[
          const SizedBox(height: 24),
          const Text(
            'Personalisation Line 2:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _line2Controller,
            maxLength: _maxCharsPerLine,
            inputFormatters: [
              LengthLimitingTextInputFormatter(_maxCharsPerLine),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide:
                    const BorderSide(color: Color(0xFF4d2963), width: 2),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              counterText: '${_line2Controller.text.length}/$_maxCharsPerLine',
            ),
            onChanged: (value) {
              setState(() {}); // Update counter
            },
          ),
        ],

        const SizedBox(height: 24),

        // Quantity
        const Text(
          'Quantity',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 18),
                onPressed: _quantity > 1
                    ? () {
                        setState(() {
                          _quantity--;
                        });
                      }
                    : null,
              ),
              Expanded(
                child: Text(
                  '$_quantity',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 18),
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Total Price Display
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                '£${_totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4d2963),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Add to Cart Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 0,
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Information
        const Text(
          '£3 for one line of text! £5 for two!',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'One line of text is 10 characters.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Please ensure all spellings are correct before submitting your purchase as we will print your item with the exact wording you provide. We will not be responsible for any incorrect spellings printed onto your garment. Personalised items do not qualify for refunds.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Social Share Buttons
        Row(
          children: [
            _buildShareButton(
              icon: Icons.facebook,
              color: const Color(0xFF1877F2),
              label: 'SHARE',
            ),
            const SizedBox(width: 8),
            _buildShareButton(
              icon: Icons.flutter_dash,
              color: const Color(0xFF1DA1F2),
              label: 'TWEET',
            ),
            const SizedBox(width: 8),
            _buildShareButton(
              icon: Icons.push_pin,
              color: const Color(0xFFE60023),
              label: 'PIN IT',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShareButton(
      {required IconData icon, required Color color, required String label}) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label - Coming soon!')),
          );
        },
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black87,
          side: BorderSide(color: Colors.grey.shade300),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
